import 'package:d_sdk/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds backend-compatible metadata to new repeat rows', () {
    final normalized = RepeatMetadataNormalizer.normalizeFormData(
      {
        'households': [
          {
            'name': 'A',
            'children': [
              {'name': 'A1'},
            ],
          },
          {'name': 'B'},
        ],
        'choices': ['x', 'y'],
      },
      submissionUid: 'submission-1',
    );

    final households =
        (normalized['households'] as List).cast<Map<String, dynamic>>();
    final firstHousehold = households.first;
    final child =
        (firstHousehold['children'] as List).cast<Map<String, dynamic>>().first;

    expect(firstHousehold[RepeatMetadataNormalizer.idKey], isA<String>());
    expect(firstHousehold[RepeatMetadataNormalizer.idKey], hasLength(26));
    expect(firstHousehold[RepeatMetadataNormalizer.indexKey], 1);
    expect(
      firstHousehold[RepeatMetadataNormalizer.parentIdKey],
      'submission-1',
    );
    expect(
      firstHousehold[RepeatMetadataNormalizer.submissionUidKey],
      'submission-1',
    );
    expect(child[RepeatMetadataNormalizer.idKey], isA<String>());
    expect(child[RepeatMetadataNormalizer.idKey], hasLength(26));
    expect(
      child[RepeatMetadataNormalizer.parentIdKey],
      firstHousehold[RepeatMetadataNormalizer.idKey],
    );
    expect(child[RepeatMetadataNormalizer.indexKey], 1);
    expect(normalized['choices'], ['x', 'y']);
  });

  test('preserves existing ids and falls back from legacy repeatUid', () {
    final normalized = RepeatMetadataNormalizer.normalizeFormData(
      {
        'households': [
          {
            '_id': '01JABCDEF123456789ABCDEFG',
            '_index': 7,
            '_parentId': 'existing-parent',
            '_submissionUid': 'existing-submission',
            'name': 'Existing',
          },
          {
            'repeatUid': 'legacy-row-id',
            'name': 'Legacy',
          },
          {
            '_uid': 'legacy-server-id',
            'name': 'Legacy server',
          },
        ],
      },
      submissionUid: 'submission-1',
    );

    final rows =
        (normalized['households'] as List).cast<Map<String, dynamic>>();

    expect(
        rows[0][RepeatMetadataNormalizer.idKey], '01JABCDEF123456789ABCDEFG');
    expect(rows[0][RepeatMetadataNormalizer.indexKey], 7);
    expect(rows[0][RepeatMetadataNormalizer.parentIdKey], 'existing-parent');
    expect(
      rows[0][RepeatMetadataNormalizer.submissionUidKey],
      'existing-submission',
    );

    expect(rows[1][RepeatMetadataNormalizer.idKey], 'legacy-row-id');
    expect(rows[1][RepeatMetadataNormalizer.indexKey], 2);
    expect(rows[1][RepeatMetadataNormalizer.parentIdKey], 'submission-1');

    expect(rows[2][RepeatMetadataNormalizer.idKey], 'legacy-server-id');
    expect(rows[2][RepeatMetadataNormalizer.indexKey], 3);
    expect(rows[2][RepeatMetadataNormalizer.parentIdKey], 'submission-1');
  });

  test('is idempotent after generating repeat metadata', () {
    final firstPass = RepeatMetadataNormalizer.normalizeFormData(
      {
        'households': [
          {
            'name': 'A',
            'children': [
              {'name': 'A1'},
            ],
          },
        ],
      },
      submissionUid: 'submission-1',
    );

    final secondPass = RepeatMetadataNormalizer.normalizeFormData(
      firstPass,
      submissionUid: 'submission-1',
    );

    expect(secondPass, firstPass);
  });
}
