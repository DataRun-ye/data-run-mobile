// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get networkTimeout => 'Request timed out. Please try again.';

  @override
  String get networkConnectionFailed => 'Connection failed. Check your network.';

  @override
  String get authInvalidCredentials => 'Invalid login credentials provided.';

  @override
  String get authSessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get noAuthenticatedUser => 'First time login user needs an active network.';

  @override
  String get noAuthenticatedUserOffline => 'The user hasn\'t been previously authenticated. Cannot login offline.';

  @override
  String get differentOfflineUser => 'Different authenticated user offline';

  @override
  String get accountDisabled => 'This account is disabled. contact Administrator for details.';

  @override
  String get databaseConnectionFailed => 'Failed to connect to the database.';

  @override
  String get databaseQueryFailed => 'Error occurred while querying the database.';

  @override
  String databaseInternalError(Object error) {
    return 'Database returned an Error $error.';
  }

  @override
  String syncError(Object error) {
    return 'Error While Trying to Sync data $error.';
  }

  @override
  String unexpected(Object error) {
    return 'Error: $error.';
  }

  @override
  String get validationError => 'Please correct the errors in the form.';

  @override
  String apiError(Object error) {
    return 'An error occurred while interacting with the API $error.';
  }

  @override
  String get appName => 'Datarun';

  @override
  String get showPassword => 'Show Password';

  @override
  String get hidePassword => 'Hide Password';

  @override
  String get syncingConfiguration => 'Syncing Configuration';

  @override
  String get login => 'Login';

  @override
  String get configurationReady => 'Configuration Ready';

  @override
  String get syncingData => 'Syncing Data';

  @override
  String get syncingEvents => 'Syncing Events';

  @override
  String get password => 'password';

  @override
  String get user => 'user';

  @override
  String get username => 'Username';

  @override
  String get viewList => 'View List';

  @override
  String get addNew => 'Add New';

  @override
  String form(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString forms available',
      two: '2 forms available',
      one: '1 form available',
      zero: 'no forms available',
    );
    return '$_temp0';
  }

  @override
  String get viewAvailableForms => 'Expand to View Available Forms';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get enterYourUsername => 'Enter Your Username';

  @override
  String get syncFormData => 'Sync Form Data';

  @override
  String get confirmSyncFormData => 'Are you sure you want to sync the selected entities?';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'OK';

  @override
  String get finalData => 'Final Data';

  @override
  String get discard => 'Discard';

  @override
  String get open => 'Open';

  @override
  String get openNewForm => 'New Submission';

  @override
  String get errorOpeningNewForm => 'Error Opening New Form';

  @override
  String get markAsFinalData => 'Make the form Final before exiting.';

  @override
  String get notNow => 'Not Now';

  @override
  String get send => 'Send';

  @override
  String get nmcpYemen => 'NMCP Yemen';

  @override
  String get objectAccessDenied => 'objectAccessDenied';

  @override
  String get objectAccessClosed => 'objectAccessClosed';

  @override
  String get noFormsAvailable => 'No forms available';

  @override
  String get months => 'Months';

  @override
  String get years => 'Years';

  @override
  String get and => 'And';

  @override
  String year(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Years',
      few: '$countString Years',
      two: '2 Years',
      one: '1 Year',
      zero: ' ',
    );
    return '$_temp0';
  }

  @override
  String month(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Months',
      few: '$countString Years',
      two: '2 Months',
      one: '1 Month',
      zero: ' ',
    );
    return '$_temp0';
  }

  @override
  String get version => 'Version';

  @override
  String get clear => 'Clear';

  @override
  String get accept => 'Accept';

  @override
  String get level => 'Level';

  @override
  String get orgUnitHelpText => 'Select Org Unit';

  @override
  String get orgUnitInputLabel => 'Select Org Unit';

  @override
  String get orgUnitDialogTitle => 'Search for and Select OrgUnit';

  @override
  String get searchOrgUnitsHelpText => 'Search Org Units...';

  @override
  String get submissionInitialData => 'Main';

  @override
  String get submissionDataEntry => 'Data';

  @override
  String get notifications => 'Notifications';

  @override
  String get fullName => 'Full Name';

  @override
  String get firstName => 'First Name';

  @override
  String get middleName => 'Middle Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get home => 'Home';

  @override
  String get itemRemoved => 'Item Removed';

  @override
  String get conformDeleteMsg => 'Are you sure you want to remove this section?';

  @override
  String get undo => 'Undo';

  @override
  String get selected => 'selected';

  @override
  String get thisFieldIsRequired => 'This field is required.';

  @override
  String get pleaseEnterAValidEmailAddress => 'enter a valid email address.';

  @override
  String get enterAValidNumber => 'Please enter a valid number.';

  @override
  String valueMustBeGreaterThanOrEqualToError(Object error) {
    return 'The value must be greater than or equal to $error.';
  }

  @override
  String valueMustBeLessThanOrEqualToError(Object error) {
    return 'The value must be less than or equal to $error.';
  }

  @override
  String maximumAllowedLengthIsError(Object error) {
    return 'The maximum allowed length is $error.';
  }

  @override
  String get logout => 'Logout';

  @override
  String get settings => 'Settings';

  @override
  String get fetchUpdates => 'Sync Configuration';

  @override
  String get appearance => 'Appearance';

  @override
  String get userSettings => 'User Settings';

  @override
  String get toggleBrightness => 'Toggle Brightness';

  @override
  String get selectColorTheme => 'Select Color Theme';

  @override
  String get selectImageForColorExtraction => 'Select Image for Color Extraction';

  @override
  String get selectASeedColor => 'Select a seed color';

  @override
  String get selectAColorExtractionImage => 'Select a color extraction image';

  @override
  String get organization => 'Organization';

  @override
  String get currentUsername => 'Current username';

  @override
  String get changePassword => 'Change Password';

  @override
  String get language => 'Language';

  @override
  String get logoutNote => 'your data will not be deleted when you login back again';

  @override
  String get formContainsSomeErrors => 'Form contains some errors';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get fieldsWithErrorInfo => 'Fields with Error';

  @override
  String get reviewFormData => 'Review Form';

  @override
  String get checkFieldsLater => 'Check Fields later';

  @override
  String get makeFormFinalOrSaveBody => 'Make Form Final for Send to server, or save as draft!';

  @override
  String get deleteConfirmationMessage => 'Are you sure you want to delete this item?';

  @override
  String get formSummaryView => 'Form Summary View';

  @override
  String get edit => 'Edit';

  @override
  String get noInternetAccess => 'No internet access';

  @override
  String get online => 'online!';

  @override
  String get empty => 'Empty';

  @override
  String get saveAndCheck => 'Save and Check';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get fieldContainErrors => 'field Contain Errors';

  @override
  String get startingSync => 'Starting sync...';

  @override
  String get serverUrl => 'Server URL';

  @override
  String get appVersion => 'App Version';

  @override
  String get personInformation => 'Person Information';

  @override
  String get loginUsername => 'Login Username';

  @override
  String get done => 'Done';

  @override
  String get failed => 'Failed';

  @override
  String get lastConfigurationSyncTime => 'Sync Time';

  @override
  String get lastSyncStatus => 'last sync status';

  @override
  String get about => 'About';

  @override
  String get appInformation => 'App Information';

  @override
  String get developerInformation => 'Developer Information';

  @override
  String get developer => 'NMCP Yemen';

  @override
  String get developerInfoText => 'info@nmcpye.org';

  @override
  String get preferences => 'Preferences';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get mobile => 'Mobile';

  @override
  String get openSettings => 'Open settings';

  @override
  String get internetIsConnected => 'internet Is Connected';

  @override
  String get noSyncYet => 'No sync yet';

  @override
  String get daily => 'Daily';

  @override
  String get everyTwoDays => 'Every two days';

  @override
  String get weekly => 'Weekly';

  @override
  String get everyFifteenDays => 'Every 15 days';

  @override
  String get monthly => 'Monthly';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get syncInterval => 'Sync Interval';

  @override
  String get syncSettings => 'Sync Settings';

  @override
  String get saveAndEditNext => 'Save and Edit Next';

  @override
  String get saveAndClose => 'Save';

  @override
  String get saveAndAddAnother => 'Add Another';

  @override
  String get newItem => 'New Item';

  @override
  String get editItem => 'Edit Item';

  @override
  String get unsavedChangesWarning => 'Unsaved changes';

  @override
  String get closeWithoutSaving => 'Close without saving?';

  @override
  String get scanYourCode => 'Scan your code';

  @override
  String get barcodeQrScan => 'Barcode/QR Code';

  @override
  String get acceptCode => 'Accept code?';

  @override
  String get scanBarcode => 'Scan barcode';

  @override
  String get invalidScannedCode => 'Invalid scanned code!';

  @override
  String get rescan => 'Rescan';

  @override
  String get gtin => 'GTIN';

  @override
  String get batch => 'Batch';

  @override
  String get serial => 'Serial';

  @override
  String get count => 'Count';

  @override
  String get productionDate => 'Production Date';

  @override
  String get controllerNotReady => 'Controller not ready.';

  @override
  String get permissionDenied => 'Permission denied';

  @override
  String get scanningIsUnsupportedOnThisDevice => 'Scanning is unsupported on this device';

  @override
  String get genericError => 'Generic Error';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get dueDate => 'dueDate';

  @override
  String get dueDay => 'dueDay';

  @override
  String get scope => 'Scope';

  @override
  String get formsAssigned => 'Forms';

  @override
  String get viewDetails => 'View Details';

  @override
  String get resources => 'Resources';

  @override
  String get team => 'Team';

  @override
  String get not_started => 'Not Started';

  @override
  String get in_progress => 'In Progress';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get completed => 'Completed';

  @override
  String get rescheduled => 'Rescheduled';

  @override
  String get merged => 'Merged';

  @override
  String get reassigned => 'Reassigned';

  @override
  String get assigned => 'Assigned';

  @override
  String get managed => 'Managed';

  @override
  String get entity => 'Entity';

  @override
  String get forms => 'Forms';

  @override
  String get assignmentDetail => 'Assignment Detail';

  @override
  String get activity => 'Activity';

  @override
  String get status => 'Status';

  @override
  String get allocatedResources => 'Allocated Resources';

  @override
  String get reportedResources => 'Reported Resources';

  @override
  String get errorOpeningForm => 'Error Opening Form';

  @override
  String get noSubmissions => 'No Submissions';

  @override
  String get search => 'Search...';

  @override
  String get day => 'Day';

  @override
  String get toggleListTableView => 'Toggle List/Table View';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get assignedTeam => 'Assigned Team';

  @override
  String get managedTeams => 'Managed Teams';

  @override
  String get assignedAssignments => 'Assigned Assignments';

  @override
  String get managedAssignments => 'Managed Assignments';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String syncSubmissions(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString submissions',
      two: '2 submissions',
      one: '1 submission',
      zero: 'No Syncable submissions',
    );
    return '$_temp0';
  }

  @override
  String get allSubmissions => 'All Submissions';

  @override
  String get createdDate => 'Created Date';

  @override
  String get lastmodifiedDate => 'LastModified Date';

  @override
  String get population => 'Population';

  @override
  String get households => 'Households';

  @override
  String get itns => 'ITNs';

  @override
  String get selectForm => 'Select Form';

  @override
  String get reported => 'Reported';

  @override
  String get lastSync => 'Last sync time';

  @override
  String get to_post => 'Last Sync';

  @override
  String get to_update => 'Last Sync';

  @override
  String get synced => 'Last Sync';

  @override
  String get toggleBetweenListAndCardView => 'Toggle between List and Card view';

  @override
  String get filters => 'Filters';

  @override
  String get reset => 'Reset';

  @override
  String get apply => 'Apply';

  @override
  String get teams => 'teams';

  @override
  String get clearAll => 'Clear All';

  @override
  String copiedToClipboard(Object value) {
    return '$value is Copied To Clipboard';
  }

  @override
  String get changingStateMightResultClearingDependentsElements => 'Changing state might result clearing dependents elements';

  @override
  String get restoreItem => 'Restore Item';

  @override
  String get deleteRestore => 'Delete / Restore';

  @override
  String get fieldIsMandatory => 'Field Is Mandatory';

  @override
  String get validationErrorMessage => 'Validation Error Message';

  @override
  String get deleteItem => 'Delete Item';

  @override
  String get copyToClipboard => 'Copy To Clipboard';

  @override
  String get loading => 'Loading ...';

  @override
  String get loadMore => 'Load More';

  @override
  String get noMoreItems => 'No more items.';

  @override
  String get assignmentList => 'Assignment List';

  @override
  String noActiveDatabaseFound(Object error) {
    return 'No active database found: $error.';
  }

  @override
  String sessionExpired(Object error) {
    return 'Session expired: $error.';
  }

  @override
  String badCertificate(Object error) {
    return 'Bad certificate: $error.';
  }

  @override
  String invalidData(Object error) {
    return 'Invalid data: $error.';
  }

  @override
  String badHttpRequest(Object error) {
    return 'Bad http request: $error.';
  }

  @override
  String badRequestToEndPoint(Object error) {
    return 'Bad request to end point: $error.';
  }

  @override
  String endPointNotFound(Object error) {
    return 'end point Not found: $error.';
  }

  @override
  String serverError(Object error) {
    return 'Server error: $error.';
  }

  @override
  String unauthorizedAccessToEndPoint(Object error) {
    return 'Unauthorized Access to end point: $error.';
  }

  @override
  String forbidden(Object error) {
    return 'Forbidden: $error.';
  }
}
