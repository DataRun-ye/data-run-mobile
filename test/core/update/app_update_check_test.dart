import 'package:datarunmobile/core/update/app_update_check.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update/in_app_update.dart';

void main() {
  AppUpdateAction decide({
    UpdateAvailability availability = UpdateAvailability.updateAvailable,
    InstallStatus installStatus = InstallStatus.unknown,
    int priority = 0,
    bool immediateAllowed = true,
    bool flexibleAllowed = true,
  }) =>
      decideAppUpdate(
        availability: availability,
        installStatus: installStatus,
        priority: priority,
        immediateAllowed: immediateAllowed,
        flexibleAllowed: flexibleAllowed,
      );

  test('an ordinary release is offered and can be dismissed', () {
    expect(decide(), AppUpdateAction.offer);
    expect(decide(priority: 3), AppUpdateAction.offer);
  });

  test('a release rolled out with priority 4 or 5 is required', () {
    expect(decide(priority: 4), AppUpdateAction.require);
    expect(decide(priority: 5), AppUpdateAction.require);
    expect(
      decide(priority: 5, immediateAllowed: false),
      AppUpdateAction.offer,
    );
  });

  test('a required update left unfinished is resumed', () {
    expect(
      decide(
          availability: UpdateAvailability.developerTriggeredUpdateInProgress),
      AppUpdateAction.require,
    );
  });

  test('a downloaded update asks to restart', () {
    expect(
      decide(
        availability: UpdateAvailability.updateNotAvailable,
        installStatus: InstallStatus.downloaded,
      ),
      AppUpdateAction.install,
    );
  });

  test('nothing happens without an update or when Play allows none', () {
    expect(
      decide(availability: UpdateAvailability.updateNotAvailable),
      AppUpdateAction.none,
    );
    expect(
      decide(availability: UpdateAvailability.unknown),
      AppUpdateAction.none,
    );
    expect(
      decide(immediateAllowed: false, flexibleAllowed: false),
      AppUpdateAction.none,
    );
  });
}
