// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(error) => "حدث خطأ أثناء التواصل API النظام: ${error}.";

  static String m1(error) => "شهادة غير صالحة: ${error}.";

  static String m2(error) => "طلب HTTP غير صحيح: ${error}.";

  static String m3(error) => "طلب غير صحيح: ${error}.";

  static String m4(value) => "تم نسخ ${value} للحافظة";

  static String m5(error) => "واجهت قاعدة البيانات خطأ: ${error}.";

  static String m6(error) => "لم يتم العثور على نقطة المورد: ${error}.";

  static String m7(error) => "ممنوع: ${error}.";

  static String m8(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات لهذا النشاط', one: 'تتوفر 1 استمارة', two: 'تتوفر استمارتان', other: '${count} استمارة متوفرة')}";

  static String m9(error) => "بيانات غير صالحة: ${error}.";

  static String m10(error) => "الحد الأقصى للطول المسموح به هو ${error}.";

  static String m11(count) =>
      "${Intl.plural(count, zero: ' ', one: 'شهر', two: 'شهران', few: '${count} أشهر', other: '${count} شهر')}";

  static String m12(error) => "لم يتم العثور على قاعدة بيانات نشطة: ${error}.";

  static String m13(error) =>
      "لم يتمكن من مزامنة معلومات المستخدم من السيرفر: ${error}.";

  static String m14(error) => "خطأ في الخادم: ${error}.";

  static String m15(error) => "انتهت صلاحية الجلسة: ${error}.";

  static String m16(error) =>
      "حدث خطأ أثناء مزامنة البيانات: ${error}. يرجى المحاولة مرة أخرى.";

  static String m17(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات نهائية', one: 'عدد 1 استمارة', two: 'عدد استمارتان', other: 'عدد ${count} استمارة')}";

  static String m18(error) => "وصول غير مصرح به إلى نقطة المورد: ${error}.";

  static String m19(error) =>
      "حدث خطأ غير متوقع: ${error}. يرجى المحاولة مرة أخرى.";

  static String m20(error) => "يجب أن تكون القيمة أكبر من أو تساوي ${error}.";

  static String m21(error) => "يجب أن تكون القيمة أقل من أو تساوي ${error}.";

  static String m22(count) =>
      "${Intl.plural(count, zero: '', one: 'سنة', two: 'سنتان', few: '${count} سنوات', other: '${count} سنة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("عنا"),
    "accept": MessageLookupByLibrary.simpleMessage("قبول"),
    "acceptCode": MessageLookupByLibrary.simpleMessage("معلومات الكود؟"),
    "accountDisabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب. يرجى الاتصال بالمسؤول للمساعدة.",
    ),
    "accountInformation": MessageLookupByLibrary.simpleMessage(
      "معلومات الحساب",
    ),
    "activity": MessageLookupByLibrary.simpleMessage("النشاط"),
    "addNew": MessageLookupByLibrary.simpleMessage("إضافة جديد"),
    "ageFieldHint": MessageLookupByLibrary.simpleMessage("Enter an Age"),
    "allSubmissions": MessageLookupByLibrary.simpleMessage("كل المرسلات"),
    "allocatedResources": MessageLookupByLibrary.simpleMessage(
      "الموارد المخصصة",
    ),
    "and": MessageLookupByLibrary.simpleMessage("و"),
    "apiError": m0,
    "appInformation": MessageLookupByLibrary.simpleMessage("معلومات التطبيق"),
    "appName": MessageLookupByLibrary.simpleMessage("Datarun"),
    "appVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
    "appearance": MessageLookupByLibrary.simpleMessage("المظهر"),
    "apply": MessageLookupByLibrary.simpleMessage("تطبيق"),
    "assigned": MessageLookupByLibrary.simpleMessage("مهام"),
    "assignedAssignments": MessageLookupByLibrary.simpleMessage("مهام"),
    "assignedTeam": MessageLookupByLibrary.simpleMessage("فريقك"),
    "assignmentDetail": MessageLookupByLibrary.simpleMessage("تفاصيل المهمة"),
    "assignmentList": MessageLookupByLibrary.simpleMessage("Assignment List"),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "بيانات الدخول التي تم إدخالها غير صحيحة. يرجى التحقق والمحاولة مرة أخرى.",
    ),
    "authSessionExpired": MessageLookupByLibrary.simpleMessage(
      "انتهت صلاحية الجلسة. يرجى تسجيل الدخول للمتابعة.",
    ),
    "badCertificate": m1,
    "badHttpRequest": m2,
    "badRequestToEndPoint": m3,
    "barcodeQrScan": MessageLookupByLibrary.simpleMessage("Barcode/QR Code"),
    "batch": MessageLookupByLibrary.simpleMessage("رقم التشغيلة"),
    "booleanFieldHint": MessageLookupByLibrary.simpleMessage("Enter a Boolean"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
    "changingStateMightResultClearingDependentsElements":
        MessageLookupByLibrary.simpleMessage(
          "قد يؤدي إلى تفريغ بيانات حقول تعتمد على الحالة!",
        ),
    "checkFieldsLater": MessageLookupByLibrary.simpleMessage("ليس الآن"),
    "clear": MessageLookupByLibrary.simpleMessage("تصفية"),
    "clearAll": MessageLookupByLibrary.simpleMessage("تفريق الكل"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("إلغا التصفية"),
    "closeWithoutSaving": MessageLookupByLibrary.simpleMessage("إغلاق وحذف؟"),
    "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "configurationReady": MessageLookupByLibrary.simpleMessage(
      "اكتملت تهيئة التطبيق",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟",
    ),
    "conformDeleteMsg": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد إزالة هذا القسم؟",
    ),
    "controllerNotReady": MessageLookupByLibrary.simpleMessage(
      "المتحكم غير جاهز.",
    ),
    "coordinatesFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select Coordinates",
    ),
    "copiedToClipboard": m4,
    "copyToClipboard": MessageLookupByLibrary.simpleMessage("نسخ للحافظة"),
    "count": MessageLookupByLibrary.simpleMessage("الكمية"),
    "createdDate": MessageLookupByLibrary.simpleMessage("تاريخ الإنشاء"),
    "currentUsername": MessageLookupByLibrary.simpleMessage("المستخدم الحالي"),
    "daily": MessageLookupByLibrary.simpleMessage("يومي"),
    "dashboard": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "dataFieldHint": MessageLookupByLibrary.simpleMessage("Select a date"),
    "dataTimeFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Data time",
    ),
    "databaseConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "فشل في الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى أو الاتصال بالدعم.",
    ),
    "databaseInternalError": m5,
    "databaseQueryFailed": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء معالجة طلب قاعدة البيانات. يرجى المحاولة مرة أخرى.",
    ),
    "day": MessageLookupByLibrary.simpleMessage("اليوم"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد بالتأكيد حذف هذا العنصر؟",
    ),
    "deleteItem": MessageLookupByLibrary.simpleMessage("حذف العنصر"),
    "deleteRestore": MessageLookupByLibrary.simpleMessage("حذف/استعادة"),
    "developer": MessageLookupByLibrary.simpleMessage(
      "البرنامج الوطني لمكافحة الملاريا",
    ),
    "developerInfoText": MessageLookupByLibrary.simpleMessage(
      "info@nmcpye.org",
    ),
    "developerInformation": MessageLookupByLibrary.simpleMessage(
      "معلومات المطور",
    ),
    "differentOfflineUser": MessageLookupByLibrary.simpleMessage(
      "جلسة عدم الاتصال الحالية موثقة لمستخدم مختلف.",
    ),
    "discard": MessageLookupByLibrary.simpleMessage("تجاهل"),
    "dismiss": MessageLookupByLibrary.simpleMessage("حسنًا"),
    "done": MessageLookupByLibrary.simpleMessage("اكتمل"),
    "dueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
    "dueDay": MessageLookupByLibrary.simpleMessage("يوم الاستحقاق"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editItem": MessageLookupByLibrary.simpleMessage("تعديل"),
    "emailFieldHint": MessageLookupByLibrary.simpleMessage("Enter An Email"),
    "empty": MessageLookupByLibrary.simpleMessage("فارغ"),
    "endDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
    "endPointNotFound": m6,
    "enterAValidNumber": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رقم صالح.",
    ),
    "enterYourUsername": MessageLookupByLibrary.simpleMessage(
      "من فضلك أدخل اسم المستخدم",
    ),
    "entity": MessageLookupByLibrary.simpleMessage("الكيان"),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorOpeningForm": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء فتح الاستمارة",
    ),
    "errorOpeningNewForm": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء فتح الإستمارة",
    ),
    "everyFifteenDays": MessageLookupByLibrary.simpleMessage("كل 15 يوم"),
    "everyTwoDays": MessageLookupByLibrary.simpleMessage("كل يومين"),
    "failed": MessageLookupByLibrary.simpleMessage("فشل"),
    "fetchUpdates": MessageLookupByLibrary.simpleMessage("مزامنة إعدادات"),
    "fieldContainErrors": MessageLookupByLibrary.simpleMessage("يحوي أخطاء"),
    "fieldIsMandatory": MessageLookupByLibrary.simpleMessage("الحقل مطلوب"),
    "fieldsWithErrorInfo": MessageLookupByLibrary.simpleMessage(
      "قم بالرجوع ومراجعة الإخطاء أو (ليس الآن) للحفظ والمراجعة في وقت لاحق! لن يتسنى لك تعيين الاستمارة كنهائية وإرسالها إلا بعد تصحيح الأخطاء: ",
    ),
    "fileResourceFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select A file",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("تصفية البيانات"),
    "finalData": MessageLookupByLibrary.simpleMessage("بيانات نهائية"),
    "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "forbidden": m7,
    "form": m8,
    "formContainsSomeErrors": MessageLookupByLibrary.simpleMessage(
      " يوجد أخطاء في بعض الحقول",
    ),
    "formSummaryView": MessageLookupByLibrary.simpleMessage(
      "عرض خلاصة الاستمارة",
    ),
    "forms": MessageLookupByLibrary.simpleMessage("استمارات"),
    "formsAssigned": MessageLookupByLibrary.simpleMessage("إستمارات"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "fullNameFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a full name",
    ),
    "genericError": MessageLookupByLibrary.simpleMessage("خطأ غير محدد"),
    "gtin": MessageLookupByLibrary.simpleMessage("الرقم التجاري"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("اخفاء كلمة السر"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسة"),
    "households": MessageLookupByLibrary.simpleMessage("منازل"),
    "imageFieldHint": MessageLookupByLibrary.simpleMessage("Select an Image"),
    "in_progress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "integerOrZeroFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter an integer or zero",
    ),
    "internetIsConnected": MessageLookupByLibrary.simpleMessage(
      "متصل بالإنترنت",
    ),
    "invalidData": m9,
    "invalidScannedCode": MessageLookupByLibrary.simpleMessage(
      "باركود غير صالح!",
    ),
    "itemRemoved": MessageLookupByLibrary.simpleMessage("تم الحذف"),
    "itns": MessageLookupByLibrary.simpleMessage("ناموسيات"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "lastConfigurationSyncTime": MessageLookupByLibrary.simpleMessage(
      "آخر تحديث",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("اللقب"),
    "lastSync": MessageLookupByLibrary.simpleMessage("وقت آخر مزامنة"),
    "lastSyncStatus": MessageLookupByLibrary.simpleMessage("حالة آخر تحديث"),
    "lastmodifiedDate": MessageLookupByLibrary.simpleMessage("تاريخ آخر تعديل"),
    "level": MessageLookupByLibrary.simpleMessage("المستوى"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Load More"),
    "loading": MessageLookupByLibrary.simpleMessage("تحميل ..."),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginUsername": MessageLookupByLibrary.simpleMessage("حساب تسجيل الدخول"),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutNote": MessageLookupByLibrary.simpleMessage(
      "تسجيل خروج المستخدم الحالي",
    ),
    "longTextHint": MessageLookupByLibrary.simpleMessage("Enter a text"),
    "makeFormFinalOrSaveBody": MessageLookupByLibrary.simpleMessage(
      "قم بتعيين الاستمار كنهائية حتى يتسنى لك إرسالها، أو اختر (ليس الآن) لحفظها كمسودة إلى وقت لاحق!",
    ),
    "managed": MessageLookupByLibrary.simpleMessage("إدارة"),
    "managedAssignments": MessageLookupByLibrary.simpleMessage("إدارة"),
    "managedTeams": MessageLookupByLibrary.simpleMessage("فرق تحت إدارتك"),
    "markAsFinalData": MessageLookupByLibrary.simpleMessage(
      "حقول مكتملة، هل تبريد تعيين هذه البيانات كنهائية وجاهزة للإرسال؟",
    ),
    "maximumAllowedLengthIsError": m10,
    "merged": MessageLookupByLibrary.simpleMessage("مدمج"),
    "middleName": MessageLookupByLibrary.simpleMessage("الاسم الأوسط"),
    "mobile": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
    "month": m11,
    "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
    "months": MessageLookupByLibrary.simpleMessage("أشهر"),
    "negativeIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a negative integer",
    ),
    "networkConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "فشل في الاتصال بالشبكة. يرجى التحقق من الاتصال والمحاولة مرة أخرى.",
    ),
    "networkTimeout": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.",
    ),
    "newItem": MessageLookupByLibrary.simpleMessage("إضافة"),
    "nmcpYemen": MessageLookupByLibrary.simpleMessage(
      "البرنامج الوطني لمكافحة الملاريا",
    ),
    "no": MessageLookupByLibrary.simpleMessage("لا"),
    "noActiveDatabaseFound": m12,
    "noAuthenticatedUser": MessageLookupByLibrary.simpleMessage(
      "بيانات الاعتماد المقدمة لا تطابق مستخدمًا سبق وأن سجل. لا يمكن تسجيل الدخول في وضع عدم الاتصال بالإنترنت.",
    ),
    "noAuthenticatedUserOffline": MessageLookupByLibrary.simpleMessage(
      "لم يتم توثيق المستخدم مسبقاً. لا يمكن تسجيل الدخول في وضع عدم الاتصال.",
    ),
    "noFormsAvailable": MessageLookupByLibrary.simpleMessage(
      "لا تتوفر استمارات لهذا النشاط",
    ),
    "noInternetAccess": MessageLookupByLibrary.simpleMessage("غير متصل"),
    "noMoreItems": MessageLookupByLibrary.simpleMessage("No more items."),
    "noSubmissions": MessageLookupByLibrary.simpleMessage("لا توجد بيانات"),
    "noSyncYet": MessageLookupByLibrary.simpleMessage("لم يحدث بعد"),
    "noUserDetailsFetchedFromServer": m13,
    "notNow": MessageLookupByLibrary.simpleMessage("ليس الآن"),
    "not_started": MessageLookupByLibrary.simpleMessage("لم يبدأ"),
    "notifications": MessageLookupByLibrary.simpleMessage("تنبيهات"),
    "objectAccessClosed": MessageLookupByLibrary.simpleMessage(
      "الوصول مغلق لهذا الكائن",
    ),
    "objectAccessDenied": MessageLookupByLibrary.simpleMessage(
      "الوصول مرفوض لهذا الكائن",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("موافق"),
    "oneLetterFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Letter",
    ),
    "online": MessageLookupByLibrary.simpleMessage("متصل"),
    "open": MessageLookupByLibrary.simpleMessage("فتح"),
    "openNewForm": MessageLookupByLibrary.simpleMessage("استمارة جديدة"),
    "openSettings": MessageLookupByLibrary.simpleMessage("فتح الإعدادات"),
    "orgUnitDialogTitle": MessageLookupByLibrary.simpleMessage(
      "ابحث عن المكان",
    ),
    "orgUnitHelpText": MessageLookupByLibrary.simpleMessage("اختر اسم المكان"),
    "orgUnitInputLabel": MessageLookupByLibrary.simpleMessage(
      "اختر اسم المكان",
    ),
    "organization": MessageLookupByLibrary.simpleMessage("الوحدة التنظيمية"),
    "orgunitFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select an OrgUnit",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "percentageFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a Percentage",
    ),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("تم رفض الإذن"),
    "personInformation": MessageLookupByLibrary.simpleMessage("معلومات الشخص"),
    "phoneNumberFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a phone number",
    ),
    "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال عنوان بريد إلكتروني صالح.",
    ),
    "population": MessageLookupByLibrary.simpleMessage("سكان"),
    "positiveIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter a positive integer",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "productionDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتاج"),
    "progressFieldHint": MessageLookupByLibrary.simpleMessage("fieldHintText"),
    "reassigned": MessageLookupByLibrary.simpleMessage("إعادة تعيين فريق آخر"),
    "referenceFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select a reference",
    ),
    "reported": MessageLookupByLibrary.simpleMessage("مرسل"),
    "reportedResources": MessageLookupByLibrary.simpleMessage("موارد المرسلة"),
    "rescan": MessageLookupByLibrary.simpleMessage("إعادة مسح"),
    "rescheduled": MessageLookupByLibrary.simpleMessage("جدولة"),
    "reset": MessageLookupByLibrary.simpleMessage("تفريغ"),
    "resources": MessageLookupByLibrary.simpleMessage("الموارد"),
    "restoreItem": MessageLookupByLibrary.simpleMessage("استعادة العنصر"),
    "reviewFormData": MessageLookupByLibrary.simpleMessage("مراجعة الأخطاء"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "saveAndAddAnother": MessageLookupByLibrary.simpleMessage("إضافة"),
    "saveAndCheck": MessageLookupByLibrary.simpleMessage("حفظ وتحقق"),
    "saveAndClose": MessageLookupByLibrary.simpleMessage("حفظ"),
    "saveAndEditNext": MessageLookupByLibrary.simpleMessage("حفظ ثم التالي"),
    "scanBarcode": MessageLookupByLibrary.simpleMessage("قارئ باركود"),
    "scanCodeFieldHint": MessageLookupByLibrary.simpleMessage("Scan Code"),
    "scanYourCode": MessageLookupByLibrary.simpleMessage("مسح كود"),
    "scanningIsUnsupportedOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "الجهاز لا يدعم مسح الباركود",
    ),
    "scope": MessageLookupByLibrary.simpleMessage("المسؤلية"),
    "search": MessageLookupByLibrary.simpleMessage("بحث..."),
    "searchOrgUnitsHelpText": MessageLookupByLibrary.simpleMessage(
      "البحث عن مكان...",
    ),
    "selectAColorExtractionImage": MessageLookupByLibrary.simpleMessage(
      "حدد صورة لإستخلاص الألوان",
    ),
    "selectASeedColor": MessageLookupByLibrary.simpleMessage("حدد لون الأساس"),
    "selectColorTheme": MessageLookupByLibrary.simpleMessage("ثيم الألوان"),
    "selectForm": MessageLookupByLibrary.simpleMessage("اختر استمارة"),
    "selectImageForColorExtraction": MessageLookupByLibrary.simpleMessage(
      "حدد صورة لاستخلاص ثيم منها",
    ),
    "selectMultiFieldHint": MessageLookupByLibrary.simpleMessage(
      "fieldHintText",
    ),
    "selectOneFieldHint": MessageLookupByLibrary.simpleMessage("Select One"),
    "selected": MessageLookupByLibrary.simpleMessage("عناصر محددة"),
    "send": MessageLookupByLibrary.simpleMessage("إرسال"),
    "serial": MessageLookupByLibrary.simpleMessage("التسلسلي"),
    "serverError": m14,
    "serverUrl": MessageLookupByLibrary.simpleMessage("رابط السيرفر"),
    "sessionExpired": m15,
    "settings": MessageLookupByLibrary.simpleMessage("إعدادات"),
    "showPassword": MessageLookupByLibrary.simpleMessage("أظهر كلمة السر"),
    "startDate": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
    "startingSync": MessageLookupByLibrary.simpleMessage("بدء التحديث"),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "submissionDataEntry": MessageLookupByLibrary.simpleMessage("بيانات"),
    "submissionInitialData": MessageLookupByLibrary.simpleMessage("الرئيسة"),
    "syncError": m16,
    "syncFormData": MessageLookupByLibrary.simpleMessage(
      "مزامنة بيانات الاستمارة",
    ),
    "syncInterval": MessageLookupByLibrary.simpleMessage(
      "ظبط فترة التحديث التلقائي",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("التحديث الآن"),
    "syncSettings": MessageLookupByLibrary.simpleMessage("التحديث التلقائي"),
    "syncSubmissions": m17,
    "synced": MessageLookupByLibrary.simpleMessage("مزامنة"),
    "syncingConfiguration": MessageLookupByLibrary.simpleMessage(
      "إعدادات المزامنة",
    ),
    "syncingData": MessageLookupByLibrary.simpleMessage("مزامنة بيانات"),
    "syncingEvents": MessageLookupByLibrary.simpleMessage("مزامنة الإستمارات"),
    "team": MessageLookupByLibrary.simpleMessage("الفريق"),
    "teamFieldHint": MessageLookupByLibrary.simpleMessage("Select a Team"),
    "teams": MessageLookupByLibrary.simpleMessage("الفرق"),
    "textHint": MessageLookupByLibrary.simpleMessage("Enter a text"),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب.",
    ),
    "timeFieldHint": MessageLookupByLibrary.simpleMessage("Select a Time"),
    "to_post": MessageLookupByLibrary.simpleMessage("نهائية"),
    "to_update": MessageLookupByLibrary.simpleMessage("مسودة"),
    "toggleBetweenListAndCardView": MessageLookupByLibrary.simpleMessage(
      "تغيير بين قائمة/جدول",
    ),
    "toggleBrightness": MessageLookupByLibrary.simpleMessage("تبديل الإضاءة"),
    "toggleListTableView": MessageLookupByLibrary.simpleMessage(
      "تحويل بين قائمة/جدول",
    ),
    "trueOnlyFieldHint": MessageLookupByLibrary.simpleMessage("fieldHintText"),
    "unauthorizedAccessToEndPoint": m18,
    "undo": MessageLookupByLibrary.simpleMessage("تراجع"),
    "unexpected": m19,
    "unsavedChangesWarning": MessageLookupByLibrary.simpleMessage(
      "تغييرات غير محفوظة",
    ),
    "urlFieldHint": MessageLookupByLibrary.simpleMessage("Enter a URL"),
    "user": MessageLookupByLibrary.simpleMessage("مستخدم"),
    "userSettings": MessageLookupByLibrary.simpleMessage("إعدادات المستخدم"),
    "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "usernameFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select a Username",
    ),
    "validationError": MessageLookupByLibrary.simpleMessage(
      "يرجى تصحيح الأخطاء في النموذج قبل المتابعة.",
    ),
    "validationErrorMessage": MessageLookupByLibrary.simpleMessage("خطأ تحقق"),
    "valueMustBeGreaterThanOrEqualToError": m20,
    "valueMustBeLessThanOrEqualToError": m21,
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "viewAvailableForms": MessageLookupByLibrary.simpleMessage(
      "افتح لاستعرض الاستمارات المتاحة",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
    "viewList": MessageLookupByLibrary.simpleMessage("عرض القائمة"),
    "weekly": MessageLookupByLibrary.simpleMessage("اسبوعي"),
    "year": m22,
    "years": MessageLookupByLibrary.simpleMessage("سنوات"),
    "yes": MessageLookupByLibrary.simpleMessage("نعم"),
    "yesOrNoFieldHint": MessageLookupByLibrary.simpleMessage(
      "Select Yes or No",
    ),
  };
}
