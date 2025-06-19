// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Request timed out. Please try again.`
  String get networkTimeout {
    return Intl.message(
      'Request timed out. Please try again.',
      name: 'networkTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Connection failed. Check your network.`
  String get networkConnectionFailed {
    return Intl.message(
      'Connection failed. Check your network.',
      name: 'networkConnectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid login credentials provided.`
  String get authInvalidCredentials {
    return Intl.message(
      'Invalid login credentials provided.',
      name: 'authInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again.`
  String get authSessionExpired {
    return Intl.message(
      'Your session has expired. Please log in again.',
      name: 'authSessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Credentials do not match authenticated user. Cannot login offline.`
  String get noAuthenticatedUser {
    return Intl.message(
      'Credentials do not match authenticated user. Cannot login offline.',
      name: 'noAuthenticatedUser',
      desc: '',
      args: [],
    );
  }

  /// `The user hasn't been previously authenticated. Cannot login offline.`
  String get noAuthenticatedUserOffline {
    return Intl.message(
      'The user hasn\'t been previously authenticated. Cannot login offline.',
      name: 'noAuthenticatedUserOffline',
      desc: '',
      args: [],
    );
  }

  /// `Different authenticated user offline`
  String get differentOfflineUser {
    return Intl.message(
      'Different authenticated user offline',
      name: 'differentOfflineUser',
      desc: '',
      args: [],
    );
  }

  /// `This account is disabled. contact Administrator for details.`
  String get accountDisabled {
    return Intl.message(
      'This account is disabled. contact Administrator for details.',
      name: 'accountDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Failed to connect to the database.`
  String get databaseConnectionFailed {
    return Intl.message(
      'Failed to connect to the database.',
      name: 'databaseConnectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while querying the database.`
  String get databaseQueryFailed {
    return Intl.message(
      'Error occurred while querying the database.',
      name: 'databaseQueryFailed',
      desc: '',
      args: [],
    );
  }

  /// `Database returned an Error {error}.`
  String databaseInternalError(Object error) {
    return Intl.message(
      'Database returned an Error $error.',
      name: 'databaseInternalError',
      desc: '',
      args: [error],
    );
  }

  /// `Error While Trying to Sync data {error}.`
  String syncError(Object error) {
    return Intl.message(
      'Error While Trying to Sync data $error.',
      name: 'syncError',
      desc: '',
      args: [error],
    );
  }

  /// `Error: {error}.`
  String unknownError(Object error) {
    return Intl.message(
      'Error: $error.',
      name: 'unknownError',
      desc: '',
      args: [error],
    );
  }

  /// `Please correct the errors in the form.`
  String get validationError {
    return Intl.message(
      'Please correct the errors in the form.',
      name: 'validationError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while interacting with the API {error}.`
  String apiError(Object error) {
    return Intl.message(
      'An error occurred while interacting with the API $error.',
      name: 'apiError',
      desc: '',
      args: [error],
    );
  }

  /// `Datarun`
  String get appName {
    return Intl.message('Datarun', name: 'appName', desc: '', args: []);
  }

  /// `Show Password`
  String get showPassword {
    return Intl.message(
      'Show Password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hide Password`
  String get hidePassword {
    return Intl.message(
      'Hide Password',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Syncing Configuration`
  String get syncingConfiguration {
    return Intl.message(
      'Syncing Configuration',
      name: 'syncingConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Configuration Ready`
  String get configurationReady {
    return Intl.message(
      'Configuration Ready',
      name: 'configurationReady',
      desc: '',
      args: [],
    );
  }

  /// `Syncing Data`
  String get syncingData {
    return Intl.message(
      'Syncing Data',
      name: 'syncingData',
      desc: '',
      args: [],
    );
  }

  /// `Syncing Events`
  String get syncingEvents {
    return Intl.message(
      'Syncing Events',
      name: 'syncingEvents',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message('password', name: 'password', desc: '', args: []);
  }

  /// `user`
  String get user {
    return Intl.message('user', name: 'user', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `View List`
  String get viewList {
    return Intl.message('View List', name: 'viewList', desc: '', args: []);
  }

  /// `Add New`
  String get addNew {
    return Intl.message('Add New', name: 'addNew', desc: '', args: []);
  }

  /// `{count, plural, =0{no forms available} =1{1 form available} =2{2 forms available} other{{count} forms available}}`
  String form(num count) {
    return Intl.plural(
      count,
      zero: 'no forms available',
      one: '1 form available',
      two: '2 forms available',
      other: '$count forms available',
      name: 'form',
      desc: 'A plural message',
      args: [count],
    );
  }

  /// `Expand to View Available Forms`
  String get viewAvailableForms {
    return Intl.message(
      'Expand to View Available Forms',
      name: 'viewAvailableForms',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Enter Your Username`
  String get enterYourUsername {
    return Intl.message(
      'Enter Your Username',
      name: 'enterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Sync Form Data`
  String get syncFormData {
    return Intl.message(
      'Sync Form Data',
      name: 'syncFormData',
      desc: 'Cancel button label',
      args: [],
    );
  }

  /// `Are you sure you want to sync the selected entities?`
  String get confirmSyncFormData {
    return Intl.message(
      'Are you sure you want to sync the selected entities?',
      name: 'confirmSyncFormData',
      desc: 'Cancel button label',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel button label',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: 'Confirm button label',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: 'ok button label', args: []);
  }

  /// `Final Data`
  String get finalData {
    return Intl.message(
      'Final Data',
      name: 'finalData',
      desc: 'Yes finalData button label',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: 'discard button label',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: 'open button label',
      args: [],
    );
  }

  /// `New Submission`
  String get openNewForm {
    return Intl.message(
      'New Submission',
      name: 'openNewForm',
      desc: 'initial entity dialog info submit button label',
      args: [],
    );
  }

  /// `Error Opening New Form`
  String get errorOpeningNewForm {
    return Intl.message(
      'Error Opening New Form',
      name: 'errorOpeningNewForm',
      desc: 'Error message when opening new form',
      args: [],
    );
  }

  /// `Make the form Final before exiting.`
  String get markAsFinalData {
    return Intl.message(
      'Make the form Final before exiting.',
      name: 'markAsFinalData',
      desc: 'confirmation mark as final data dialog body\'s message',
      args: [],
    );
  }

  /// `Not Now`
  String get notNow {
    return Intl.message(
      'Not Now',
      name: 'notNow',
      desc: 'notNow button label',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'send button label',
      args: [],
    );
  }

  /// `NMCP Yemen`
  String get nmcpYemen {
    return Intl.message('NMCP Yemen', name: 'nmcpYemen', desc: '', args: []);
  }

  /// `objectAccessDenied`
  String get objectAccessDenied {
    return Intl.message(
      'objectAccessDenied',
      name: 'objectAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `objectAccessClosed`
  String get objectAccessClosed {
    return Intl.message(
      'objectAccessClosed',
      name: 'objectAccessClosed',
      desc: '',
      args: [],
    );
  }

  /// `No forms available`
  String get noFormsAvailable {
    return Intl.message(
      'No forms available',
      name: 'noFormsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get months {
    return Intl.message('Months', name: 'months', desc: '', args: []);
  }

  /// `Years`
  String get years {
    return Intl.message('Years', name: 'years', desc: '', args: []);
  }

  /// `And`
  String get and {
    return Intl.message('And', name: 'and', desc: '', args: []);
  }

  /// `{count, plural, =0{ } =1{1 Year} =2{2 Years} few{{count} Years} other{{count} Years}}`
  String year(num count) {
    return Intl.plural(
      count,
      zero: ' ',
      one: '1 Year',
      two: '2 Years',
      few: '$count Years',
      other: '$count Years',
      name: 'year',
      desc: 'A plural message',
      args: [count],
    );
  }

  /// `{count, plural, =0{ } =1{1 Month} =2{2 Months} few{{count} Years} other{{count} Months}}`
  String month(num count) {
    return Intl.plural(
      count,
      zero: ' ',
      one: '1 Month',
      two: '2 Months',
      few: '$count Years',
      other: '$count Months',
      name: 'month',
      desc: 'A plural message',
      args: [count],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Level`
  String get level {
    return Intl.message('Level', name: 'level', desc: '', args: []);
  }

  /// `Select Org Unit`
  String get orgUnitHelpText {
    return Intl.message(
      'Select Org Unit',
      name: 'orgUnitHelpText',
      desc: '',
      args: [],
    );
  }

  /// `Select Org Unit`
  String get orgUnitInputLabel {
    return Intl.message(
      'Select Org Unit',
      name: 'orgUnitInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search for and Select OrgUnit`
  String get orgUnitDialogTitle {
    return Intl.message(
      'Search for and Select OrgUnit',
      name: 'orgUnitDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search Org Units...`
  String get searchOrgUnitsHelpText {
    return Intl.message(
      'Search Org Units...',
      name: 'searchOrgUnitsHelpText',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get submissionInitialData {
    return Intl.message(
      'Main',
      name: 'submissionInitialData',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get submissionDataEntry {
    return Intl.message(
      'Data',
      name: 'submissionDataEntry',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Middle Name`
  String get middleName {
    return Intl.message('Middle Name', name: 'middleName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Item Removed`
  String get itemRemoved {
    return Intl.message(
      'Item Removed',
      name: 'itemRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this section?`
  String get conformDeleteMsg {
    return Intl.message(
      'Are you sure you want to remove this section?',
      name: 'conformDeleteMsg',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
  }

  /// `selected`
  String get selected {
    return Intl.message('selected', name: 'selected', desc: '', args: []);
  }

  /// `This field is required.`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required.',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `enter a valid email address.`
  String get pleaseEnterAValidEmailAddress {
    return Intl.message(
      'enter a valid email address.',
      name: 'pleaseEnterAValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number.`
  String get enterAValidNumber {
    return Intl.message(
      'Please enter a valid number.',
      name: 'enterAValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `The value must be greater than or equal to {error}.`
  String valueMustBeGreaterThanOrEqualToError(Object error) {
    return Intl.message(
      'The value must be greater than or equal to $error.',
      name: 'valueMustBeGreaterThanOrEqualToError',
      desc: '',
      args: [error],
    );
  }

  /// `The value must be less than or equal to {error}.`
  String valueMustBeLessThanOrEqualToError(Object error) {
    return Intl.message(
      'The value must be less than or equal to $error.',
      name: 'valueMustBeLessThanOrEqualToError',
      desc: '',
      args: [error],
    );
  }

  /// `The maximum allowed length is {error}.`
  String maximumAllowedLengthIsError(Object error) {
    return Intl.message(
      'The maximum allowed length is $error.',
      name: 'maximumAllowedLengthIsError',
      desc: '',
      args: [error],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Sync Configuration`
  String get fetchUpdates {
    return Intl.message(
      'Sync Configuration',
      name: 'fetchUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `User Settings`
  String get userSettings {
    return Intl.message(
      'User Settings',
      name: 'userSettings',
      desc: '',
      args: [],
    );
  }

  /// `Toggle Brightness`
  String get toggleBrightness {
    return Intl.message(
      'Toggle Brightness',
      name: 'toggleBrightness',
      desc: '',
      args: [],
    );
  }

  /// `Select Color Theme`
  String get selectColorTheme {
    return Intl.message(
      'Select Color Theme',
      name: 'selectColorTheme',
      desc: '',
      args: [],
    );
  }

  /// `Select Image for Color Extraction`
  String get selectImageForColorExtraction {
    return Intl.message(
      'Select Image for Color Extraction',
      name: 'selectImageForColorExtraction',
      desc: '',
      args: [],
    );
  }

  /// `Select a seed color`
  String get selectASeedColor {
    return Intl.message(
      'Select a seed color',
      name: 'selectASeedColor',
      desc: '',
      args: [],
    );
  }

  /// `Select a color extraction image`
  String get selectAColorExtractionImage {
    return Intl.message(
      'Select a color extraction image',
      name: 'selectAColorExtractionImage',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get organization {
    return Intl.message(
      'Organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Current username`
  String get currentUsername {
    return Intl.message(
      'Current username',
      name: 'currentUsername',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `your data will not be deleted when you login back again`
  String get logoutNote {
    return Intl.message(
      'your data will not be deleted when you login back again',
      name: 'logoutNote',
      desc: '',
      args: [],
    );
  }

  /// `Form contains some errors`
  String get formContainsSomeErrors {
    return Intl.message(
      'Form contains some errors',
      name: 'formContainsSomeErrors',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: '', args: []);
  }

  /// `Fields with Error`
  String get fieldsWithErrorInfo {
    return Intl.message(
      'Fields with Error',
      name: 'fieldsWithErrorInfo',
      desc: '',
      args: [],
    );
  }

  /// `Review Form`
  String get reviewFormData {
    return Intl.message(
      'Review Form',
      name: 'reviewFormData',
      desc: '',
      args: [],
    );
  }

  /// `Check Fields later`
  String get checkFieldsLater {
    return Intl.message(
      'Check Fields later',
      name: 'checkFieldsLater',
      desc: '',
      args: [],
    );
  }

  /// `Make Form Final for Send to server, or save as draft!`
  String get makeFormFinalOrSaveBody {
    return Intl.message(
      'Make Form Final for Send to server, or save as draft!',
      name: 'makeFormFinalOrSaveBody',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get deleteConfirmationMessage {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'deleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Form Summary View`
  String get formSummaryView {
    return Intl.message(
      'Form Summary View',
      name: 'formSummaryView',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `No internet access`
  String get noInternetAccess {
    return Intl.message(
      'No internet access',
      name: 'noInternetAccess',
      desc: '',
      args: [],
    );
  }

  /// `online!`
  String get online {
    return Intl.message('online!', name: 'online', desc: '', args: []);
  }

  /// `Empty`
  String get empty {
    return Intl.message('Empty', name: 'empty', desc: '', args: []);
  }

  /// `Save and Check`
  String get saveAndCheck {
    return Intl.message(
      'Save and Check',
      name: 'saveAndCheck',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `field Contain Errors`
  String get fieldContainErrors {
    return Intl.message(
      'field Contain Errors',
      name: 'fieldContainErrors',
      desc: '',
      args: [],
    );
  }

  /// `Starting sync...`
  String get startingSync {
    return Intl.message(
      'Starting sync...',
      name: 'startingSync',
      desc: '',
      args: [],
    );
  }

  /// `Server URL`
  String get serverUrl {
    return Intl.message('Server URL', name: 'serverUrl', desc: '', args: []);
  }

  /// `App Version`
  String get appVersion {
    return Intl.message('App Version', name: 'appVersion', desc: '', args: []);
  }

  /// `Person Information`
  String get personInformation {
    return Intl.message(
      'Person Information',
      name: 'personInformation',
      desc: '',
      args: [],
    );
  }

  /// `Login Username`
  String get loginUsername {
    return Intl.message(
      'Login Username',
      name: 'loginUsername',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Failed`
  String get failed {
    return Intl.message('Failed', name: 'failed', desc: '', args: []);
  }

  /// `Sync Time`
  String get lastConfigurationSyncTime {
    return Intl.message(
      'Sync Time',
      name: 'lastConfigurationSyncTime',
      desc: '',
      args: [],
    );
  }

  /// `last sync status`
  String get lastSyncStatus {
    return Intl.message(
      'last sync status',
      name: 'lastSyncStatus',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `App Information`
  String get appInformation {
    return Intl.message(
      'App Information',
      name: 'appInformation',
      desc: '',
      args: [],
    );
  }

  /// `Developer Information`
  String get developerInformation {
    return Intl.message(
      'Developer Information',
      name: 'developerInformation',
      desc: '',
      args: [],
    );
  }

  /// `NMCP Yemen`
  String get developer {
    return Intl.message('NMCP Yemen', name: 'developer', desc: '', args: []);
  }

  /// `info@nmcpye.org`
  String get developerInfoText {
    return Intl.message(
      'info@nmcpye.org',
      name: 'developerInfoText',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Account Information`
  String get accountInformation {
    return Intl.message(
      'Account Information',
      name: 'accountInformation',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get mobile {
    return Intl.message('Mobile', name: 'mobile', desc: '', args: []);
  }

  /// `Open settings`
  String get openSettings {
    return Intl.message(
      'Open settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `internet Is Connected`
  String get internetIsConnected {
    return Intl.message(
      'internet Is Connected',
      name: 'internetIsConnected',
      desc: '',
      args: [],
    );
  }

  /// `No sync yet`
  String get noSyncYet {
    return Intl.message('No sync yet', name: 'noSyncYet', desc: '', args: []);
  }

  /// `Daily`
  String get daily {
    return Intl.message('Daily', name: 'daily', desc: '', args: []);
  }

  /// `Every two days`
  String get everyTwoDays {
    return Intl.message(
      'Every two days',
      name: 'everyTwoDays',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Every 15 days`
  String get everyFifteenDays {
    return Intl.message(
      'Every 15 days',
      name: 'everyFifteenDays',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Sync Now`
  String get syncNow {
    return Intl.message('Sync Now', name: 'syncNow', desc: '', args: []);
  }

  /// `Sync Interval`
  String get syncInterval {
    return Intl.message(
      'Sync Interval',
      name: 'syncInterval',
      desc: '',
      args: [],
    );
  }

  /// `Sync Settings`
  String get syncSettings {
    return Intl.message(
      'Sync Settings',
      name: 'syncSettings',
      desc: '',
      args: [],
    );
  }

  /// `Save and Edit Next`
  String get saveAndEditNext {
    return Intl.message(
      'Save and Edit Next',
      name: 'saveAndEditNext',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveAndClose {
    return Intl.message('Save', name: 'saveAndClose', desc: '', args: []);
  }

  /// `Add Another`
  String get saveAndAddAnother {
    return Intl.message(
      'Add Another',
      name: 'saveAndAddAnother',
      desc: '',
      args: [],
    );
  }

  /// `New Item`
  String get newItem {
    return Intl.message('New Item', name: 'newItem', desc: '', args: []);
  }

  /// `Edit Item`
  String get editItem {
    return Intl.message('Edit Item', name: 'editItem', desc: '', args: []);
  }

  /// `Unsaved changes`
  String get unsavedChangesWarning {
    return Intl.message(
      'Unsaved changes',
      name: 'unsavedChangesWarning',
      desc: '',
      args: [],
    );
  }

  /// `Close without saving?`
  String get closeWithoutSaving {
    return Intl.message(
      'Close without saving?',
      name: 'closeWithoutSaving',
      desc: '',
      args: [],
    );
  }

  /// `Scan your code`
  String get scanYourCode {
    return Intl.message(
      'Scan your code',
      name: 'scanYourCode',
      desc: '',
      args: [],
    );
  }

  /// `Barcode/QR Code`
  String get barcodeQrScan {
    return Intl.message(
      'Barcode/QR Code',
      name: 'barcodeQrScan',
      desc: '',
      args: [],
    );
  }

  /// `Accept code?`
  String get acceptCode {
    return Intl.message('Accept code?', name: 'acceptCode', desc: '', args: []);
  }

  /// `Scan barcode`
  String get scanBarcode {
    return Intl.message(
      'Scan barcode',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid scanned code!`
  String get invalidScannedCode {
    return Intl.message(
      'Invalid scanned code!',
      name: 'invalidScannedCode',
      desc: '',
      args: [],
    );
  }

  /// `Rescan`
  String get rescan {
    return Intl.message('Rescan', name: 'rescan', desc: '', args: []);
  }

  /// `GTIN`
  String get gtin {
    return Intl.message('GTIN', name: 'gtin', desc: '', args: []);
  }

  /// `Batch`
  String get batch {
    return Intl.message('Batch', name: 'batch', desc: '', args: []);
  }

  /// `Serial`
  String get serial {
    return Intl.message('Serial', name: 'serial', desc: '', args: []);
  }

  /// `Count`
  String get count {
    return Intl.message('Count', name: 'count', desc: '', args: []);
  }

  /// `Production Date`
  String get productionDate {
    return Intl.message(
      'Production Date',
      name: 'productionDate',
      desc: '',
      args: [],
    );
  }

  /// `Controller not ready.`
  String get controllerNotReady {
    return Intl.message(
      'Controller not ready.',
      name: 'controllerNotReady',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Scanning is unsupported on this device`
  String get scanningIsUnsupportedOnThisDevice {
    return Intl.message(
      'Scanning is unsupported on this device',
      name: 'scanningIsUnsupportedOnThisDevice',
      desc: '',
      args: [],
    );
  }

  /// `Generic Error`
  String get genericError {
    return Intl.message(
      'Generic Error',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `dueDate`
  String get dueDate {
    return Intl.message('dueDate', name: 'dueDate', desc: '', args: []);
  }

  /// `dueDay`
  String get dueDay {
    return Intl.message('dueDay', name: 'dueDay', desc: '', args: []);
  }

  /// `Scope`
  String get scope {
    return Intl.message('Scope', name: 'scope', desc: '', args: []);
  }

  /// `Forms`
  String get formsAssigned {
    return Intl.message('Forms', name: 'formsAssigned', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resources {
    return Intl.message('Resources', name: 'resources', desc: '', args: []);
  }

  /// `Team`
  String get team {
    return Intl.message('Team', name: 'team', desc: '', args: []);
  }

  /// `Not Started`
  String get not_started {
    return Intl.message('Not Started', name: 'not_started', desc: '', args: []);
  }

  /// `In Progress`
  String get in_progress {
    return Intl.message('In Progress', name: 'in_progress', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Rescheduled`
  String get rescheduled {
    return Intl.message('Rescheduled', name: 'rescheduled', desc: '', args: []);
  }

  /// `Merged`
  String get merged {
    return Intl.message('Merged', name: 'merged', desc: '', args: []);
  }

  /// `Reassigned`
  String get reassigned {
    return Intl.message('Reassigned', name: 'reassigned', desc: '', args: []);
  }

  /// `Assigned`
  String get assigned {
    return Intl.message('Assigned', name: 'assigned', desc: '', args: []);
  }

  /// `Managed`
  String get managed {
    return Intl.message('Managed', name: 'managed', desc: '', args: []);
  }

  /// `Entity`
  String get entity {
    return Intl.message('Entity', name: 'entity', desc: '', args: []);
  }

  /// `Forms`
  String get forms {
    return Intl.message('Forms', name: 'forms', desc: '', args: []);
  }

  /// `Assignment Detail`
  String get assignmentDetail {
    return Intl.message(
      'Assignment Detail',
      name: 'assignmentDetail',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Allocated Resources`
  String get allocatedResources {
    return Intl.message(
      'Allocated Resources',
      name: 'allocatedResources',
      desc: '',
      args: [],
    );
  }

  /// `Reported Resources`
  String get reportedResources {
    return Intl.message(
      'Reported Resources',
      name: 'reportedResources',
      desc: '',
      args: [],
    );
  }

  /// `Error Opening Form`
  String get errorOpeningForm {
    return Intl.message(
      'Error Opening Form',
      name: 'errorOpeningForm',
      desc: '',
      args: [],
    );
  }

  /// `No Submissions`
  String get noSubmissions {
    return Intl.message(
      'No Submissions',
      name: 'noSubmissions',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Toggle List/Table View`
  String get toggleListTableView {
    return Intl.message(
      'Toggle List/Table View',
      name: 'toggleListTableView',
      desc: '',
      args: [],
    );
  }

  /// `Clear Filters`
  String get clearFilters {
    return Intl.message(
      'Clear Filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Team`
  String get assignedTeam {
    return Intl.message(
      'Assigned Team',
      name: 'assignedTeam',
      desc: '',
      args: [],
    );
  }

  /// `Managed Teams`
  String get managedTeams {
    return Intl.message(
      'Managed Teams',
      name: 'managedTeams',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Assignments`
  String get assignedAssignments {
    return Intl.message(
      'Assigned Assignments',
      name: 'assignedAssignments',
      desc: '',
      args: [],
    );
  }

  /// `Managed Assignments`
  String get managedAssignments {
    return Intl.message(
      'Managed Assignments',
      name: 'managedAssignments',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `{count, plural, =0{No Syncable submissions} =1{1 submission} =2{2 submissions} other{{count} submissions}}`
  String syncSubmissions(num count) {
    return Intl.plural(
      count,
      zero: 'No Syncable submissions',
      one: '1 submission',
      two: '2 submissions',
      other: '$count submissions',
      name: 'syncSubmissions',
      desc: 'A plural message',
      args: [count],
    );
  }

  /// `All Submissions`
  String get allSubmissions {
    return Intl.message(
      'All Submissions',
      name: 'allSubmissions',
      desc: '',
      args: [],
    );
  }

  /// `Created Date`
  String get createdDate {
    return Intl.message(
      'Created Date',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `LastModified Date`
  String get lastmodifiedDate {
    return Intl.message(
      'LastModified Date',
      name: 'lastmodifiedDate',
      desc: '',
      args: [],
    );
  }

  /// `Population`
  String get population {
    return Intl.message('Population', name: 'population', desc: '', args: []);
  }

  /// `Households`
  String get households {
    return Intl.message('Households', name: 'households', desc: '', args: []);
  }

  /// `ITNs`
  String get itns {
    return Intl.message('ITNs', name: 'itns', desc: '', args: []);
  }

  /// `Select Form`
  String get selectForm {
    return Intl.message('Select Form', name: 'selectForm', desc: '', args: []);
  }

  /// `Reported`
  String get reported {
    return Intl.message('Reported', name: 'reported', desc: '', args: []);
  }

  /// `Last sync time`
  String get lastSync {
    return Intl.message('Last sync time', name: 'lastSync', desc: '', args: []);
  }

  /// `Last Sync`
  String get to_post {
    return Intl.message('Last Sync', name: 'to_post', desc: '', args: []);
  }

  /// `Last Sync`
  String get to_update {
    return Intl.message('Last Sync', name: 'to_update', desc: '', args: []);
  }

  /// `Last Sync`
  String get synced {
    return Intl.message('Last Sync', name: 'synced', desc: '', args: []);
  }

  /// `Toggle between List and Card view`
  String get toggleBetweenListAndCardView {
    return Intl.message(
      'Toggle between List and Card view',
      name: 'toggleBetweenListAndCardView',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `teams`
  String get teams {
    return Intl.message('teams', name: 'teams', desc: '', args: []);
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message('Clear All', name: 'clearAll', desc: '', args: []);
  }

  /// `{value} is Copied To Clipboard`
  String copiedToClipboard(Object value) {
    return Intl.message(
      '$value is Copied To Clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [value],
    );
  }

  /// `Changing state might result clearing dependents elements`
  String get changingStateMightResultClearingDependentsElements {
    return Intl.message(
      'Changing state might result clearing dependents elements',
      name: 'changingStateMightResultClearingDependentsElements',
      desc: '',
      args: [],
    );
  }

  /// `Restore Item`
  String get restoreItem {
    return Intl.message(
      'Restore Item',
      name: 'restoreItem',
      desc: '',
      args: [],
    );
  }

  /// `Delete / Restore`
  String get deleteRestore {
    return Intl.message(
      'Delete / Restore',
      name: 'deleteRestore',
      desc: '',
      args: [],
    );
  }

  /// `Field Is Mandatory`
  String get fieldIsMandatory {
    return Intl.message(
      'Field Is Mandatory',
      name: 'fieldIsMandatory',
      desc: '',
      args: [],
    );
  }

  /// `Validation Error Message`
  String get validationErrorMessage {
    return Intl.message(
      'Validation Error Message',
      name: 'validationErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete Item`
  String get deleteItem {
    return Intl.message('Delete Item', name: 'deleteItem', desc: '', args: []);
  }

  /// `Copy To Clipboard`
  String get copyToClipboard {
    return Intl.message(
      'Copy To Clipboard',
      name: 'copyToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `DOB`
  String get dateOfBirth {
    return Intl.message('DOB', name: 'dateOfBirth', desc: '', args: []);
  }

  /// `Y/M`
  String get yearsMonths {
    return Intl.message('Y/M', name: 'yearsMonths', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
