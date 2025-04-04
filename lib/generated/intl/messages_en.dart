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

  static String m1(value) => "${value} is Copied To Clipboard";

  static String m2(error) => "Database returned an Error ${error}.";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'no forms available', one: '1 form available', two: '2 forms available', other: '${count} forms available')}";

  static String m4(error) => "The maximum allowed length is ${error}.";

  static String m5(count) =>
      "${Intl.plural(count, zero: ' ', one: '1 Month', two: '2 Months', few: '${count} Years', other: '${count} Months')}";

  static String m6(error) => "Error While Trying to Sync data ${error}.";

  static String m7(count) =>
      "${Intl.plural(count, zero: 'No Syncable submissions', one: '1 submission', two: '2 submissions', other: '${count} submissions')}";

  static String m8(error) => "Error: ${error}.";

  static String m9(error) =>
      "The value must be greater than or equal to ${error}.";

  static String m10(error) =>
      "The value must be less than or equal to ${error}.";

  static String m11(count) =>
      "${Intl.plural(count, zero: ' ', one: '1 Year', two: '2 Years', few: '${count} Years', other: '${count} Years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "accept": MessageLookupByLibrary.simpleMessage("Accept"),
        "acceptCode": MessageLookupByLibrary.simpleMessage("Accept code?"),
        "accountDisabled": MessageLookupByLibrary.simpleMessage(
            "This account is disabled. contact Administrator for details."),
        "accountInformation":
            MessageLookupByLibrary.simpleMessage("Account Information"),
        "activity": MessageLookupByLibrary.simpleMessage("Activity"),
        "addNew": MessageLookupByLibrary.simpleMessage("Add New"),
        "allSubmissions":
            MessageLookupByLibrary.simpleMessage("All Submissions"),
        "allocatedResources":
            MessageLookupByLibrary.simpleMessage("Allocated Resources"),
        "and": MessageLookupByLibrary.simpleMessage("And"),
        "apiError": m0,
        "appInformation":
            MessageLookupByLibrary.simpleMessage("App Information"),
        "appName": MessageLookupByLibrary.simpleMessage("Datarun"),
        "appVersion": MessageLookupByLibrary.simpleMessage("App Version"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "assigned": MessageLookupByLibrary.simpleMessage("Assigned"),
        "assignedAssignments":
            MessageLookupByLibrary.simpleMessage("Assigned Assignments"),
        "assignedTeam": MessageLookupByLibrary.simpleMessage("Assigned Team"),
        "assignmentDetail":
            MessageLookupByLibrary.simpleMessage("Assignment Detail"),
        "assignmentList":
            MessageLookupByLibrary.simpleMessage("Assignment List"),
        "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "Invalid login credentials provided."),
        "authSessionExpired": MessageLookupByLibrary.simpleMessage(
            "Your session has expired. Please log in again."),
        "barcodeQrScan":
            MessageLookupByLibrary.simpleMessage("Barcode/QR Code"),
        "batch": MessageLookupByLibrary.simpleMessage("Batch"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "changingStateMightResultClearingDependentsElements":
            MessageLookupByLibrary.simpleMessage(
                "Changing state might result clearing dependents elements"),
        "checkFieldsLater":
            MessageLookupByLibrary.simpleMessage("Check Fields later"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
        "clearFilters": MessageLookupByLibrary.simpleMessage("Clear Filters"),
        "closeWithoutSaving":
            MessageLookupByLibrary.simpleMessage("Close without saving?"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "configurationReady":
            MessageLookupByLibrary.simpleMessage("Configuration Ready"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to sync the selected entities?"),
        "conformDeleteMsg": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to remove this section?"),
        "controllerNotReady":
            MessageLookupByLibrary.simpleMessage("Controller not ready."),
        "copiedToClipboard": m1,
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copy To Clipboard"),
        "count": MessageLookupByLibrary.simpleMessage("Count"),
        "createdDate": MessageLookupByLibrary.simpleMessage("Created Date"),
        "currentUsername":
            MessageLookupByLibrary.simpleMessage("Current username"),
        "daily": MessageLookupByLibrary.simpleMessage("Daily"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "databaseConnectionFailed": MessageLookupByLibrary.simpleMessage(
            "Failed to connect to the database."),
        "databaseInternalError": m2,
        "databaseQueryFailed": MessageLookupByLibrary.simpleMessage(
            "Error occurred while querying the database."),
        "day": MessageLookupByLibrary.simpleMessage("Day"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this item?"),
        "deleteItem": MessageLookupByLibrary.simpleMessage("Delete Item"),
        "deleteRestore":
            MessageLookupByLibrary.simpleMessage("Delete / Restore"),
        "developer": MessageLookupByLibrary.simpleMessage("NMCP Yemen"),
        "developerInfoText":
            MessageLookupByLibrary.simpleMessage("info@nmcpye.org"),
        "developerInformation":
            MessageLookupByLibrary.simpleMessage("Developer Information"),
        "differentOfflineUser": MessageLookupByLibrary.simpleMessage(
            "Different authenticated user offline"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dueDate": MessageLookupByLibrary.simpleMessage("dueDate"),
        "dueDay": MessageLookupByLibrary.simpleMessage("dueDay"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editItem": MessageLookupByLibrary.simpleMessage("Edit Item"),
        "empty": MessageLookupByLibrary.simpleMessage("Empty"),
        "endDate": MessageLookupByLibrary.simpleMessage("End Date"),
        "enterAValidNumber": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid number."),
        "enterYourUsername":
            MessageLookupByLibrary.simpleMessage("Enter Your Username"),
        "entity": MessageLookupByLibrary.simpleMessage("Entity"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorOpeningForm":
            MessageLookupByLibrary.simpleMessage("Error Opening Form"),
        "errorOpeningNewForm":
            MessageLookupByLibrary.simpleMessage("Error Opening New Form"),
        "everyFifteenDays":
            MessageLookupByLibrary.simpleMessage("Every 15 days"),
        "everyTwoDays": MessageLookupByLibrary.simpleMessage("Every two days"),
        "failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "fetchUpdates":
            MessageLookupByLibrary.simpleMessage("Sync Configuration"),
        "fieldContainErrors":
            MessageLookupByLibrary.simpleMessage("field Contain Errors"),
        "fieldIsMandatory":
            MessageLookupByLibrary.simpleMessage("Field Is Mandatory"),
        "fieldsWithErrorInfo":
            MessageLookupByLibrary.simpleMessage("Fields with Error"),
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "finalData": MessageLookupByLibrary.simpleMessage("Final Data"),
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "form": m3,
        "formContainsSomeErrors":
            MessageLookupByLibrary.simpleMessage("Form contains some errors"),
        "formSummaryView":
            MessageLookupByLibrary.simpleMessage("Form Summary View"),
        "forms": MessageLookupByLibrary.simpleMessage("Forms"),
        "formsAssigned": MessageLookupByLibrary.simpleMessage("Forms"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "genericError": MessageLookupByLibrary.simpleMessage("Generic Error"),
        "gtin": MessageLookupByLibrary.simpleMessage("GTIN"),
        "hidePassword": MessageLookupByLibrary.simpleMessage("Hide Password"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "households": MessageLookupByLibrary.simpleMessage("Households"),
        "in_progress": MessageLookupByLibrary.simpleMessage("In Progress"),
        "internetIsConnected":
            MessageLookupByLibrary.simpleMessage("internet Is Connected"),
        "invalidScannedCode":
            MessageLookupByLibrary.simpleMessage("Invalid scanned code!"),
        "itemRemoved": MessageLookupByLibrary.simpleMessage("Item Removed"),
        "itns": MessageLookupByLibrary.simpleMessage("ITNs"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lastConfigurationSyncTime":
            MessageLookupByLibrary.simpleMessage("Sync Time"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "lastSync": MessageLookupByLibrary.simpleMessage("Last sync time"),
        "lastSyncStatus":
            MessageLookupByLibrary.simpleMessage("last sync status"),
        "lastmodifiedDate":
            MessageLookupByLibrary.simpleMessage("LastModified Date"),
        "level": MessageLookupByLibrary.simpleMessage("Level"),
        "loadMore": MessageLookupByLibrary.simpleMessage("Load More"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading ..."),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginUsername": MessageLookupByLibrary.simpleMessage("Login Username"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutNote": MessageLookupByLibrary.simpleMessage(
            "your data will not be deleted when you login back again"),
        "makeFormFinalOrSaveBody": MessageLookupByLibrary.simpleMessage(
            "Make Form Final for Send to server, or save as draft!"),
        "managed": MessageLookupByLibrary.simpleMessage("Managed"),
        "managedAssignments":
            MessageLookupByLibrary.simpleMessage("Managed Assignments"),
        "managedTeams": MessageLookupByLibrary.simpleMessage("Managed Teams"),
        "markAsFinalData": MessageLookupByLibrary.simpleMessage(
            "Make the form Final before exiting."),
        "maximumAllowedLengthIsError": m4,
        "merged": MessageLookupByLibrary.simpleMessage("Merged"),
        "middleName": MessageLookupByLibrary.simpleMessage("Middle Name"),
        "mobile": MessageLookupByLibrary.simpleMessage("Mobile"),
        "month": m5,
        "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
        "months": MessageLookupByLibrary.simpleMessage("Months"),
        "networkConnectionFailed": MessageLookupByLibrary.simpleMessage(
            "Connection failed. Check your network."),
        "networkTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "newItem": MessageLookupByLibrary.simpleMessage("New Item"),
        "nmcpYemen": MessageLookupByLibrary.simpleMessage("NMCP Yemen"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noAuthenticatedUser": MessageLookupByLibrary.simpleMessage(
            "First time login user needs an active network."),
        "noAuthenticatedUserOffline": MessageLookupByLibrary.simpleMessage(
            "The user hasn\'t been previously authenticated. Cannot login offline."),
        "noFormsAvailable":
            MessageLookupByLibrary.simpleMessage("No forms available"),
        "noInternetAccess":
            MessageLookupByLibrary.simpleMessage("No internet access"),
        "noMoreItems": MessageLookupByLibrary.simpleMessage("No more items."),
        "noSubmissions": MessageLookupByLibrary.simpleMessage("No Submissions"),
        "noSyncYet": MessageLookupByLibrary.simpleMessage("No sync yet"),
        "notNow": MessageLookupByLibrary.simpleMessage("Not Now"),
        "not_started": MessageLookupByLibrary.simpleMessage("Not Started"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "objectAccessClosed":
            MessageLookupByLibrary.simpleMessage("objectAccessClosed"),
        "objectAccessDenied":
            MessageLookupByLibrary.simpleMessage("objectAccessDenied"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "online": MessageLookupByLibrary.simpleMessage("online!"),
        "open": MessageLookupByLibrary.simpleMessage("Open"),
        "openNewForm": MessageLookupByLibrary.simpleMessage("New Submission"),
        "openSettings": MessageLookupByLibrary.simpleMessage("Open settings"),
        "orgUnitDialogTitle": MessageLookupByLibrary.simpleMessage(
            "Search for and Select OrgUnit"),
        "orgUnitHelpText":
            MessageLookupByLibrary.simpleMessage("Select Org Unit"),
        "orgUnitInputLabel":
            MessageLookupByLibrary.simpleMessage("Select Org Unit"),
        "organization": MessageLookupByLibrary.simpleMessage("Organization"),
        "password": MessageLookupByLibrary.simpleMessage("password"),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Permission denied"),
        "personInformation":
            MessageLookupByLibrary.simpleMessage("Person Information"),
        "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
            "enter a valid email address."),
        "population": MessageLookupByLibrary.simpleMessage("Population"),
        "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
        "productionDate":
            MessageLookupByLibrary.simpleMessage("Production Date"),
        "reassigned": MessageLookupByLibrary.simpleMessage("Reassigned"),
        "reported": MessageLookupByLibrary.simpleMessage("Reported"),
        "reportedResources":
            MessageLookupByLibrary.simpleMessage("Reported Resources"),
        "rescan": MessageLookupByLibrary.simpleMessage("Rescan"),
        "rescheduled": MessageLookupByLibrary.simpleMessage("Rescheduled"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "resources": MessageLookupByLibrary.simpleMessage("Resources"),
        "restoreItem": MessageLookupByLibrary.simpleMessage("Restore Item"),
        "reviewFormData": MessageLookupByLibrary.simpleMessage("Review Form"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveAndAddAnother":
            MessageLookupByLibrary.simpleMessage("Add Another"),
        "saveAndCheck": MessageLookupByLibrary.simpleMessage("Save and Check"),
        "saveAndClose": MessageLookupByLibrary.simpleMessage("Save"),
        "saveAndEditNext":
            MessageLookupByLibrary.simpleMessage("Save and Edit Next"),
        "scanBarcode": MessageLookupByLibrary.simpleMessage("Scan barcode"),
        "scanYourCode": MessageLookupByLibrary.simpleMessage("Scan your code"),
        "scanningIsUnsupportedOnThisDevice":
            MessageLookupByLibrary.simpleMessage(
                "Scanning is unsupported on this device"),
        "scope": MessageLookupByLibrary.simpleMessage("Scope"),
        "search": MessageLookupByLibrary.simpleMessage("Search..."),
        "searchOrgUnitsHelpText":
            MessageLookupByLibrary.simpleMessage("Search Org Units..."),
        "selectAColorExtractionImage": MessageLookupByLibrary.simpleMessage(
            "Select a color extraction image"),
        "selectASeedColor":
            MessageLookupByLibrary.simpleMessage("Select a seed color"),
        "selectColorTheme":
            MessageLookupByLibrary.simpleMessage("Select Color Theme"),
        "selectForm": MessageLookupByLibrary.simpleMessage("Select Form"),
        "selectImageForColorExtraction": MessageLookupByLibrary.simpleMessage(
            "Select Image for Color Extraction"),
        "selected": MessageLookupByLibrary.simpleMessage("selected"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "serial": MessageLookupByLibrary.simpleMessage("Serial"),
        "serverUrl": MessageLookupByLibrary.simpleMessage("Server URL"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show Password"),
        "startDate": MessageLookupByLibrary.simpleMessage("Start Date"),
        "startingSync":
            MessageLookupByLibrary.simpleMessage("Starting sync..."),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "submissionDataEntry": MessageLookupByLibrary.simpleMessage("Data"),
        "submissionInitialData": MessageLookupByLibrary.simpleMessage("Main"),
        "syncError": m6,
        "syncFormData": MessageLookupByLibrary.simpleMessage("Sync Form Data"),
        "syncInterval": MessageLookupByLibrary.simpleMessage("Sync Interval"),
        "syncNow": MessageLookupByLibrary.simpleMessage("Sync Now"),
        "syncSettings": MessageLookupByLibrary.simpleMessage("Sync Settings"),
        "syncSubmissions": m7,
        "synced": MessageLookupByLibrary.simpleMessage("Last Sync"),
        "syncingConfiguration":
            MessageLookupByLibrary.simpleMessage("Syncing Configuration"),
        "syncingData": MessageLookupByLibrary.simpleMessage("Syncing Data"),
        "syncingEvents": MessageLookupByLibrary.simpleMessage("Syncing Events"),
        "team": MessageLookupByLibrary.simpleMessage("Team"),
        "teams": MessageLookupByLibrary.simpleMessage("teams"),
        "thisFieldIsRequired":
            MessageLookupByLibrary.simpleMessage("This field is required."),
        "to_post": MessageLookupByLibrary.simpleMessage("Last Sync"),
        "to_update": MessageLookupByLibrary.simpleMessage("Last Sync"),
        "toggleBetweenListAndCardView": MessageLookupByLibrary.simpleMessage(
            "Toggle between List and Card view"),
        "toggleBrightness":
            MessageLookupByLibrary.simpleMessage("Toggle Brightness"),
        "toggleListTableView":
            MessageLookupByLibrary.simpleMessage("Toggle List/Table View"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "unknownError": m8,
        "unsavedChangesWarning":
            MessageLookupByLibrary.simpleMessage("Unsaved changes"),
        "user": MessageLookupByLibrary.simpleMessage("user"),
        "userSettings": MessageLookupByLibrary.simpleMessage("User Settings"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "validationError": MessageLookupByLibrary.simpleMessage(
            "Please correct the errors in the form."),
        "validationErrorMessage":
            MessageLookupByLibrary.simpleMessage("Validation Error Message"),
        "valueMustBeGreaterThanOrEqualToError": m9,
        "valueMustBeLessThanOrEqualToError": m10,
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "viewAvailableForms": MessageLookupByLibrary.simpleMessage(
            "Expand to View Available Forms"),
        "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
        "viewList": MessageLookupByLibrary.simpleMessage("View List"),
        "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
        "year": m11,
        "years": MessageLookupByLibrary.simpleMessage("Years"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
