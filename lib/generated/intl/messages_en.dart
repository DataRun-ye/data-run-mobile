// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) =>
      "An error occurred while interacting with the API ${error}.";

  static String m1(error) => "Bad certificate: ${error}";

  static String m2(error) => "Bad http request: ${error}.";

  static String m3(error) => "Bad request to end point: ${error}.";

  static String m4(error) => "bad response: ${error}";

  static String m5(error) => "connection error: ${error}";

  static String m6(error) => "Connection timeout: ${error}";

  static String m7(value) => "${value} is Copied To Clipboard";

  static String m8(error) => "Database returned an Error ${error}.";

  static String m9(error) => "end point Not found: ${error}.";

  static String m10(error) => "Forbidden: ${error}.";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'no forms available', one: '1 form available', two: '2 forms available', other: '${count} forms available')}";

  static String m12(error) => "Invalid data: ${error}.";

  static String m13(error) => "The maximum allowed length is ${error}.";

  static String m14(count) =>
      "${Intl.plural(count, zero: ' ', one: '1 Month', two: '2 Months', few: '${count} Years', other: '${count} Months')}";

  static String m15(error) => "No active database found: ${error}.";

  static String m16(error) => "user details not fetched from server: ${error}.";

  static String m17(error) => "receive timeout: ${error}";

  static String m18(error) => "send timeout: ${error}";

  static String m19(error) => "Server error: ${error}.";

  static String m20(error) => "Session expired: ${error}.";

  static String m21(error) =>
      "An Error Was Encountered during for submission:\n ${error}";

  static String m22(error) => "Error While Trying to Sync data ${error}.";

  static String m23(count) =>
      "${Intl.plural(count, zero: 'No Syncable submissions', one: '1 submission', two: '2 submissions', other: '${count} submissions')}";

  static String m24(error) => "System Files Access Error: ${error}";

  static String m25(error) => "Unauthorized Access to end point: ${error}.";

  static String m26(error) => "Error: ${error}.";

  static String m27(error) =>
      "The value must be greater than or equal to ${error}.";

  static String m28(error) =>
      "The value must be less than or equal to ${error}.";

  static String m29(count) =>
      "${Intl.plural(count, zero: ' ', one: '1 Year', two: '2 Years', few: '${count} Years', other: '${count} Years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accept": MessageLookupByLibrary.simpleMessage("Accept"),
    "acceptCode": MessageLookupByLibrary.simpleMessage("Accept code?"),
    "accountDisabled": MessageLookupByLibrary.simpleMessage(
      "This account is disabled. contact Administrator for details.",
    ),
    "accountInformation": MessageLookupByLibrary.simpleMessage(
      "Account Information",
    ),
    "actionNeedsConfirmation": MessageLookupByLibrary.simpleMessage(
      "confirm before proceed",
    ),
    "activities": MessageLookupByLibrary.simpleMessage("Activities"),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "addNew": MessageLookupByLibrary.simpleMessage("Add New"),
    "ageFieldHint": MessageLookupByLibrary.simpleMessage("Enter an Age"),
    "allSubmissions": MessageLookupByLibrary.simpleMessage("All Submissions"),
    "allocatedResources": MessageLookupByLibrary.simpleMessage(
      "Allocated Resources",
    ),
    "and": MessageLookupByLibrary.simpleMessage("And"),
    "apiError": m0,
    "appInformation": MessageLookupByLibrary.simpleMessage("App Information"),
    "appName": MessageLookupByLibrary.simpleMessage("Datarun"),
    "appVersion": MessageLookupByLibrary.simpleMessage("App Version"),
    "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "assigned": MessageLookupByLibrary.simpleMessage("Assigned"),
    "assignedAssignments": MessageLookupByLibrary.simpleMessage("Assignments"),
    "assignedTeam": MessageLookupByLibrary.simpleMessage("Team"),
    "assignmentDetail": MessageLookupByLibrary.simpleMessage(
      "Assignment Detail",
    ),
    "assignmentList": MessageLookupByLibrary.simpleMessage("Assignment List"),
    "assignments": MessageLookupByLibrary.simpleMessage("Assignments"),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid login credentials provided.",
    ),
    "authSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired. Please log in again.",
    ),
    "badCertificate": m1,
    "badHttpRequest": m2,
    "badRequestToEndPoint": m3,
    "badResponse": m4,
    "barcodeQrScan": MessageLookupByLibrary.simpleMessage("Barcode/QR Code"),
    "batch": MessageLookupByLibrary.simpleMessage("Batch"),
    "booleanFieldHint": MessageLookupByLibrary.simpleMessage("Enter a Boolean"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelSyncing": MessageLookupByLibrary.simpleMessage("Cancel Syncing"),
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "checkFieldsLater": MessageLookupByLibrary.simpleMessage("Not Now"),
    "checkingSession": MessageLookupByLibrary.simpleMessage(
      "Checking session...",
    ),
    "clear": MessageLookupByLibrary.simpleMessage("Clear"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("Clear Filters"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closeWithoutSaving": MessageLookupByLibrary.simpleMessage(
      "Close without saving?",
    ),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "configurationReady": MessageLookupByLibrary.simpleMessage(
      "Configuration Ready",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to sync the selected entities?",
    ),
    "confirmationWarning": MessageLookupByLibrary.simpleMessage(
      "Changing response might result clearing data from dependent elements",
    ),
    "conformDeleteMsg": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove this section?",
    ),
    "connectionError": m5,
    "connectionTimeout": m6,
    "controllerNotReady": MessageLookupByLibrary.simpleMessage(
      "Controller not ready.",
    ),
    "coordinatesFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select Coordinates",
    ),
    "copiedToClipboard": m7,
    "copyAll": MessageLookupByLibrary.simpleMessage("Copy All"),
    "copyToClipboard": MessageLookupByLibrary.simpleMessage(
      "Copy To Clipboard",
    ),
    "count": MessageLookupByLibrary.simpleMessage("Count"),
    "createdDate": MessageLookupByLibrary.simpleMessage("Created Date"),
    "currentOperations": MessageLookupByLibrary.simpleMessage(
      "Current Operations:",
    ),
    "currentUsername": MessageLookupByLibrary.simpleMessage("Current username"),
    "daily": MessageLookupByLibrary.simpleMessage("Daily"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "dataElements": MessageLookupByLibrary.simpleMessage("Data Elements"),
    "dataFieldHint": MessageLookupByLibrary.simpleMessage("Select a date"),
    "dataSubmission": MessageLookupByLibrary.simpleMessage("Data Submission"),
    "dataSubmissions": MessageLookupByLibrary.simpleMessage("Data Submissions"),
    "dataTimeFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Data time",
    ),
    "databaseConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to connect to the database.",
    ),
    "databaseInternalError": m8,
    "databaseQueryFailed": MessageLookupByLibrary.simpleMessage(
      "Error occurred while querying the database.",
    ),
    "datarun": MessageLookupByLibrary.simpleMessage("DATARUN"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("DOB"),
    "day": MessageLookupByLibrary.simpleMessage("Day"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this item?",
    ),
    "deleteItem": MessageLookupByLibrary.simpleMessage("Delete Item"),
    "deleteRestore": MessageLookupByLibrary.simpleMessage("Delete / Restore"),
    "developer": MessageLookupByLibrary.simpleMessage("Hamza For NMCP Yemen"),
    "developerInfoText": MessageLookupByLibrary.simpleMessage(
      "info@nmcpye.org",
    ),
    "developerInformation": MessageLookupByLibrary.simpleMessage(
      "Developer Information",
    ),
    "differentOfflineUser": MessageLookupByLibrary.simpleMessage(
      "Different authenticated user offline",
    ),
    "discard": MessageLookupByLibrary.simpleMessage("Discard"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "downloaded": MessageLookupByLibrary.simpleMessage("Downloaded"),
    "draft": MessageLookupByLibrary.simpleMessage("Draft"),
    "dueDate": MessageLookupByLibrary.simpleMessage("dueDate"),
    "dueDay": MessageLookupByLibrary.simpleMessage("dueDay"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editItem": MessageLookupByLibrary.simpleMessage("Edit Item"),
    "emailFieldHint": MessageLookupByLibrary.simpleMessage("Enter An Email"),
    "empty": MessageLookupByLibrary.simpleMessage("Empty"),
    "endDate": MessageLookupByLibrary.simpleMessage("End Date"),
    "endPointNotFound": m9,
    "enterAValidNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid number.",
    ),
    "enterYourUsername": MessageLookupByLibrary.simpleMessage(
      "Enter Your Username",
    ),
    "entity": MessageLookupByLibrary.simpleMessage("Entity"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorOpeningForm": MessageLookupByLibrary.simpleMessage(
      "Error Opening Form",
    ),
    "errorOpeningNewForm": MessageLookupByLibrary.simpleMessage(
      "Error Opening New Form",
    ),
    "errorSubmittingForm": MessageLookupByLibrary.simpleMessage(
      "Error Submitting form",
    ),
    "errorSummary": MessageLookupByLibrary.simpleMessage("Error Summary"),
    "everyFifteenDays": MessageLookupByLibrary.simpleMessage("Every 15 days"),
    "everyTwoDays": MessageLookupByLibrary.simpleMessage("Every two days"),
    "failed": MessageLookupByLibrary.simpleMessage("Failed"),
    "failureCount": MessageLookupByLibrary.simpleMessage("Failure Count"),
    "fetchUpdates": MessageLookupByLibrary.simpleMessage("Sync Configuration"),
    "fieldContainErrors": MessageLookupByLibrary.simpleMessage(
      "field Contain Errors",
    ),
    "fieldIsMandatory": MessageLookupByLibrary.simpleMessage(
      "Field Is Mandatory",
    ),
    "fieldsWithErrorInfo": MessageLookupByLibrary.simpleMessage(
      "Fields with Error",
    ),
    "fileResourceFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select A file",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "finalData": MessageLookupByLibrary.simpleMessage("Finalize the Data"),
    "finalized": MessageLookupByLibrary.simpleMessage("Finalized"),
    "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "forbidden": m10,
    "form": m11,
    "formContainsSomeErrors": MessageLookupByLibrary.simpleMessage(
      "Form contains some errors",
    ),
    "formPermissions": MessageLookupByLibrary.simpleMessage("Permission"),
    "formSummaryView": MessageLookupByLibrary.simpleMessage(
      "Form Summary View",
    ),
    "formTemplates": MessageLookupByLibrary.simpleMessage("Form Templates"),
    "forms": MessageLookupByLibrary.simpleMessage("Forms"),
    "formsAssigned": MessageLookupByLibrary.simpleMessage("Forms"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "fullNameFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a full name",
    ),
    "generalErrorMessage": MessageLookupByLibrary.simpleMessage(
      "The application has encountered an unknown error.\'             \'Please try again later.",
    ),
    "generalErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "genericError": MessageLookupByLibrary.simpleMessage("Generic Error"),
    "gtin": MessageLookupByLibrary.simpleMessage("GTIN"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide Password"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "households": MessageLookupByLibrary.simpleMessage("Households"),
    "imageFieldHint": MessageLookupByLibrary.simpleMessage("Select an Image"),
    "in_progress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "integerFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter an integer",
    ),
    "integerOrZeroFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter an integer or zero",
    ),
    "internetIsConnected": MessageLookupByLibrary.simpleMessage(
      "internet Is Connected",
    ),
    "invalidData": m12,
    "invalidScannedCode": MessageLookupByLibrary.simpleMessage(
      "Invalid scanned code!",
    ),
    "itemRemoved": MessageLookupByLibrary.simpleMessage("Item Removed"),
    "itns": MessageLookupByLibrary.simpleMessage("ITNs"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastConfigurationSyncTime": MessageLookupByLibrary.simpleMessage(
      "Sync Time",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "lastSync": MessageLookupByLibrary.simpleMessage("Last sync time"),
    "lastSyncStatus": MessageLookupByLibrary.simpleMessage("last sync status"),
    "lastmodifiedDate": MessageLookupByLibrary.simpleMessage(
      "LastModified Date",
    ),
    "level": MessageLookupByLibrary.simpleMessage("Level"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Load More"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading ..."),
    "logOut": MessageLookupByLibrary.simpleMessage("Log out?"),
    "logOutAnyway": MessageLookupByLibrary.simpleMessage("LOG OUT ANYWAY"),
    "login": MessageLookupByLibrary.simpleMessage("Datarun Login"),
    "loginUsername": MessageLookupByLibrary.simpleMessage("Login Username"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutNote": MessageLookupByLibrary.simpleMessage(
      "your data will not be deleted when you login back again",
    ),
    "longTextHint": MessageLookupByLibrary.simpleMessage("Enter a text"),
    "makeFormFinalOrSaveBody": MessageLookupByLibrary.simpleMessage(
      "Make Form Final for Send to server, or save as draft!",
    ),
    "managed": MessageLookupByLibrary.simpleMessage("Managed"),
    "managedAssignments": MessageLookupByLibrary.simpleMessage(
      "Managed Assignments",
    ),
    "managedTeams": MessageLookupByLibrary.simpleMessage("Managed Teams"),
    "markAsFinalData": MessageLookupByLibrary.simpleMessage("Make form Final?"),
    "materialVersion": MessageLookupByLibrary.simpleMessage("Material Version"),
    "maximumAllowedLengthIsError": m13,
    "merged": MessageLookupByLibrary.simpleMessage("Merged"),
    "middleName": MessageLookupByLibrary.simpleMessage("Middle Name"),
    "mobile": MessageLookupByLibrary.simpleMessage("Mobile"),
    "month": m14,
    "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "months": MessageLookupByLibrary.simpleMessage("Months"),
    "negativeIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a negative integer",
    ),
    "networkConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Connection failed. Check your network.",
    ),
    "networkTimeout": MessageLookupByLibrary.simpleMessage(
      "Request timed out. Please try again.",
    ),
    "newItem": MessageLookupByLibrary.simpleMessage("New Item"),
    "nmcpYemen": MessageLookupByLibrary.simpleMessage("NMCP Yemen"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noActiveDatabaseFound": m15,
    "noActivitiesYet": MessageLookupByLibrary.simpleMessage(
      "No activities yet",
    ),
    "noAuthenticatedUser": MessageLookupByLibrary.simpleMessage(
      "First time login user needs an active network.",
    ),
    "noAuthenticatedUserOffline": MessageLookupByLibrary.simpleMessage(
      "The user hasn\'t been previously authenticated. Cannot login offline.",
    ),
    "noConnection": MessageLookupByLibrary.simpleMessage("No connection"),
    "noConnectionMessage": MessageLookupByLibrary.simpleMessage(
      "Please check internet connection and try again.",
    ),
    "noFormsAvailable": MessageLookupByLibrary.simpleMessage(
      "No forms available",
    ),
    "noInternetAccess": MessageLookupByLibrary.simpleMessage(
      "No internet access",
    ),
    "noMoreItems": MessageLookupByLibrary.simpleMessage("No more items."),
    "noSubmissions": MessageLookupByLibrary.simpleMessage("No Submissions"),
    "noSyncYet": MessageLookupByLibrary.simpleMessage("No sync yet"),
    "noSyncsYet": MessageLookupByLibrary.simpleMessage("No Syncs Yet"),
    "noUserDetailsFetchedFromServer": m16,
    "notNow": MessageLookupByLibrary.simpleMessage("Not Now"),
    "not_started": MessageLookupByLibrary.simpleMessage("Not Started"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numberFieldHint": MessageLookupByLibrary.simpleMessage("Enter a number"),
    "objectAccessClosed": MessageLookupByLibrary.simpleMessage(
      "objectAccessClosed",
    ),
    "objectAccessDenied": MessageLookupByLibrary.simpleMessage(
      "objectAccessDenied",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "oneLetterFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Letter",
    ),
    "online": MessageLookupByLibrary.simpleMessage("online!"),
    "open": MessageLookupByLibrary.simpleMessage("Open"),
    "openNewForm": MessageLookupByLibrary.simpleMessage("New"),
    "openSettings": MessageLookupByLibrary.simpleMessage("Open settings"),
    "optionSets": MessageLookupByLibrary.simpleMessage("Option Sets"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "orgUnitDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Search for and Select OrgUnit",
    ),
    "orgUnitHelpText": MessageLookupByLibrary.simpleMessage("Select Org Unit"),
    "orgUnitInputLabel": MessageLookupByLibrary.simpleMessage(
      "Select Org Unit",
    ),
    "orgUnits": MessageLookupByLibrary.simpleMessage("Organisation Units"),
    "organization": MessageLookupByLibrary.simpleMessage("Organization"),
    "orgunitFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select an OrgUnit",
    ),
    "ouLevels": MessageLookupByLibrary.simpleMessage("OU Levels"),
    "password": MessageLookupByLibrary.simpleMessage("password"),
    "percentageFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Percentage",
    ),
    "performFirstSync": MessageLookupByLibrary.simpleMessage(
      "Perform First Sync",
    ),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permission denied",
    ),
    "personInformation": MessageLookupByLibrary.simpleMessage(
      "Person Information",
    ),
    "phoneNumberFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a phone number",
    ),
    "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
      "enter a valid email address.",
    ),
    "population": MessageLookupByLibrary.simpleMessage("Population"),
    "positiveIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a positive integer",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "productionDate": MessageLookupByLibrary.simpleMessage("Production Date"),
    "progressFieldHint": MessageLookupByLibrary.simpleMessage("fieldHintText"),
    "projects": MessageLookupByLibrary.simpleMessage("Projects"),
    "reassigned": MessageLookupByLibrary.simpleMessage("Reassigned"),
    "receiveTimeout": m17,
    "referenceFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select a reference",
    ),
    "reported": MessageLookupByLibrary.simpleMessage("Reported"),
    "reportedResources": MessageLookupByLibrary.simpleMessage(
      "Reported Resources",
    ),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "request cancelled",
    ),
    "rescan": MessageLookupByLibrary.simpleMessage("Rescan"),
    "rescheduled": MessageLookupByLibrary.simpleMessage("Rescheduled"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "restoreItem": MessageLookupByLibrary.simpleMessage("Restore Item"),
    "reviewFormData": MessageLookupByLibrary.simpleMessage("Review"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveAndAddAnother": MessageLookupByLibrary.simpleMessage("Add Another"),
    "saveAndCheck": MessageLookupByLibrary.simpleMessage("Save and Check"),
    "saveAndClose": MessageLookupByLibrary.simpleMessage("Save"),
    "saveAndEditNext": MessageLookupByLibrary.simpleMessage(
      "Save and Edit Next",
    ),
    "scanBarcode": MessageLookupByLibrary.simpleMessage("Scan barcode"),
    "scanCodeFieldHint": MessageLookupByLibrary.simpleMessage("Scan Code"),
    "scanYourCode": MessageLookupByLibrary.simpleMessage("Scan your code"),
    "scanningIsUnsupportedOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning is unsupported on this device",
    ),
    "scope": MessageLookupByLibrary.simpleMessage("Scope"),
    "search": MessageLookupByLibrary.simpleMessage("Search..."),
    "searchOrgUnitsHelpText": MessageLookupByLibrary.simpleMessage(
      "Search Org Units...",
    ),
    "selectAColorExtractionImage": MessageLookupByLibrary.simpleMessage(
      "Select a color extraction image",
    ),
    "selectASeedColor": MessageLookupByLibrary.simpleMessage(
      "Select a seed color",
    ),
    "selectColorTheme": MessageLookupByLibrary.simpleMessage(
      "Select Color Theme",
    ),
    "selectForm": MessageLookupByLibrary.simpleMessage("Select Form"),
    "selectImageForColorExtraction": MessageLookupByLibrary.simpleMessage(
      "Select Image for Color Extraction",
    ),
    "selectMultiFieldHint": MessageLookupByLibrary.simpleMessage(
      "fieldHintText",
    ),
    "selectOneFieldHint": MessageLookupByLibrary.simpleMessage("Select One"),
    "selected": MessageLookupByLibrary.simpleMessage("selected"),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sendTimeout": m18,
    "serial": MessageLookupByLibrary.simpleMessage("Serial"),
    "serverError": m19,
    "serverUrl": MessageLookupByLibrary.simpleMessage("Server URL"),
    "sessionExpired": m20,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "showLess": MessageLookupByLibrary.simpleMessage("Show less"),
    "showMore": MessageLookupByLibrary.simpleMessage("Show more"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show Password"),
    "signingOutWarning": MessageLookupByLibrary.simpleMessage(
      "Signing out will discard any unsynced changes. Are you sure you want to log out?",
    ),
    "startDate": MessageLookupByLibrary.simpleMessage("Start Date"),
    "startingSync": MessageLookupByLibrary.simpleMessage("Starting sync..."),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "submissionDataEntry": MessageLookupByLibrary.simpleMessage("Data"),
    "submissionError": m21,
    "submissionInitialData": MessageLookupByLibrary.simpleMessage("Main"),
    "successCount": MessageLookupByLibrary.simpleMessage("Success Count"),
    "syncError": m22,
    "syncErrors": MessageLookupByLibrary.simpleMessage("Sync Errors"),
    "syncFailed": MessageLookupByLibrary.simpleMessage("Sync Failed"),
    "syncFormData": MessageLookupByLibrary.simpleMessage("Sync Form Data"),
    "syncInterval": MessageLookupByLibrary.simpleMessage("Sync Interval"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sync Now"),
    "syncProgressDashboard": MessageLookupByLibrary.simpleMessage(
      "Sync Progress Dashboard",
    ),
    "syncSettings": MessageLookupByLibrary.simpleMessage("Sync Settings"),
    "syncSubmissions": m23,
    "syncSummaryLoadError": MessageLookupByLibrary.simpleMessage(
      "Sync Summary Load Error",
    ),
    "syncSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Sync Summary Title",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sync"),
    "syncingConfiguration": MessageLookupByLibrary.simpleMessage(
      "Syncing Configuration",
    ),
    "syncingData": MessageLookupByLibrary.simpleMessage("Syncing Data"),
    "syncingEvents": MessageLookupByLibrary.simpleMessage("Syncing Events"),
    "systemFilesAccessError": m24,
    "team": MessageLookupByLibrary.simpleMessage("Team"),
    "teamFieldHint": MessageLookupByLibrary.simpleMessage("Select a Team"),
    "teams": MessageLookupByLibrary.simpleMessage("teams"),
    "textHint": MessageLookupByLibrary.simpleMessage("Enter a text"),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required.",
    ),
    "timeFieldHint": MessageLookupByLibrary.simpleMessage("Select a Time"),
    "to_post": MessageLookupByLibrary.simpleMessage("Last Sync"),
    "to_update": MessageLookupByLibrary.simpleMessage("Last Sync"),
    "toggleBetweenListAndCardView": MessageLookupByLibrary.simpleMessage(
      "Toggle between List and Card view",
    ),
    "toggleBrightness": MessageLookupByLibrary.simpleMessage(
      "Toggle Brightness",
    ),
    "toggleListTableView": MessageLookupByLibrary.simpleMessage(
      "Toggle List/Table View",
    ),
    "trueOnlyFieldHint": MessageLookupByLibrary.simpleMessage("fieldHintText"),
    "unauthorizedAccessToEndPoint": m25,
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "unexpected": m26,
    "unitIntervalFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter unit Interval",
    ),
    "unknownValueType": MessageLookupByLibrary.simpleMessage(
      "Unknown Value Type",
    ),
    "unsavedChangesWarning": MessageLookupByLibrary.simpleMessage(
      "Unsaved changes",
    ),
    "unsupportedValueType": MessageLookupByLibrary.simpleMessage(
      "Unsupported value type",
    ),
    "urlFieldHint": MessageLookupByLibrary.simpleMessage("Enter a URL"),
    "user": MessageLookupByLibrary.simpleMessage("user"),
    "userSettings": MessageLookupByLibrary.simpleMessage("User Settings"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select a Username",
    ),
    "validationError": MessageLookupByLibrary.simpleMessage(
      "Please correct the errors in the form.",
    ),
    "validationErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Validation Error Message",
    ),
    "valueMustBeGreaterThanOrEqualToError": m27,
    "valueMustBeLessThanOrEqualToError": m28,
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "viewAvailableForms": MessageLookupByLibrary.simpleMessage(
      "Expand to View Available Forms",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("Details"),
    "viewErrors": MessageLookupByLibrary.simpleMessage("View Errors"),
    "viewList": MessageLookupByLibrary.simpleMessage("View List"),
    "warning": MessageLookupByLibrary.simpleMessage("Warning"),
    "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "year": m29,
    "years": MessageLookupByLibrary.simpleMessage("Years"),
    "yearsMonths": MessageLookupByLibrary.simpleMessage("Y/M"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yesOrNoFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select Yes or No",
    ),
  };
}
