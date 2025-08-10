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
  String get networkConnectionFailed =>
      'Connection failed. Check your network.';

  @override
  String get authInvalidCredentials => 'Invalid login credentials provided.';

  @override
  String get authSessionExpired =>
      'Your session has expired. Please log in again.';

  @override
  String get noAuthenticatedUser =>
      'First time login user needs an active network.';

  @override
  String get noAuthenticatedUserOffline =>
      'The user hasn\'t been previously authenticated. Cannot login offline.';

  @override
  String get differentOfflineUser => 'Different authenticated user offline';

  @override
  String get accountDisabled =>
      'This account is disabled. contact Administrator for details.';

  @override
  String get databaseConnectionFailed => 'Failed to connect to the database.';

  @override
  String get databaseQueryFailed =>
      'Error occurred while querying the database.';

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
  String get confirmSyncFormData =>
      'Are you sure you want to sync the selected entities?';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'OK';

  @override
  String get finalData => 'Finalize the Data';

  @override
  String get discard => 'Discard';

  @override
  String get open => 'Open';

  @override
  String get openNewForm => 'New';

  @override
  String get errorOpeningNewForm => 'Error Opening New Form';

  @override
  String get markAsFinalData => 'Make form Final?';

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
  String get conformDeleteMsg =>
      'Are you sure you want to remove this section?';

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
  String get selectImageForColorExtraction =>
      'Select Image for Color Extraction';

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
  String get logoutNote =>
      'your data will not be deleted when you login back again';

  @override
  String get formContainsSomeErrors => 'Form contains some errors';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get fieldsWithErrorInfo => 'Fields with Error';

  @override
  String get reviewFormData => 'Review';

  @override
  String get checkFieldsLater => 'Not Now';

  @override
  String get makeFormFinalOrSaveBody =>
      'Make Form Final for Send to server, or save as draft!';

  @override
  String get deleteConfirmationMessage =>
      'Are you sure you want to delete this item?';

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
  String get developer => 'Hamza For NMCP Yemen';

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
  String get scanningIsUnsupportedOnThisDevice =>
      'Scanning is unsupported on this device';

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
  String get viewDetails => 'Details';

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
  String get assignedTeam => 'Team';

  @override
  String get managedTeams => 'Managed Teams';

  @override
  String get assignedAssignments => 'Assignments';

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
  String deleteSelected(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Delete',
      two: '2 Delete',
      one: '1 Delete',
      zero: 'No Elements selected',
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
  String get synced => 'Sync';

  @override
  String get toggleBetweenListAndCardView =>
      'Toggle between List and Card view';

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
  String get confirmationWarning =>
      'Changing response might result clearing data from dependent elements';

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
  String get dateOfBirth => 'DOB';

  @override
  String get yearsMonths => 'Y/M';

  @override
  String get days => 'Days';

  @override
  String get textHint => 'Enter a text';

  @override
  String get longTextHint => 'Enter a text';

  @override
  String get oneLetterFieldHint => 'Enter a Letter';

  @override
  String get numberFieldHint => 'Enter a number';

  @override
  String get unitIntervalFieldHint => 'Enter unit Interval';

  @override
  String get percentageFieldHint => 'Enter a Percentage';

  @override
  String get integerFieldHint => 'Enter an integer';

  @override
  String get positiveIntegerFieldHint => 'Enter a positive integer';

  @override
  String get negativeIntegerFieldHint => 'Enter a negative integer';

  @override
  String get integerOrZeroFieldHint => 'Enter an integer or zero';

  @override
  String get phoneNumberFieldHint => 'Enter a phone number';

  @override
  String get emailFieldHint => 'Enter An Email';

  @override
  String get urlFieldHint => 'Enter a URL';

  @override
  String get fileResourceFieldHint => 'Select A file';

  @override
  String get usernameFieldHint => 'Select a Username';

  @override
  String get ageFieldHint => 'Enter an Age';

  @override
  String get booleanFieldHint => 'Enter a Boolean';

  @override
  String get trueOnlyFieldHint => 'fieldHintText';

  @override
  String get orgunitFieldHint => 'Select an OrgUnit';

  @override
  String get dataFieldHint => 'Select a date';

  @override
  String get dataTimeFieldHint => 'Enter a Data time';

  @override
  String get referenceFieldHint => 'Select a reference';

  @override
  String get timeFieldHint => 'Select a Time';

  @override
  String get teamFieldHint => 'Select a Team';

  @override
  String get fullNameFieldHint => 'Enter a full name';

  @override
  String get selectMultiFieldHint => 'fieldHintText';

  @override
  String get selectOneFieldHint => 'Select One';

  @override
  String get yesOrNoFieldHint => 'Select Yes or No';

  @override
  String get scanCodeFieldHint => 'Scan Code';

  @override
  String get coordinatesFieldHint => 'Select Coordinates';

  @override
  String get imageFieldHint => 'Select an Image';

  @override
  String get progressFieldHint => 'fieldHintText';

  @override
  String get unknownValueType => 'Unknown Value Type';

  @override
  String get unsupportedValueType => 'Unsupported value type';

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
    return 'Bad certificate: $error';
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

  @override
  String noUserDetailsFetchedFromServer(Object error) {
    return 'user details not fetched from server: $error.';
  }

  @override
  String get noActivitiesYet => 'No activities yet';

  @override
  String get materialVersion => 'Material Version';

  @override
  String get syncSummaryLoadError => 'Sync Summary Load Error';

  @override
  String get noSyncsYet => 'No Syncs Yet';

  @override
  String get performFirstSync => 'Perform First Sync';

  @override
  String get successCount => 'Success Count';

  @override
  String get failureCount => 'Failure Count';

  @override
  String get close => 'Close';

  @override
  String get copyAll => 'Copy All';

  @override
  String get errorSummary => 'Error Summary';

  @override
  String get syncErrors => 'Sync Errors';

  @override
  String get viewErrors => 'View Errors';

  @override
  String get syncSummaryTitle => 'Sync Summary Title';

  @override
  String get projects => 'Projects';

  @override
  String get activities => 'Activities';

  @override
  String get formTemplates => 'Form Templates';

  @override
  String get dataSubmissions => 'Data Submissions';

  @override
  String get dataSubmission => 'Data Submission';

  @override
  String get assignments => 'Assignments';

  @override
  String get optionSets => 'Option Sets';

  @override
  String get options => 'Options';

  @override
  String get dataElements => 'Data Elements';

  @override
  String get orgUnits => 'Organisation Units';

  @override
  String get downloaded => 'Downloaded';

  @override
  String get currentOperations => 'Current Operations:';

  @override
  String get showLess => 'Show less';

  @override
  String get showMore => 'Show more';

  @override
  String get syncProgressDashboard => 'Sync Progress Dashboard';

  @override
  String get checkingSession => 'Checking session...';

  @override
  String get datarun => 'DATARUN';

  @override
  String get signingOutWarning =>
      'Signing out will discard any unsynced changes. Are you sure you want to log out?';

  @override
  String get logOutAnyway => 'LOG OUT ANYWAY';

  @override
  String get logOut => 'Log out?';

  @override
  String systemFilesAccessError(Object error) {
    return 'System Files Access Error: $error';
  }

  @override
  String connectionTimeout(Object error) {
    return 'Connection timeout: $error';
  }

  @override
  String sendTimeout(Object error) {
    return 'send timeout: $error';
  }

  @override
  String receiveTimeout(Object error) {
    return 'receive timeout: $error';
  }

  @override
  String badResponse(Object error) {
    return 'bad response: $error';
  }

  @override
  String connectionError(Object error) {
    return 'connection error: $error';
  }

  @override
  String get requestCancelled => 'request cancelled';

  @override
  String get actionNeedsConfirmation => 'confirm before proceed';

  @override
  String get noConnection => 'No connection';

  @override
  String get noConnectionMessage =>
      'Please check internet connection and try again.';

  @override
  String get generalErrorMessage =>
      'The application has encountered an unknown error.\'             \'Please try again later.';

  @override
  String get generalErrorTitle => 'Something went wrong';

  @override
  String get ouLevels => 'OU Levels';

  @override
  String submissionError(Object error) {
    return 'An Error Was Encountered during for submission:\n $error';
  }

  @override
  String get errorSubmittingForm => 'Error Submitting form';

  @override
  String get draft => 'Draft';

  @override
  String get finalized => 'Finalized';

  @override
  String get syncFailed => 'Sync Failed';

  @override
  String get cancelSyncing => 'Cancel Syncing';

  @override
  String get formPermissions => 'Permission';

  @override
  String get warning => 'Warning';

  @override
  String get selectMonth => 'Select Month';

  @override
  String get selectWeek => 'Select Week';

  @override
  String get selectYear => 'Select Year';

  @override
  String week(Object weekNum) {
    return 'Week $weekNum';
  }

  @override
  String ofYear(Object year) {
    return 'Of $year';
  }

  @override
  String get created => 'Created';

  @override
  String get modified => 'Modified';

  @override
  String get demoLogin => 'Demo Login';

  @override
  String get draftDataInstance => 'Draft Data Instance';

  @override
  String get initializingDataInstance => 'Initializing Data Instance';

  @override
  String get all => 'All';

  @override
  String get addAnItem => 'Add an Item';

  @override
  String get dateRange => 'Date Range';

  @override
  String get includeDeleted => 'Include deleted';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get today => 'Today';

  @override
  String get lastThreeDays => 'Last 3 Days';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get lastThreeMonths => 'Last 3 Months';

  @override
  String get thisYear => 'This Year';

  @override
  String get allDates => 'All Times';

  @override
  String get editView => 'Edit/View';

  @override
  String get view => 'View';

  @override
  String get userSavedInstances => 'User Saved Instances';

  @override
  String get openSpeedDial => 'Open Speed Dial';

  @override
  String get noItemsFound => 'No Items Found';

  @override
  String confirmDeleteItemsSelected(Object count) {
    return '$count items will be deleted, are you sure?';
  }

  @override
  String get fixedTableColumns => 'Fixed ِActions Columns';

  @override
  String get tableAppearance => 'Table Appearance';

  @override
  String get tableControl => 'Table Control';

  @override
  String get compactTable => 'Compact table';

  @override
  String get hideSyncedRows => 'Hide synced rows';
}
