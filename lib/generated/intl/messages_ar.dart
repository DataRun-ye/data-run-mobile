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

  static String m1(error) => "شهادة غير صالحة: ${error}";

  static String m2(error) => "طلب HTTP غير صحيح: ${error}.";

  static String m3(error) => "طلب غير صحيح: ${error}.";

  static String m4(error) => "bad response: ${error}";

  static String m5(error) => "لم يتمكن من الإتصال بالسيرفر: ${error}";

  static String m6(error) =>
      "الإتصال بالسيرفر يستغرق وقتًا طويلًا، ابحث عن انترنت جيد وحاول مجدداً: ${error}";

  static String m7(value) => "تم نسخ ${value} للحافظة";

  static String m8(error) => "واجهت قاعدة البيانات خطأ: ${error}.";

  static String m9(error) => "لم يتم العثور على نقطة المورد: ${error}.";

  static String m10(error) => "ممنوع: ${error}.";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات لهذا النشاط', one: 'تتوفر 1 استمارة', two: 'تتوفر استمارتان', other: '${count} استمارة متوفرة')}";

  static String m12(error) => "بيانات غير صالحة: ${error}.";

  static String m13(error) => "الحد الأقصى للطول المسموح به هو ${error}.";

  static String m14(count) =>
      "${Intl.plural(count, zero: ' ', one: 'شهر', two: 'شهران', few: '${count} أشهر', other: '${count} شهر')}";

  static String m15(error) => "لم يتم العثور على قاعدة بيانات نشطة: ${error}.";

  static String m16(error) =>
      "لم يتمكن من مزامنة معلومات المستخدم من السيرفر: ${error}.";

  static String m17(error) =>
      "الإتصال بالسيرفر يستغرق وقتًا طويلًا، حاول مرة أخرى: ${error}";

  static String m18(error) =>
      "الإتصال بالسيرفر يستغرق وقتًا طويلًا، حاول مرة أخرى: ${error}";

  static String m19(error) => "خطأ في الخادم: ${error}.";

  static String m20(error) => "انتهت صلاحية الجلسة: ${error}.";

  static String m21(error) =>
      "حدث خطأ أثناء مزامنة البيانات: ${error}. يرجى المحاولة مرة أخرى.";

  static String m22(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات نهائية', one: 'عدد 1 استمارة', two: 'عدد استمارتان', other: 'عدد ${count} استمارة')}";

  static String m23(error) => "خطأ عند محاولة الوصول لملفات التخزين: ${error}";

  static String m24(error) => "وصول غير مصرح به إلى نقطة المورد: ${error}.";

  static String m25(error) =>
      "حدث خطأ غير متوقع: ${error}. يرجى المحاولة مرة أخرى.";

  static String m26(error) => "يجب أن تكون القيمة أكبر من أو تساوي ${error}.";

  static String m27(error) => "يجب أن تكون القيمة أقل من أو تساوي ${error}.";

  static String m28(count) =>
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
    "actionNeedsConfirmation": MessageLookupByLibrary.simpleMessage(
      "تأكيد الطلب",
    ),
    "activities": MessageLookupByLibrary.simpleMessage("الأنشطة"),
    "activity": MessageLookupByLibrary.simpleMessage("النشاط"),
    "addNew": MessageLookupByLibrary.simpleMessage("جديد"),
    "ageFieldHint": MessageLookupByLibrary.simpleMessage("أدخل العمر"),
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
    "assignmentList": MessageLookupByLibrary.simpleMessage("قائمة المهام"),
    "assignments": MessageLookupByLibrary.simpleMessage("المهام"),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "بيانات الدخول التي تم إدخالها غير صحيحة. يرجى التحقق والمحاولة مرة أخرى.",
    ),
    "authSessionExpired": MessageLookupByLibrary.simpleMessage(
      "انتهت صلاحية الجلسة. يرجى تسجيل الدخول للمتابعة.",
    ),
    "badCertificate": m1,
    "badHttpRequest": m2,
    "badRequestToEndPoint": m3,
    "badResponse": m4,
    "barcodeQrScan": MessageLookupByLibrary.simpleMessage("Barcode/QR Code"),
    "batch": MessageLookupByLibrary.simpleMessage("رقم التشغيلة"),
    "booleanFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل قيمة منطقية",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
    "checkFieldsLater": MessageLookupByLibrary.simpleMessage("ليس الآن"),
    "checkingSession": MessageLookupByLibrary.simpleMessage(
      "ضبط جلسة المستخدم...",
    ),
    "clear": MessageLookupByLibrary.simpleMessage("تصفية"),
    "clearAll": MessageLookupByLibrary.simpleMessage("تفريق الكل"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("إلغا التصفية"),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "closeWithoutSaving": MessageLookupByLibrary.simpleMessage("إغلاق وحذف؟"),
    "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "configurationReady": MessageLookupByLibrary.simpleMessage(
      "اكتملت تهيئة التطبيق",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟",
    ),
    "confirmationWarning": MessageLookupByLibrary.simpleMessage(
      "قد يؤدي تغيير الخيار إلى تفريغ أي بيانات تعتمد على إجابة هذا السؤال، تأكيد؟",
    ),
    "conformDeleteMsg": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد إزالة هذا القسم؟",
    ),
    "connectionError": m5,
    "connectionTimeout": m6,
    "controllerNotReady": MessageLookupByLibrary.simpleMessage(
      "المتحكم غير جاهز.",
    ),
    "coordinatesFieldHint": MessageLookupByLibrary.simpleMessage(
      "اختر إحداثيات",
    ),
    "copiedToClipboard": m7,
    "copyAll": MessageLookupByLibrary.simpleMessage("نسخ الكل"),
    "copyToClipboard": MessageLookupByLibrary.simpleMessage("نسخ للحافظة"),
    "count": MessageLookupByLibrary.simpleMessage("الكمية"),
    "createdDate": MessageLookupByLibrary.simpleMessage("تاريخ الإنشاء"),
    "currentOperations": MessageLookupByLibrary.simpleMessage(
      "العملية الحالية:",
    ),
    "currentUsername": MessageLookupByLibrary.simpleMessage("المستخدم الحالي"),
    "daily": MessageLookupByLibrary.simpleMessage("يومي"),
    "dashboard": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "dataElements": MessageLookupByLibrary.simpleMessage("عناصر البيانات"),
    "dataFieldHint": MessageLookupByLibrary.simpleMessage("اختر تاريخًا"),
    "dataSubmissions": MessageLookupByLibrary.simpleMessage("بيانات مرسلة"),
    "dataTimeFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل تاريخًا ووقتًا",
    ),
    "databaseConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "فشل في الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى أو الاتصال بالدعم.",
    ),
    "databaseInternalError": m8,
    "databaseQueryFailed": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء معالجة طلب قاعدة البيانات. يرجى المحاولة مرة أخرى.",
    ),
    "datarun": MessageLookupByLibrary.simpleMessage("DATARUN"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("تاريخ الميلاد"),
    "day": MessageLookupByLibrary.simpleMessage("اليوم"),
    "days": MessageLookupByLibrary.simpleMessage("أيام"),
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
    "downloaded": MessageLookupByLibrary.simpleMessage("حفظ"),
    "dueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
    "dueDay": MessageLookupByLibrary.simpleMessage("يوم الاستحقاق"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editItem": MessageLookupByLibrary.simpleMessage("تعديل"),
    "emailFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدًا إلكترونيًا",
    ),
    "empty": MessageLookupByLibrary.simpleMessage("فارغ"),
    "endDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
    "endPointNotFound": m9,
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
    "errorSummary": MessageLookupByLibrary.simpleMessage("ملخص الأخطاء"),
    "everyFifteenDays": MessageLookupByLibrary.simpleMessage("كل 15 يوم"),
    "everyTwoDays": MessageLookupByLibrary.simpleMessage("كل يومين"),
    "failed": MessageLookupByLibrary.simpleMessage("فشل"),
    "failureCount": MessageLookupByLibrary.simpleMessage("عدد الإخفاقات"),
    "fetchUpdates": MessageLookupByLibrary.simpleMessage("مزامنة إعدادات"),
    "fieldContainErrors": MessageLookupByLibrary.simpleMessage("يحوي أخطاء"),
    "fieldIsMandatory": MessageLookupByLibrary.simpleMessage("الحقل مطلوب"),
    "fieldsWithErrorInfo": MessageLookupByLibrary.simpleMessage(
      "قم بالرجوع ومراجعة الإخطاء أو (ليس الآن) للحفظ والمراجعة في وقت لاحق! لن يتسنى لك تعيين الاستمارة كنهائية وإرسالها إلا بعد تصحيح الأخطاء: ",
    ),
    "fileResourceFieldHint": MessageLookupByLibrary.simpleMessage("اختر ملفًا"),
    "filters": MessageLookupByLibrary.simpleMessage("تصفية البيانات"),
    "finalData": MessageLookupByLibrary.simpleMessage("بيانات نهائية"),
    "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "forbidden": m10,
    "form": m11,
    "formContainsSomeErrors": MessageLookupByLibrary.simpleMessage(
      " يوجد أخطاء في بعض الحقول",
    ),
    "formSummaryView": MessageLookupByLibrary.simpleMessage(
      "عرض خلاصة الاستمارة",
    ),
    "formTemplates": MessageLookupByLibrary.simpleMessage("النماذج"),
    "forms": MessageLookupByLibrary.simpleMessage("استمارات"),
    "formsAssigned": MessageLookupByLibrary.simpleMessage("إستمارات"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "fullNameFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل الاسم الكامل",
    ),
    "genericError": MessageLookupByLibrary.simpleMessage("خطأ غير محدد"),
    "gtin": MessageLookupByLibrary.simpleMessage("الرقم التجاري"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("اخفاء كلمة السر"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسة"),
    "households": MessageLookupByLibrary.simpleMessage("منازل"),
    "imageFieldHint": MessageLookupByLibrary.simpleMessage("اختر صورة"),
    "in_progress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "integerFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل عددًا صحيحًا",
    ),
    "integerOrZeroFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل عددًا صحيحًا أو صفرًا",
    ),
    "internetIsConnected": MessageLookupByLibrary.simpleMessage(
      "متصل بالإنترنت",
    ),
    "invalidData": m12,
    "invalidScannedCode": MessageLookupByLibrary.simpleMessage(
      "باركود غير صالح!",
    ),
    "itemRemoved": MessageLookupByLibrary.simpleMessage("تم الحذف"),
    "itns": MessageLookupByLibrary.simpleMessage("ناموسيات"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "lastConfigurationSyncTime": MessageLookupByLibrary.simpleMessage(
      "آخر مزامنة",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("اللقب"),
    "lastSync": MessageLookupByLibrary.simpleMessage("وقت آخر مزامنة"),
    "lastSyncStatus": MessageLookupByLibrary.simpleMessage(
      "حالة آخر عملية مزامنة",
    ),
    "lastmodifiedDate": MessageLookupByLibrary.simpleMessage("تاريخ آخر تعديل"),
    "level": MessageLookupByLibrary.simpleMessage("المستوى"),
    "loadMore": MessageLookupByLibrary.simpleMessage("تحميل المزيد"),
    "loading": MessageLookupByLibrary.simpleMessage("تحميل ..."),
    "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج؟"),
    "logOutAnyway": MessageLookupByLibrary.simpleMessage("نأكيد تسجيل الخروج"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل دخول النظام"),
    "loginUsername": MessageLookupByLibrary.simpleMessage("حساب تسجيل الدخول"),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutNote": MessageLookupByLibrary.simpleMessage(
      "تسجيل خروج المستخدم الحالي",
    ),
    "longTextHint": MessageLookupByLibrary.simpleMessage(
      "أدخل نصًا لا يتجاوز 500 حرف",
    ),
    "makeFormFinalOrSaveBody": MessageLookupByLibrary.simpleMessage(
      "قم بتعيين الاستمار كنهائية حتى يتسنى لك إرسالها، أو اختر (ليس الآن) لحفظها كمسودة إلى وقت لاحق!",
    ),
    "managed": MessageLookupByLibrary.simpleMessage("إدارة"),
    "managedAssignments": MessageLookupByLibrary.simpleMessage("إدارة"),
    "managedTeams": MessageLookupByLibrary.simpleMessage("فرق تحت إدارتك"),
    "markAsFinalData": MessageLookupByLibrary.simpleMessage(
      "حقول مكتملة، هل تبريد تعيين هذه البيانات كنهائية وجاهزة للإرسال؟",
    ),
    "materialVersion": MessageLookupByLibrary.simpleMessage("Material Version"),
    "maximumAllowedLengthIsError": m13,
    "merged": MessageLookupByLibrary.simpleMessage("مدمج"),
    "middleName": MessageLookupByLibrary.simpleMessage("الاسم الأوسط"),
    "mobile": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
    "month": m14,
    "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
    "months": MessageLookupByLibrary.simpleMessage("أشهر"),
    "negativeIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل عددًا صحيحًا سالبًا",
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
    "noActiveDatabaseFound": m15,
    "noActivitiesYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد أنشطة حتى الآن",
    ),
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
    "noMoreItems": MessageLookupByLibrary.simpleMessage("لا توجد عناصر أخرى."),
    "noSubmissions": MessageLookupByLibrary.simpleMessage("لا توجد بيانات"),
    "noSyncYet": MessageLookupByLibrary.simpleMessage("لم يحدث بعد"),
    "noSyncsYet": MessageLookupByLibrary.simpleMessage("لم تتم أي مزامنة بعد"),
    "noUserDetailsFetchedFromServer": m16,
    "notNow": MessageLookupByLibrary.simpleMessage("ليس الآن"),
    "not_started": MessageLookupByLibrary.simpleMessage("لم يبدأ"),
    "notifications": MessageLookupByLibrary.simpleMessage("تنبيهات"),
    "numberFieldHint": MessageLookupByLibrary.simpleMessage("أدخل رقمًا"),
    "objectAccessClosed": MessageLookupByLibrary.simpleMessage(
      "الوصول مغلق لهذا الكائن",
    ),
    "objectAccessDenied": MessageLookupByLibrary.simpleMessage(
      "الوصول مرفوض لهذا الكائن",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("موافق"),
    "oneLetterFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل حرفًا واحدًا",
    ),
    "online": MessageLookupByLibrary.simpleMessage("متصل"),
    "open": MessageLookupByLibrary.simpleMessage("فتح"),
    "openNewForm": MessageLookupByLibrary.simpleMessage("استمارة جديدة"),
    "openSettings": MessageLookupByLibrary.simpleMessage("فتح الإعدادات"),
    "optionSets": MessageLookupByLibrary.simpleMessage("مجموعات الاختيار"),
    "options": MessageLookupByLibrary.simpleMessage("خيارات"),
    "orgUnitDialogTitle": MessageLookupByLibrary.simpleMessage(
      "ابحث عن المكان",
    ),
    "orgUnitHelpText": MessageLookupByLibrary.simpleMessage("اختر اسم المكان"),
    "orgUnitInputLabel": MessageLookupByLibrary.simpleMessage(
      "اختر اسم المكان",
    ),
    "orgUnits": MessageLookupByLibrary.simpleMessage("وحدات تنظيمة"),
    "organization": MessageLookupByLibrary.simpleMessage("الوحدة التنظيمية"),
    "orgunitFieldHint": MessageLookupByLibrary.simpleMessage(
      "اختر وحدة تنظيمية",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "percentageFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل نسبة مئوية",
    ),
    "performFirstSync": MessageLookupByLibrary.simpleMessage(
      "قم بالمزامنة الأولى",
    ),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("تم رفض الإذن"),
    "personInformation": MessageLookupByLibrary.simpleMessage("معلومات الشخص"),
    "phoneNumberFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم هاتف",
    ),
    "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال عنوان بريد إلكتروني صالح.",
    ),
    "population": MessageLookupByLibrary.simpleMessage("سكان"),
    "positiveIntegerFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل عددًا صحيحًا موجبًا",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "productionDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتاج"),
    "progressFieldHint": MessageLookupByLibrary.simpleMessage("أدخل تقدمًا"),
    "projects": MessageLookupByLibrary.simpleMessage("المشاريع"),
    "reassigned": MessageLookupByLibrary.simpleMessage("إعادة تعيين فريق آخر"),
    "receiveTimeout": m17,
    "referenceFieldHint": MessageLookupByLibrary.simpleMessage("اختر مرجعًا"),
    "reported": MessageLookupByLibrary.simpleMessage("مرسل"),
    "reportedResources": MessageLookupByLibrary.simpleMessage("موارد المرسلة"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage("تم إلغاء الطلب"),
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
    "scanCodeFieldHint": MessageLookupByLibrary.simpleMessage("امسح الرمز"),
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
      "اختر خيارات متعددة",
    ),
    "selectOneFieldHint": MessageLookupByLibrary.simpleMessage(
      "اختر خيارًا واحدًا",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("عناصر محددة"),
    "send": MessageLookupByLibrary.simpleMessage("إرسال"),
    "sendTimeout": m18,
    "serial": MessageLookupByLibrary.simpleMessage("التسلسلي"),
    "serverError": m19,
    "serverUrl": MessageLookupByLibrary.simpleMessage("رابط السيرفر"),
    "sessionExpired": m20,
    "settings": MessageLookupByLibrary.simpleMessage("إعدادات"),
    "showLess": MessageLookupByLibrary.simpleMessage("عرض أقل"),
    "showMore": MessageLookupByLibrary.simpleMessage("عرض المزيد"),
    "showPassword": MessageLookupByLibrary.simpleMessage("أظهر كلمة السر"),
    "signingOutWarning": MessageLookupByLibrary.simpleMessage(
      "سيؤدي تسجيل الخروج إلى فقدان أي تغييرات لم يتم مزامنتها. هل أنت متأكد أنك تريد تسجيل الخروج؟",
    ),
    "startDate": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
    "startingSync": MessageLookupByLibrary.simpleMessage("بدء التحديث"),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "submissionDataEntry": MessageLookupByLibrary.simpleMessage("بيانات"),
    "submissionInitialData": MessageLookupByLibrary.simpleMessage("الرئيسة"),
    "successCount": MessageLookupByLibrary.simpleMessage("عدد النجاحات"),
    "syncError": m21,
    "syncErrors": MessageLookupByLibrary.simpleMessage("أخطاء المزامنة"),
    "syncFormData": MessageLookupByLibrary.simpleMessage(
      "مزامنة بيانات الاستمارة",
    ),
    "syncInterval": MessageLookupByLibrary.simpleMessage(
      "ظبط فترة التحديث التلقائي",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("التحديث الآن"),
    "syncProgressDashboard": MessageLookupByLibrary.simpleMessage(
      "مزامنة إعدادات المستخدم",
    ),
    "syncSettings": MessageLookupByLibrary.simpleMessage("التحديث التلقائي"),
    "syncSubmissions": m22,
    "syncSummaryLoadError": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل ملخص المزامنة",
    ),
    "syncSummaryTitle": MessageLookupByLibrary.simpleMessage("ملخص المزامنة"),
    "synced": MessageLookupByLibrary.simpleMessage("مزامنة"),
    "syncingConfiguration": MessageLookupByLibrary.simpleMessage(
      "إعدادات المزامنة",
    ),
    "syncingData": MessageLookupByLibrary.simpleMessage("مزامنة بيانات"),
    "syncingEvents": MessageLookupByLibrary.simpleMessage("مزامنة الإستمارات"),
    "systemFilesAccessError": m23,
    "team": MessageLookupByLibrary.simpleMessage("الفريق"),
    "teamFieldHint": MessageLookupByLibrary.simpleMessage("اختر فريقًا"),
    "teams": MessageLookupByLibrary.simpleMessage("الفرق"),
    "textHint": MessageLookupByLibrary.simpleMessage("أدخل نصًا"),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب.",
    ),
    "timeFieldHint": MessageLookupByLibrary.simpleMessage("اختر وقتًا"),
    "to_post": MessageLookupByLibrary.simpleMessage("نهائية"),
    "to_update": MessageLookupByLibrary.simpleMessage("مسودة"),
    "toggleBetweenListAndCardView": MessageLookupByLibrary.simpleMessage(
      "تغيير بين قائمة/جدول",
    ),
    "toggleBrightness": MessageLookupByLibrary.simpleMessage("تبديل الإضاءة"),
    "toggleListTableView": MessageLookupByLibrary.simpleMessage(
      "تحويل بين قائمة/جدول",
    ),
    "trueOnlyFieldHint": MessageLookupByLibrary.simpleMessage("قيمة صحيحة فقط"),
    "unauthorizedAccessToEndPoint": m24,
    "undo": MessageLookupByLibrary.simpleMessage("تراجع"),
    "unexpected": m25,
    "unitIntervalFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل قيمة بين 0 و1",
    ),
    "unknownValueType": MessageLookupByLibrary.simpleMessage(
      "نوع غير معروف للقيمة",
    ),
    "unsavedChangesWarning": MessageLookupByLibrary.simpleMessage(
      "تغييرات غير محفوظة",
    ),
    "unsupportedValueType": MessageLookupByLibrary.simpleMessage(
      "نوع غير مدعوم للقيمة",
    ),
    "urlFieldHint": MessageLookupByLibrary.simpleMessage("أدخل رابط URL"),
    "user": MessageLookupByLibrary.simpleMessage("مستخدم"),
    "userSettings": MessageLookupByLibrary.simpleMessage("إعدادات المستخدم"),
    "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "usernameFieldHint": MessageLookupByLibrary.simpleMessage(
      "أدخل اسم مستخدم",
    ),
    "validationError": MessageLookupByLibrary.simpleMessage(
      "يرجى تصحيح الأخطاء في النموذج قبل المتابعة.",
    ),
    "validationErrorMessage": MessageLookupByLibrary.simpleMessage("خطأ تحقق"),
    "valueMustBeGreaterThanOrEqualToError": m26,
    "valueMustBeLessThanOrEqualToError": m27,
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "viewAvailableForms": MessageLookupByLibrary.simpleMessage(
      "افتح لاستعرض الاستمارات المتاحة",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("تفاصيل"),
    "viewErrors": MessageLookupByLibrary.simpleMessage("عرض الأخطاء"),
    "viewList": MessageLookupByLibrary.simpleMessage("عرض القائمة"),
    "weekly": MessageLookupByLibrary.simpleMessage("اسبوعي"),
    "year": m28,
    "years": MessageLookupByLibrary.simpleMessage("سنوات"),
    "yearsMonths": MessageLookupByLibrary.simpleMessage("أشهر/سنوات"),
    "yes": MessageLookupByLibrary.simpleMessage("نعم"),
    "yesOrNoFieldHint": MessageLookupByLibrary.simpleMessage("اختر نعم أو لا"),
  };
}
