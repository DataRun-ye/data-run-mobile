import 'dart:convert';

import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/di/injection.dart';
import 'package:d_sdk/service/manifest_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(scope: UserSession.activeSessionScope)
class ManifestService {
  // final http.Client httpClient;
  HttpClient get apiClient => rSdkLocator<HttpClient<dynamic>>();

  final ManifestRepository manifestRepository;

  ManifestService({required this.manifestRepository});

  /// Fetch manifest from server since optional ISO timestamp, persist locally.
  Future<void> fetchAndPersistManifest({DateTime? since}) async {
    final iso = since?.toUtc().toIso8601String();
    final uri =
        Uri.parse('/api/context/manifest${iso == null ? "" : "?since=$iso"}')
            .toString();

    const maxAttempts = 3;
    var attempt = 0;
    while (true) {
      attempt++;
      try {
        final resp = await apiClient
            .request(resourceName: '', path: uri, method: 'get', headers: {
          'Accept': 'application/json',
          // add auth header via httpClient wrapper or the client has interceptors
        }).timeout(const Duration(seconds: 20));

        if (resp.statusCode == 204) {
          // nothing changed — update sync timestamp
          await manifestRepository.recordManifestSync(DateTime.now().toUtc());
          return;
        }

        if (resp.statusCode != 200) {
          throw Exception(
              'Manifest fetch failed: ${resp.statusCode} ${resp.statusMessage}');
        }

        final Map<String, dynamic> payload =
            json.decode(resp.data) as Map<String, dynamic>;
        // Basic validation (minimal)
        if (!payload.containsKey('assignments')) {
          throw Exception('Manifest shape invalid: missing assignments');
        }

        // Persist to local DB (manifestRepository handles upserts/transactions)
        await manifestRepository.persistManifest(payload);

        // record successful sync
        await manifestRepository.recordManifestSync(DateTime.now().toUtc());
        return;
      } catch (e, st) {
        logError('manifest fetch attempt $attempt failed: $e', stackTrace: st);
        if (attempt >= maxAttempts) rethrow;
        // exponential backoff
        await Future.delayed(
            Duration(milliseconds: 500 * (1 << (attempt - 1))));
      }
    }
  }
}
