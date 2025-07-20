import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_ar.dart';
import 'app_localization_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @networkTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get networkTimeout;

  /// No description provided for @networkConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed. Check your network.'**
  String get networkConnectionFailed;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid login credentials provided.'**
  String get authInvalidCredentials;

  /// No description provided for @authSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get authSessionExpired;

  /// No description provided for @noAuthenticatedUser.
  ///
  /// In en, this message translates to:
  /// **'First time login user needs an active network.'**
  String get noAuthenticatedUser;

  /// No description provided for @noAuthenticatedUserOffline.
  ///
  /// In en, this message translates to:
  /// **'The user hasn\'t been previously authenticated. Cannot login offline.'**
  String get noAuthenticatedUserOffline;

  /// No description provided for @differentOfflineUser.
  ///
  /// In en, this message translates to:
  /// **'Different authenticated user offline'**
  String get differentOfflineUser;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled. contact Administrator for details.'**
  String get accountDisabled;

  /// No description provided for @databaseConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to the database.'**
  String get databaseConnectionFailed;

  /// No description provided for @databaseQueryFailed.
  ///
  /// In en, this message translates to:
  /// **'Error occurred while querying the database.'**
  String get databaseQueryFailed;

  /// No description provided for @databaseInternalError.
  ///
  /// In en, this message translates to:
  /// **'Database returned an Error {error}.'**
  String databaseInternalError(Object error);

  /// No description provided for @syncError.
  ///
  /// In en, this message translates to:
  /// **'Error While Trying to Sync data {error}.'**
  String syncError(Object error);

  /// No description provided for @unexpected.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}.'**
  String unexpected(Object error);

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the form.'**
  String get validationError;

  /// No description provided for @apiError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while interacting with the API {error}.'**
  String apiError(Object error);

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Datarun'**
  String get appName;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show Password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide Password'**
  String get hidePassword;

  /// No description provided for @syncingConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Syncing Configuration'**
  String get syncingConfiguration;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Datarun Login'**
  String get login;

  /// No description provided for @configurationReady.
  ///
  /// In en, this message translates to:
  /// **'Configuration Ready'**
  String get configurationReady;

  /// No description provided for @syncingData.
  ///
  /// In en, this message translates to:
  /// **'Syncing Data'**
  String get syncingData;

  /// No description provided for @syncingEvents.
  ///
  /// In en, this message translates to:
  /// **'Syncing Events'**
  String get syncingEvents;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get password;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'user'**
  String get user;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @viewList.
  ///
  /// In en, this message translates to:
  /// **'View List'**
  String get viewList;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no forms available} =1{1 form available} =2{2 forms available} other{{count} forms available}}'**
  String form(num count);

  /// No description provided for @viewAvailableForms.
  ///
  /// In en, this message translates to:
  /// **'Expand to View Available Forms'**
  String get viewAvailableForms;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @enterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Username'**
  String get enterYourUsername;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Sync Form Data'**
  String get syncFormData;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sync the selected entities?'**
  String get confirmSyncFormData;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button label
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// ok button label
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Yes finalData button label
  ///
  /// In en, this message translates to:
  /// **'Finalize the Data'**
  String get finalData;

  /// discard button label
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// open button label
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// initial entity dialog info submit button label
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get openNewForm;

  /// Error message when opening new form
  ///
  /// In en, this message translates to:
  /// **'Error Opening New Form'**
  String get errorOpeningNewForm;

  /// confirmation mark as final data dialog body's message
  ///
  /// In en, this message translates to:
  /// **'Make form Final?'**
  String get markAsFinalData;

  /// notNow button label
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// send button label
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @nmcpYemen.
  ///
  /// In en, this message translates to:
  /// **'NMCP Yemen'**
  String get nmcpYemen;

  /// No description provided for @objectAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'objectAccessDenied'**
  String get objectAccessDenied;

  /// No description provided for @objectAccessClosed.
  ///
  /// In en, this message translates to:
  /// **'objectAccessClosed'**
  String get objectAccessClosed;

  /// No description provided for @noFormsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No forms available'**
  String get noFormsAvailable;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{ } =1{1 Year} =2{2 Years} few{{count} Years} other{{count} Years}}'**
  String year(num count);

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{ } =1{1 Month} =2{2 Months} few{{count} Years} other{{count} Months}}'**
  String month(num count);

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @orgUnitHelpText.
  ///
  /// In en, this message translates to:
  /// **'Select Org Unit'**
  String get orgUnitHelpText;

  /// No description provided for @orgUnitInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Org Unit'**
  String get orgUnitInputLabel;

  /// No description provided for @orgUnitDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Search for and Select OrgUnit'**
  String get orgUnitDialogTitle;

  /// No description provided for @searchOrgUnitsHelpText.
  ///
  /// In en, this message translates to:
  /// **'Search Org Units...'**
  String get searchOrgUnitsHelpText;

  /// No description provided for @submissionInitialData.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get submissionInitialData;

  /// No description provided for @submissionDataEntry.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get submissionDataEntry;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @middleName.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get middleName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @itemRemoved.
  ///
  /// In en, this message translates to:
  /// **'Item Removed'**
  String get itemRemoved;

  /// No description provided for @conformDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this section?'**
  String get conformDeleteMsg;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selected;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get thisFieldIsRequired;

  /// No description provided for @pleaseEnterAValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'enter a valid email address.'**
  String get pleaseEnterAValidEmailAddress;

  /// No description provided for @enterAValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number.'**
  String get enterAValidNumber;

  /// No description provided for @valueMustBeGreaterThanOrEqualToError.
  ///
  /// In en, this message translates to:
  /// **'The value must be greater than or equal to {error}.'**
  String valueMustBeGreaterThanOrEqualToError(Object error);

  /// No description provided for @valueMustBeLessThanOrEqualToError.
  ///
  /// In en, this message translates to:
  /// **'The value must be less than or equal to {error}.'**
  String valueMustBeLessThanOrEqualToError(Object error);

  /// No description provided for @maximumAllowedLengthIsError.
  ///
  /// In en, this message translates to:
  /// **'The maximum allowed length is {error}.'**
  String maximumAllowedLengthIsError(Object error);

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @fetchUpdates.
  ///
  /// In en, this message translates to:
  /// **'Sync Configuration'**
  String get fetchUpdates;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @userSettings.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettings;

  /// No description provided for @toggleBrightness.
  ///
  /// In en, this message translates to:
  /// **'Toggle Brightness'**
  String get toggleBrightness;

  /// No description provided for @selectColorTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Color Theme'**
  String get selectColorTheme;

  /// No description provided for @selectImageForColorExtraction.
  ///
  /// In en, this message translates to:
  /// **'Select Image for Color Extraction'**
  String get selectImageForColorExtraction;

  /// No description provided for @selectASeedColor.
  ///
  /// In en, this message translates to:
  /// **'Select a seed color'**
  String get selectASeedColor;

  /// No description provided for @selectAColorExtractionImage.
  ///
  /// In en, this message translates to:
  /// **'Select a color extraction image'**
  String get selectAColorExtractionImage;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @currentUsername.
  ///
  /// In en, this message translates to:
  /// **'Current username'**
  String get currentUsername;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logoutNote.
  ///
  /// In en, this message translates to:
  /// **'your data will not be deleted when you login back again'**
  String get logoutNote;

  /// No description provided for @formContainsSomeErrors.
  ///
  /// In en, this message translates to:
  /// **'Form contains some errors'**
  String get formContainsSomeErrors;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @fieldsWithErrorInfo.
  ///
  /// In en, this message translates to:
  /// **'Fields with Error'**
  String get fieldsWithErrorInfo;

  /// No description provided for @reviewFormData.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewFormData;

  /// No description provided for @checkFieldsLater.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get checkFieldsLater;

  /// No description provided for @makeFormFinalOrSaveBody.
  ///
  /// In en, this message translates to:
  /// **'Make Form Final for Send to server, or save as draft!'**
  String get makeFormFinalOrSaveBody;

  /// No description provided for @deleteConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get deleteConfirmationMessage;

  /// No description provided for @formSummaryView.
  ///
  /// In en, this message translates to:
  /// **'Form Summary View'**
  String get formSummaryView;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @noInternetAccess.
  ///
  /// In en, this message translates to:
  /// **'No internet access'**
  String get noInternetAccess;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'online!'**
  String get online;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @saveAndCheck.
  ///
  /// In en, this message translates to:
  /// **'Save and Check'**
  String get saveAndCheck;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @fieldContainErrors.
  ///
  /// In en, this message translates to:
  /// **'field Contain Errors'**
  String get fieldContainErrors;

  /// No description provided for @startingSync.
  ///
  /// In en, this message translates to:
  /// **'Starting sync...'**
  String get startingSync;

  /// No description provided for @serverUrl.
  ///
  /// In en, this message translates to:
  /// **'Server URL'**
  String get serverUrl;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @personInformation.
  ///
  /// In en, this message translates to:
  /// **'Person Information'**
  String get personInformation;

  /// No description provided for @loginUsername.
  ///
  /// In en, this message translates to:
  /// **'Login Username'**
  String get loginUsername;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @lastConfigurationSyncTime.
  ///
  /// In en, this message translates to:
  /// **'Sync Time'**
  String get lastConfigurationSyncTime;

  /// No description provided for @lastSyncStatus.
  ///
  /// In en, this message translates to:
  /// **'last sync status'**
  String get lastSyncStatus;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appInformation.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInformation;

  /// No description provided for @developerInformation.
  ///
  /// In en, this message translates to:
  /// **'Developer Information'**
  String get developerInformation;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Hamza For NMCP Yemen'**
  String get developer;

  /// No description provided for @developerInfoText.
  ///
  /// In en, this message translates to:
  /// **'info@nmcpye.org'**
  String get developerInfoText;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @internetIsConnected.
  ///
  /// In en, this message translates to:
  /// **'internet Is Connected'**
  String get internetIsConnected;

  /// No description provided for @noSyncYet.
  ///
  /// In en, this message translates to:
  /// **'No sync yet'**
  String get noSyncYet;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @everyTwoDays.
  ///
  /// In en, this message translates to:
  /// **'Every two days'**
  String get everyTwoDays;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @everyFifteenDays.
  ///
  /// In en, this message translates to:
  /// **'Every 15 days'**
  String get everyFifteenDays;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @syncInterval.
  ///
  /// In en, this message translates to:
  /// **'Sync Interval'**
  String get syncInterval;

  /// No description provided for @syncSettings.
  ///
  /// In en, this message translates to:
  /// **'Sync Settings'**
  String get syncSettings;

  /// No description provided for @saveAndEditNext.
  ///
  /// In en, this message translates to:
  /// **'Save and Edit Next'**
  String get saveAndEditNext;

  /// No description provided for @saveAndClose.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAndClose;

  /// No description provided for @saveAndAddAnother.
  ///
  /// In en, this message translates to:
  /// **'Add Another'**
  String get saveAndAddAnother;

  /// No description provided for @newItem.
  ///
  /// In en, this message translates to:
  /// **'New Item'**
  String get newItem;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// No description provided for @unsavedChangesWarning.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get unsavedChangesWarning;

  /// No description provided for @closeWithoutSaving.
  ///
  /// In en, this message translates to:
  /// **'Close without saving?'**
  String get closeWithoutSaving;

  /// No description provided for @scanYourCode.
  ///
  /// In en, this message translates to:
  /// **'Scan your code'**
  String get scanYourCode;

  /// No description provided for @barcodeQrScan.
  ///
  /// In en, this message translates to:
  /// **'Barcode/QR Code'**
  String get barcodeQrScan;

  /// No description provided for @acceptCode.
  ///
  /// In en, this message translates to:
  /// **'Accept code?'**
  String get acceptCode;

  /// No description provided for @scanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get scanBarcode;

  /// No description provided for @invalidScannedCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid scanned code!'**
  String get invalidScannedCode;

  /// No description provided for @rescan.
  ///
  /// In en, this message translates to:
  /// **'Rescan'**
  String get rescan;

  /// No description provided for @gtin.
  ///
  /// In en, this message translates to:
  /// **'GTIN'**
  String get gtin;

  /// No description provided for @batch.
  ///
  /// In en, this message translates to:
  /// **'Batch'**
  String get batch;

  /// No description provided for @serial.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get serial;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @productionDate.
  ///
  /// In en, this message translates to:
  /// **'Production Date'**
  String get productionDate;

  /// No description provided for @controllerNotReady.
  ///
  /// In en, this message translates to:
  /// **'Controller not ready.'**
  String get controllerNotReady;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @scanningIsUnsupportedOnThisDevice.
  ///
  /// In en, this message translates to:
  /// **'Scanning is unsupported on this device'**
  String get scanningIsUnsupportedOnThisDevice;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Generic Error'**
  String get genericError;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'dueDate'**
  String get dueDate;

  /// No description provided for @dueDay.
  ///
  /// In en, this message translates to:
  /// **'dueDay'**
  String get dueDay;

  /// No description provided for @scope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get scope;

  /// No description provided for @formsAssigned.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get formsAssigned;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get viewDetails;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @not_started.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get not_started;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get in_progress;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @rescheduled.
  ///
  /// In en, this message translates to:
  /// **'Rescheduled'**
  String get rescheduled;

  /// No description provided for @merged.
  ///
  /// In en, this message translates to:
  /// **'Merged'**
  String get merged;

  /// No description provided for @reassigned.
  ///
  /// In en, this message translates to:
  /// **'Reassigned'**
  String get reassigned;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @managed.
  ///
  /// In en, this message translates to:
  /// **'Managed'**
  String get managed;

  /// No description provided for @entity.
  ///
  /// In en, this message translates to:
  /// **'Entity'**
  String get entity;

  /// No description provided for @forms.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get forms;

  /// No description provided for @assignmentDetail.
  ///
  /// In en, this message translates to:
  /// **'Assignment Detail'**
  String get assignmentDetail;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @allocatedResources.
  ///
  /// In en, this message translates to:
  /// **'Allocated Resources'**
  String get allocatedResources;

  /// No description provided for @reportedResources.
  ///
  /// In en, this message translates to:
  /// **'Reported Resources'**
  String get reportedResources;

  /// No description provided for @errorOpeningForm.
  ///
  /// In en, this message translates to:
  /// **'Error Opening Form'**
  String get errorOpeningForm;

  /// No description provided for @noSubmissions.
  ///
  /// In en, this message translates to:
  /// **'No Submissions'**
  String get noSubmissions;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @toggleListTableView.
  ///
  /// In en, this message translates to:
  /// **'Toggle List/Table View'**
  String get toggleListTableView;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @assignedTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get assignedTeam;

  /// No description provided for @managedTeams.
  ///
  /// In en, this message translates to:
  /// **'Managed Teams'**
  String get managedTeams;

  /// No description provided for @assignedAssignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignedAssignments;

  /// No description provided for @managedAssignments.
  ///
  /// In en, this message translates to:
  /// **'Managed Assignments'**
  String get managedAssignments;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No Syncable submissions} =1{1 submission} =2{2 submissions} other{{count} submissions}}'**
  String syncSubmissions(num count);

  /// No description provided for @allSubmissions.
  ///
  /// In en, this message translates to:
  /// **'All Submissions'**
  String get allSubmissions;

  /// No description provided for @createdDate.
  ///
  /// In en, this message translates to:
  /// **'Created Date'**
  String get createdDate;

  /// No description provided for @lastmodifiedDate.
  ///
  /// In en, this message translates to:
  /// **'LastModified Date'**
  String get lastmodifiedDate;

  /// No description provided for @population.
  ///
  /// In en, this message translates to:
  /// **'Population'**
  String get population;

  /// No description provided for @households.
  ///
  /// In en, this message translates to:
  /// **'Households'**
  String get households;

  /// No description provided for @itns.
  ///
  /// In en, this message translates to:
  /// **'ITNs'**
  String get itns;

  /// No description provided for @selectForm.
  ///
  /// In en, this message translates to:
  /// **'Select Form'**
  String get selectForm;

  /// No description provided for @reported.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get reported;

  /// No description provided for @lastSync.
  ///
  /// In en, this message translates to:
  /// **'Last sync time'**
  String get lastSync;

  /// No description provided for @to_post.
  ///
  /// In en, this message translates to:
  /// **'Last Sync'**
  String get to_post;

  /// No description provided for @to_update.
  ///
  /// In en, this message translates to:
  /// **'Last Sync'**
  String get to_update;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get synced;

  /// No description provided for @toggleBetweenListAndCardView.
  ///
  /// In en, this message translates to:
  /// **'Toggle between List and Card view'**
  String get toggleBetweenListAndCardView;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @teams.
  ///
  /// In en, this message translates to:
  /// **'teams'**
  String get teams;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'{value} is Copied To Clipboard'**
  String copiedToClipboard(Object value);

  /// No description provided for @confirmationWarning.
  ///
  /// In en, this message translates to:
  /// **'Changing response might result clearing data from dependent elements'**
  String get confirmationWarning;

  /// No description provided for @restoreItem.
  ///
  /// In en, this message translates to:
  /// **'Restore Item'**
  String get restoreItem;

  /// No description provided for @deleteRestore.
  ///
  /// In en, this message translates to:
  /// **'Delete / Restore'**
  String get deleteRestore;

  /// No description provided for @fieldIsMandatory.
  ///
  /// In en, this message translates to:
  /// **'Field Is Mandatory'**
  String get fieldIsMandatory;

  /// No description provided for @validationErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Validation Error Message'**
  String get validationErrorMessage;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get deleteItem;

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy To Clipboard'**
  String get copyToClipboard;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading ...'**
  String get loading;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @noMoreItems.
  ///
  /// In en, this message translates to:
  /// **'No more items.'**
  String get noMoreItems;

  /// No description provided for @assignmentList.
  ///
  /// In en, this message translates to:
  /// **'Assignment List'**
  String get assignmentList;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get dateOfBirth;

  /// No description provided for @yearsMonths.
  ///
  /// In en, this message translates to:
  /// **'Y/M'**
  String get yearsMonths;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @textHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a text'**
  String get textHint;

  /// No description provided for @longTextHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a text'**
  String get longTextHint;

  /// No description provided for @oneLetterFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a Letter'**
  String get oneLetterFieldHint;

  /// No description provided for @numberFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get numberFieldHint;

  /// No description provided for @unitIntervalFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter unit Interval'**
  String get unitIntervalFieldHint;

  /// No description provided for @percentageFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a Percentage'**
  String get percentageFieldHint;

  /// No description provided for @integerFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an integer'**
  String get integerFieldHint;

  /// No description provided for @positiveIntegerFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive integer'**
  String get positiveIntegerFieldHint;

  /// No description provided for @negativeIntegerFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a negative integer'**
  String get negativeIntegerFieldHint;

  /// No description provided for @integerOrZeroFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an integer or zero'**
  String get integerOrZeroFieldHint;

  /// No description provided for @phoneNumberFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get phoneNumberFieldHint;

  /// No description provided for @emailFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter An Email'**
  String get emailFieldHint;

  /// No description provided for @urlFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a URL'**
  String get urlFieldHint;

  /// No description provided for @fileResourceFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select A file'**
  String get fileResourceFieldHint;

  /// No description provided for @usernameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select a Username'**
  String get usernameFieldHint;

  /// No description provided for @ageFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an Age'**
  String get ageFieldHint;

  /// No description provided for @booleanFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a Boolean'**
  String get booleanFieldHint;

  /// No description provided for @trueOnlyFieldHint.
  ///
  /// In en, this message translates to:
  /// **'fieldHintText'**
  String get trueOnlyFieldHint;

  /// No description provided for @orgunitFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select an OrgUnit'**
  String get orgunitFieldHint;

  /// No description provided for @dataFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get dataFieldHint;

  /// No description provided for @dataTimeFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a Data time'**
  String get dataTimeFieldHint;

  /// No description provided for @referenceFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select a reference'**
  String get referenceFieldHint;

  /// No description provided for @timeFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select a Time'**
  String get timeFieldHint;

  /// No description provided for @teamFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select a Team'**
  String get teamFieldHint;

  /// No description provided for @fullNameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a full name'**
  String get fullNameFieldHint;

  /// No description provided for @selectMultiFieldHint.
  ///
  /// In en, this message translates to:
  /// **'fieldHintText'**
  String get selectMultiFieldHint;

  /// No description provided for @selectOneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select One'**
  String get selectOneFieldHint;

  /// No description provided for @yesOrNoFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select Yes or No'**
  String get yesOrNoFieldHint;

  /// No description provided for @scanCodeFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Scan Code'**
  String get scanCodeFieldHint;

  /// No description provided for @coordinatesFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select Coordinates'**
  String get coordinatesFieldHint;

  /// No description provided for @imageFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Select an Image'**
  String get imageFieldHint;

  /// No description provided for @progressFieldHint.
  ///
  /// In en, this message translates to:
  /// **'fieldHintText'**
  String get progressFieldHint;

  /// No description provided for @unknownValueType.
  ///
  /// In en, this message translates to:
  /// **'Unknown Value Type'**
  String get unknownValueType;

  /// No description provided for @unsupportedValueType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported value type'**
  String get unsupportedValueType;

  /// No description provided for @noActiveDatabaseFound.
  ///
  /// In en, this message translates to:
  /// **'No active database found: {error}.'**
  String noActiveDatabaseFound(Object error);

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired: {error}.'**
  String sessionExpired(Object error);

  /// No description provided for @badCertificate.
  ///
  /// In en, this message translates to:
  /// **'Bad certificate: {error}'**
  String badCertificate(Object error);

  /// No description provided for @invalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data: {error}.'**
  String invalidData(Object error);

  /// No description provided for @badHttpRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad http request: {error}.'**
  String badHttpRequest(Object error);

  /// No description provided for @badRequestToEndPoint.
  ///
  /// In en, this message translates to:
  /// **'Bad request to end point: {error}.'**
  String badRequestToEndPoint(Object error);

  /// No description provided for @endPointNotFound.
  ///
  /// In en, this message translates to:
  /// **'end point Not found: {error}.'**
  String endPointNotFound(Object error);

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error: {error}.'**
  String serverError(Object error);

  /// No description provided for @unauthorizedAccessToEndPoint.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized Access to end point: {error}.'**
  String unauthorizedAccessToEndPoint(Object error);

  /// No description provided for @forbidden.
  ///
  /// In en, this message translates to:
  /// **'Forbidden: {error}.'**
  String forbidden(Object error);

  /// No description provided for @noUserDetailsFetchedFromServer.
  ///
  /// In en, this message translates to:
  /// **'user details not fetched from server: {error}.'**
  String noUserDetailsFetchedFromServer(Object error);

  /// No description provided for @noActivitiesYet.
  ///
  /// In en, this message translates to:
  /// **'No activities yet'**
  String get noActivitiesYet;

  /// No description provided for @materialVersion.
  ///
  /// In en, this message translates to:
  /// **'Material Version'**
  String get materialVersion;

  /// No description provided for @syncSummaryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Sync Summary Load Error'**
  String get syncSummaryLoadError;

  /// No description provided for @noSyncsYet.
  ///
  /// In en, this message translates to:
  /// **'No Syncs Yet'**
  String get noSyncsYet;

  /// No description provided for @performFirstSync.
  ///
  /// In en, this message translates to:
  /// **'Perform First Sync'**
  String get performFirstSync;

  /// No description provided for @successCount.
  ///
  /// In en, this message translates to:
  /// **'Success Count'**
  String get successCount;

  /// No description provided for @failureCount.
  ///
  /// In en, this message translates to:
  /// **'Failure Count'**
  String get failureCount;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @copyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy All'**
  String get copyAll;

  /// No description provided for @errorSummary.
  ///
  /// In en, this message translates to:
  /// **'Error Summary'**
  String get errorSummary;

  /// No description provided for @syncErrors.
  ///
  /// In en, this message translates to:
  /// **'Sync Errors'**
  String get syncErrors;

  /// No description provided for @viewErrors.
  ///
  /// In en, this message translates to:
  /// **'View Errors'**
  String get viewErrors;

  /// No description provided for @syncSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Summary Title'**
  String get syncSummaryTitle;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @formTemplates.
  ///
  /// In en, this message translates to:
  /// **'Form Templates'**
  String get formTemplates;

  /// No description provided for @dataSubmissions.
  ///
  /// In en, this message translates to:
  /// **'Data Submissions'**
  String get dataSubmissions;

  /// No description provided for @assignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignments;

  /// No description provided for @optionSets.
  ///
  /// In en, this message translates to:
  /// **'Option Sets'**
  String get optionSets;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @dataElements.
  ///
  /// In en, this message translates to:
  /// **'Data Elements'**
  String get dataElements;

  /// No description provided for @orgUnits.
  ///
  /// In en, this message translates to:
  /// **'Organisation Units'**
  String get orgUnits;

  /// No description provided for @downloaded.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get downloaded;

  /// No description provided for @currentOperations.
  ///
  /// In en, this message translates to:
  /// **'Current Operations:'**
  String get currentOperations;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @syncProgressDashboard.
  ///
  /// In en, this message translates to:
  /// **'Sync Progress Dashboard'**
  String get syncProgressDashboard;

  /// No description provided for @checkingSession.
  ///
  /// In en, this message translates to:
  /// **'Checking session...'**
  String get checkingSession;

  /// No description provided for @datarun.
  ///
  /// In en, this message translates to:
  /// **'DATARUN'**
  String get datarun;

  /// No description provided for @signingOutWarning.
  ///
  /// In en, this message translates to:
  /// **'Signing out will discard any unsynced changes. Are you sure you want to log out?'**
  String get signingOutWarning;

  /// No description provided for @logOutAnyway.
  ///
  /// In en, this message translates to:
  /// **'LOG OUT ANYWAY'**
  String get logOutAnyway;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logOut;

  /// No description provided for @systemFilesAccessError.
  ///
  /// In en, this message translates to:
  /// **'System Files Access Error: {error}'**
  String systemFilesAccessError(Object error);

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout: {error}'**
  String connectionTimeout(Object error);

  /// No description provided for @sendTimeout.
  ///
  /// In en, this message translates to:
  /// **'send timeout: {error}'**
  String sendTimeout(Object error);

  /// No description provided for @receiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'receive timeout: {error}'**
  String receiveTimeout(Object error);

  /// No description provided for @badResponse.
  ///
  /// In en, this message translates to:
  /// **'bad response: {error}'**
  String badResponse(Object error);

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'connection error: {error}'**
  String connectionError(Object error);

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'request cancelled'**
  String get requestCancelled;

  /// No description provided for @actionNeedsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'confirm before proceed'**
  String get actionNeedsConfirmation;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get noConnection;

  /// No description provided for @noConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check internet connection and try again.'**
  String get noConnectionMessage;

  /// No description provided for @generalErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The application has encountered an unknown error.\'             \'Please try again later.'**
  String get generalErrorMessage;

  /// No description provided for @generalErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get generalErrorTitle;

  /// No description provided for @ouLevels.
  ///
  /// In en, this message translates to:
  /// **'OU Levels'**
  String get ouLevels;

  /// No description provided for @submissionError.
  ///
  /// In en, this message translates to:
  /// **'An Error Was Encountered during for submission:\n {error}'**
  String submissionError(Object error);

  /// No description provided for @errorSubmittingForm.
  ///
  /// In en, this message translates to:
  /// **'Error Submitting form'**
  String get errorSubmittingForm;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @finalized.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get finalized;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync Failed'**
  String get syncFailed;

  /// No description provided for @cancelSyncing.
  ///
  /// In en, this message translates to:
  /// **'Cancel Syncing'**
  String get cancelSyncing;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
