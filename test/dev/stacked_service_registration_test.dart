import 'package:datarunmobile/app/stacked/app.locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  test('registers only the Stacked services used by production paths',
      () async {
    await locator.reset();
    addTearDown(locator.reset);

    await setupLocator();

    expect(locator.isRegistered<NavigationService>(), isTrue);
    expect(locator.isRegistered<DialogService>(), isTrue);
    expect(locator.isRegistered<SnackbarService>(), isFalse);
    expect(locator.isRegistered<BottomSheetService>(), isFalse);
  });
}
