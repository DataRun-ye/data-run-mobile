import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/datasource/remote_data_sources/reference_entry_datasource.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-sync-test-user',
    );
  });

  tearDown(() => database.close());

  test('fetches fixed pages and persists each page without one full list',
      () async {
    final client = _FakeReferenceHttpClient(
      responseForPage: (page) => _pageResponse(
        page: page,
        totalPages: 3,
        itemCount: page < 2 ? 500 : 250,
      ),
    );
    final datasource = _datasource(database, client);

    final returned = await datasource.syncWithRemote();

    expect(returned, isEmpty);
    expect(client.requestedPages, [0, 1, 2]);
    expect(
      client.requestedResources,
      everyElement(contains('size=500')),
    );
    expect(
      await database.select(database.referenceEntries).get(),
      hasLength(1250),
    );
  });

  test('interrupted sync keeps completed pages and retry restarts at page zero',
      () async {
    var failSecondPage = true;
    final client = _FakeReferenceHttpClient(
      responseForPage: (page) {
        if (page == 1 && failSecondPage) {
          throw StateError('connection interrupted');
        }
        return _pageResponse(
          page: page,
          totalPages: 2,
          itemCount: 3,
        );
      },
    );
    final datasource = _datasource(database, client);

    await expectLater(
      datasource.syncWithRemote(),
      throwsA(isA<StateError>()),
    );
    expect(
      await database.select(database.referenceEntries).get(),
      hasLength(3),
    );
    final failedSummary =
        await database.select(database.syncSummaries).getSingle();
    expect(failedSummary.successCount, 3);
    expect(failedSummary.failureCount, 1);

    failSecondPage = false;
    client.clearRequests();
    await datasource.syncWithRemote();

    expect(client.requestedPages, [0, 1]);
    expect(
      await database.select(database.referenceEntries).get(),
      hasLength(6),
    );
    final successfulSummary =
        await database.select(database.syncSummaries).getSingle();
    expect(successfulSummary.successCount, 6);
    expect(successfulSummary.failureCount, 0);
    expect(successfulSummary.lastSuccessfulSync, isNotNull);
  });

  test('no eligible scope makes no request and completes successfully',
      () async {
    final client = _FakeReferenceHttpClient(
      responseForPage: (_) => throw StateError('must not fetch'),
    );
    final datasource = ReferenceEntryDatasource(
      database,
      client,
      repository: _FixedScopeRepository(database, const []),
    );

    await datasource.syncWithRemote();

    expect(client.requestedPages, isEmpty);
    final summary = await database.select(database.syncSummaries).getSingle();
    expect(summary.successCount, 0);
    expect(summary.failureCount, 0);
  });

  test('wrong-org response fails without moving or inserting identity',
      () async {
    final client = _FakeReferenceHttpClient(
      responseForPage: (page) => _pageResponse(
        page: page,
        totalPages: 1,
        itemCount: 1,
        orgUnitUid: 'org-2',
      ),
    );
    final datasource = _datasource(database, client);

    await expectLater(
      datasource.syncWithRemote(),
      throwsA(isA<ReferenceEntryScopeConflict>()),
    );
    expect(await database.select(database.referenceEntries).get(), isEmpty);
  });

  test('impossible paging metadata fails instead of truncating the catalog',
      () async {
    final client = _FakeReferenceHttpClient(
      responseForPage: (page) => _pageResponse(
        page: page,
        totalPages: 0,
        itemCount: 1,
      ),
    );
    final datasource = _datasource(database, client);

    await expectLater(
      datasource.syncWithRemote(),
      throwsFormatException,
    );
    expect(await database.select(database.referenceEntries).get(), isEmpty);
  });
}

ReferenceEntryDatasource _datasource(
  AppDatabase database,
  HttpClient<dynamic> client,
) {
  return ReferenceEntryDatasource(
    database,
    client,
    repository: _FixedScopeRepository(
      database,
      const [
        ReferenceCatalogScope(
          assignmentUid: 'assignment-1',
          orgUnitUid: 'org-1',
        ),
      ],
    ),
  );
}

Map<String, dynamic> _pageResponse({
  required int page,
  required int totalPages,
  required int itemCount,
  String orgUnitUid = 'org-1',
}) {
  return {
    'paged': true,
    'page': page,
    'totalPages': totalPages,
    'totalElements': totalPages * itemCount,
    'size': ReferenceEntryDatasource.pageSize,
    'referenceEntries': List.generate(itemCount, (index) {
      final numericId = page * ReferenceEntryDatasource.pageSize + index;
      return {
        'uid': 'r${numericId.toString().padLeft(10, '0')}',
        'name': 'Person Name Number Here $numericId',
        'orgUnitUid': orgUnitUid,
      };
    }),
  };
}

class _FixedScopeRepository extends ReferenceEntryRepository {
  _FixedScopeRepository(super.database, this.scopes);

  final List<ReferenceCatalogScope> scopes;

  @override
  Future<List<ReferenceCatalogScope>> findSyncScopes() async => scopes;
}

class _FakeReferenceHttpClient extends HttpClient<dynamic> {
  _FakeReferenceHttpClient({required this.responseForPage});

  final Map<String, dynamic> Function(int page) responseForPage;
  final List<int> requestedPages = [];
  final List<String> requestedResources = [];

  void clearRequests() {
    requestedPages.clear();
    requestedResources.clear();
  }

  @override
  Future<Response<dynamic>> request({
    required String resourceName,
    String? path,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    final match = RegExp(r'[?&]page=(\d+)').firstMatch(resourceName);
    final page = int.parse(match!.group(1)!);
    requestedPages.add(page);
    requestedResources.add(resourceName);
    return Response<dynamic>(
      data: responseForPage(page),
      statusCode: 200,
      requestOptions: RequestOptions(path: resourceName),
    );
  }
}
