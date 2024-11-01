import 'dart:async';

import 'package:d2_remote/core/datarun/utilities/date_utils.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:dio/dio.dart';
import 'package:mass_pro/commons/constants.dart';
import 'package:mass_pro/commons/logging/logging.dart';
import 'package:mass_pro/commons/network/network_utils.dart';
import 'package:mass_pro/commons/prefs/preference_provider.dart';
import 'package:mass_pro/commons/resources/resource_manager.dart';
import 'package:mass_pro/data_run/errors_management/error_management.dart';
import 'package:mass_pro/main/data/service/sync_presenter.dart';
import 'package:mass_pro/main/data/service/work_manager/nmc_worker/work_info.dart';
import 'package:mass_pro/main/data/service/work_manager/nmc_worker/worker.dart';

typedef OnProgressUpdate = Function(int progress);

class SyncMetadataWorker extends Worker {
  SyncMetadataWorker(this.ref,
      {required this.presenter,
      required this.prefs,
      required this.resourceManager});

  final SyncMetadataWorkerRef ref;
  final SyncPresenter presenter;

  final PreferenceProvider prefs;

  final ResourceManager resourceManager;

  @override
  Future<WorkInfo> doWork(
      {OnProgressUpdate? onProgressUpdate, Dio? dioTestClient}) async {
    final isAuth = await D2Remote.isAuthenticated();
    // if (await D2Remote.isAuthenticated()) {
      _triggerNotification(resourceManager.getString('appName'),
          resourceManager.getString('syncingConfiguration'), 0);

      bool isMetaOk = true;
      bool noNetwork = false;
      final StringBuffer message = StringBuffer();

      final int init = DateTime.now().microsecond;
      try {
        await presenter.syncMetadata(
          onProgressUpdate: (progress) {
            onProgressUpdate?.call(progress);
            _triggerNotification(resourceManager.getString('appName'),
                resourceManager.getString('syncingConfiguration'), progress);
          },
        );
      } catch (e) {
        logError(info: 'Timber.e($e)');
        isMetaOk = false;
        if (!ref.read(networkUtilsProvider).isOnline()) {
          noNetwork = true;
        }
        if (e is DException) {
          if (e is DError) {
            final DError error = e;
            message.write(_composeErrorMessageInfo(error));
          } else if (e.source != null && e.source is DError) {
            final DError error = e.source! as DError;
            message.write(_composeErrorMessageInfo(error));
          }
        } else {
          message.write(e.toString().split('\n\t')[0]);
        }
      } finally {
        presenter.logTimeToFinish(
            DateTime.now().microsecond - init, METADATA_TIME);
      }

      final String lastDataSyncDate =
          DateUtils.dateTimeFormat().format(DateTime.now());

      prefs.setValue(LAST_META_SYNC, lastDataSyncDate);
      prefs.setValue(LAST_META_SYNC_STATUS, isMetaOk);
      prefs.setValue(LAST_META_SYNC_NO_NETWORK, noNetwork);

      _cancelNotification();

      if (!isMetaOk) {
        return WorkInfo(
            state: WorkInfoState.FAILED, message: message.toString());
      }
      // return Result.failure(_createOutputData(false, message.toString()));

      presenter.startPeriodicMetaWork();

      return WorkInfo(
          state: WorkInfoState.SUCCEEDED, message: message.toString());
    // } else {
    //   return WorkInfo(
    //       state: WorkInfoState.FAILED,
    //       message: resourceManager.getString('error_init_session'));
    // }
  }

  String _errorStackTrace(Exception? exception) {
    if (exception == null) {
      return '';
    }
    // WriteBuffer writer = new WriteBuffer();
    // exception.printStackTrace(new PrintWriter(writer));
    // return writer.toString();
    return '';
  }

  StringBuffer _composeErrorMessageInfo(DError error) {
    final StringBuffer builder = StringBuffer('Cause: ');
    builder
      ..write(resourceManager.parseD2Error(error))
      ..write('\n\n')
      ..write('Exception: ')
      ..write((error.originalException.toString()).split('\n\t')[0])
      ..write('\n\n');

    if (error.created != null) {
      builder
        ..write('Created: ')
        ..write(error.created.toString())
        ..write('\n\n');
    }

    if (error.httpErrorCode != null) {
      builder
        ..write('Http Error Code: ')
        ..write(error.httpErrorCode)
        ..write('\n\n');
    }

    if (error.errorComponent != null) {
      builder
        ..write('Error component: ')
        ..write(error.errorComponent)
        ..write('\n\n');
    }

    if (error.url != null) {
      builder
        ..write('Url: ')
        ..write(error.url)
        ..write('\n\n');
    }

    builder
      ..write('StackTrace: ')
      ..write(_errorStackTrace(error).split('\n\t')[0])
      ..write('\n\n');

    return builder;
  }

  // Pair<WorkInfoState, String> _createOutputData(
  //     WorkInfoState state, String message) {
  //   return Pair<WorkInfoState, String>(state, message);
  //   // return Bundle()
  //   //   ..putBool(METADATA_STATE, state)
  //   //   ..putString(METADATA_MESSAGE, message);
  // }

  void _triggerNotification(String title, String content, int progress) {
    //     NotificationManager notificationManager = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
    //     if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
    //         NotificationChannel mChannel = new NotificationChannel(METADATA_CHANNEL, "MetadataSync", NotificationManager.IMPORTANCE_HIGH);
    //         notificationManager.createNotificationChannel(mChannel);
    //     }
    //     NotificationCompat.Builder notificationBuilder =
    //             new NotificationCompat.Builder(getApplicationContext(), METADATA_CHANNEL)
    //                     .setSmallIcon(drawable.ic_sync)
    //                     .setContentTitle(title)
    //                     .setContentText(content)
    //                     .setOngoing(true)
    //                     .setOnlyAlertOnce(true)
    //                     .setAutoCancel(false)
    //                     .setProgress(100, progress, false)
    //                     .setPriority(NotificationCompat.PRIORITY_DEFAULT);

    //     setForegroundAsync(new ForegroundInfo(SyncMetadataWorker.SYNC_METADATA_ID, notificationBuilder.build()));
    // }
  }

  void _cancelNotification() {
    // NotificationManagerCompat notificationManager =
    //         NotificationManagerCompat.from(getApplicationContext());
    // notificationManager.cancel(SYNC_METADATA_ID);
  }
}
