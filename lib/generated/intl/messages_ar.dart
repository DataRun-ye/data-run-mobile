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

  static String m1(value) => "${value} نسخ للحافظة";

  static String m2(error) => "واجهت قاعدة البيانات خطأ: ${error}.";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات لهذا النشاط', one: 'تتوفر 1 استمارة', two: 'تتوفر استمارتان', other: '${count} استمارة متوفرة')}";

  static String m4(error) => "الحد الأقصى للطول المسموح به هو ${error}.";

  static String m5(count) =>
      "${Intl.plural(count, zero: ' ', one: 'شهر', two: 'شهران', few: '${count} أشهر', other: '${count} شهر')}";

  static String m6(error) =>
      "حدث خطأ أثناء مزامنة البيانات: ${error}. يرجى المحاولة مرة أخرى.";

  static String m7(count) =>
      "${Intl.plural(count, zero: 'لا تتوفر استمارات نهائية', one: 'عدد 1 استمارة', two: 'عدد استمارتان', other: 'عدد ${count} استمارة')}";

  static String m8(error) =>
      "حدث خطأ غير متوقع: ${error}. يرجى المحاولة مرة أخرى.";

  static String m9(error) => "يجب أن تكون القيمة أكبر من أو تساوي ${error}.";

  static String m10(error) => "يجب أن تكون القيمة أقل من أو تساوي ${error}.";

  static String m11(count) =>
      "${Intl.plural(count, zero: '', one: 'سنة', two: 'سنتان', few: '${count} سنوات', other: '${count} سنة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("عنا"),
        "accept": MessageLookupByLibrary.simpleMessage("قبول"),
        "acceptCode": MessageLookupByLibrary.simpleMessage("معلومات الكود؟"),
        "accountDisabled": MessageLookupByLibrary.simpleMessage(
            "تم تعطيل هذا الحساب. يرجى الاتصال بالمسؤول للمساعدة."),
        "accountInformation":
            MessageLookupByLibrary.simpleMessage("معلومات الحساب"),
        "activity": MessageLookupByLibrary.simpleMessage("النشاط"),
        "addNew": MessageLookupByLibrary.simpleMessage("إضافة جديد"),
        "allSubmissions": MessageLookupByLibrary.simpleMessage("كل المرسلات"),
        "allocatedResources":
            MessageLookupByLibrary.simpleMessage("الموارد المخصصة"),
        "and": MessageLookupByLibrary.simpleMessage("و"),
        "apiError": m0,
        "appInformation":
            MessageLookupByLibrary.simpleMessage("معلومات التطبيق"),
        "appName": MessageLookupByLibrary.simpleMessage("Datarun"),
        "appVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
        "appearance": MessageLookupByLibrary.simpleMessage("المظهر"),
        "apply": MessageLookupByLibrary.simpleMessage("تطبيق"),
        "assigned": MessageLookupByLibrary.simpleMessage("مهام"),
        "assignedAssignments": MessageLookupByLibrary.simpleMessage("مهام"),
        "assignedTeam": MessageLookupByLibrary.simpleMessage("فريقك"),
        "assignmentDetail":
            MessageLookupByLibrary.simpleMessage("تفاصيل المهمة"),
        "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "بيانات الدخول التي تم إدخالها غير صحيحة. يرجى التحقق والمحاولة مرة أخرى."),
        "authSessionExpired": MessageLookupByLibrary.simpleMessage(
            "انتهت صلاحية الجلسة. يرجى تسجيل الدخول للمتابعة."),
        "barcodeQrScan":
            MessageLookupByLibrary.simpleMessage("Barcode/QR Code"),
        "batch": MessageLookupByLibrary.simpleMessage("رقم التشغيلة"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "cancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
        "changingStateMightResultClearingDependentsElements":
            MessageLookupByLibrary.simpleMessage(
                "قد يؤدي إلى تفريغ بيانات حقول تعتمد على الحالة!"),
        "checkFieldsLater": MessageLookupByLibrary.simpleMessage("ليس الآن"),
        "clear": MessageLookupByLibrary.simpleMessage("تصفية"),
        "clearAll": MessageLookupByLibrary.simpleMessage("تفريق الكل"),
        "clearFilters": MessageLookupByLibrary.simpleMessage("إلغا التصفية"),
        "closeWithoutSaving":
            MessageLookupByLibrary.simpleMessage("إغلاق وحذف؟"),
        "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "configurationReady":
            MessageLookupByLibrary.simpleMessage("اكتملت تهيئة التطبيق"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟"),
        "conformDeleteMsg": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد إزالة هذا القسم؟"),
        "controllerNotReady":
            MessageLookupByLibrary.simpleMessage("المتحكم غير جاهز."),
        "copiedToClipboard": m1,
        "count": MessageLookupByLibrary.simpleMessage("الكمية"),
        "createdDate": MessageLookupByLibrary.simpleMessage("تاريخ الإنشاء"),
        "currentUsername":
            MessageLookupByLibrary.simpleMessage("المستخدم الحالي"),
        "daily": MessageLookupByLibrary.simpleMessage("يومي"),
        "dashboard": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "databaseConnectionFailed": MessageLookupByLibrary.simpleMessage(
            "فشل في الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى أو الاتصال بالدعم."),
        "databaseInternalError": m2,
        "databaseQueryFailed": MessageLookupByLibrary.simpleMessage(
            "حدث خطأ أثناء معالجة طلب قاعدة البيانات. يرجى المحاولة مرة أخرى."),
        "day": MessageLookupByLibrary.simpleMessage("اليوم"),
        "delete": MessageLookupByLibrary.simpleMessage("حذف"),
        "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
            "هل تريد بالتأكيد حذف هذا العنصر؟"),
        "developer": MessageLookupByLibrary.simpleMessage(
            "البرنامج الوطني لمكافحة الملاريا"),
        "developerInfoText":
            MessageLookupByLibrary.simpleMessage("info@nmcpye.org"),
        "developerInformation":
            MessageLookupByLibrary.simpleMessage("معلومات المطور"),
        "differentOfflineUser": MessageLookupByLibrary.simpleMessage(
            "جلسة عدم الاتصال الحالية موثقة لمستخدم مختلف."),
        "discard": MessageLookupByLibrary.simpleMessage("تجاهل"),
        "dismiss": MessageLookupByLibrary.simpleMessage("حسنًا"),
        "done": MessageLookupByLibrary.simpleMessage("اكتمل"),
        "dueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "dueDay": MessageLookupByLibrary.simpleMessage("يوم الاستحقاق"),
        "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
        "editItem": MessageLookupByLibrary.simpleMessage("تعديل"),
        "empty": MessageLookupByLibrary.simpleMessage("فارغ"),
        "endDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
        "enterAValidNumber":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال رقم صالح."),
        "enterYourUsername":
            MessageLookupByLibrary.simpleMessage("من فضلك أدخل اسم المستخدم"),
        "entity": MessageLookupByLibrary.simpleMessage("الكيان"),
        "error": MessageLookupByLibrary.simpleMessage("خطأ"),
        "errorOpeningForm":
            MessageLookupByLibrary.simpleMessage("حدث خطأ أثناء فتح الاستمارة"),
        "errorOpeningNewForm":
            MessageLookupByLibrary.simpleMessage("حدث خطأ أثناء فتح الإستمارة"),
        "everyFifteenDays": MessageLookupByLibrary.simpleMessage("كل 15 يوم"),
        "everyTwoDays": MessageLookupByLibrary.simpleMessage("كل يومين"),
        "failed": MessageLookupByLibrary.simpleMessage("فشل"),
        "fetchUpdates": MessageLookupByLibrary.simpleMessage("مزامنة إعدادات"),
        "fieldContainErrors":
            MessageLookupByLibrary.simpleMessage("يحوي أخطاء"),
        "fieldsWithErrorInfo": MessageLookupByLibrary.simpleMessage(
            "قم بالرجوع ومراجعة الإخطاء أو (ليس الآن) للحفظ والمراجعة في وقت لاحق! لن يتسنى لك تعيين الاستمارة كنهائية وإرسالها إلا بعد تصحيح الأخطاء: "),
        "filters": MessageLookupByLibrary.simpleMessage("تصفية البيانات"),
        "finalData": MessageLookupByLibrary.simpleMessage("بيانات نهائية"),
        "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
        "form": m3,
        "formContainsSomeErrors":
            MessageLookupByLibrary.simpleMessage(" يوجد أخطاء في بعض الحقول"),
        "formSummaryView":
            MessageLookupByLibrary.simpleMessage("عرض خلاصة الاستمارة"),
        "forms": MessageLookupByLibrary.simpleMessage("استمارات"),
        "formsAssigned": MessageLookupByLibrary.simpleMessage("إستمارات"),
        "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
        "genericError": MessageLookupByLibrary.simpleMessage("خطأ غير محدد"),
        "gtin": MessageLookupByLibrary.simpleMessage("الرقم التجاري"),
        "hidePassword": MessageLookupByLibrary.simpleMessage("اخفاء كلمة السر"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسة"),
        "households": MessageLookupByLibrary.simpleMessage("منازل"),
        "in_progress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "internetIsConnected":
            MessageLookupByLibrary.simpleMessage("متصل بالإنترنت"),
        "invalidScannedCode":
            MessageLookupByLibrary.simpleMessage("باركود غير صالح!"),
        "itemRemoved": MessageLookupByLibrary.simpleMessage("تم الحذف"),
        "itns": MessageLookupByLibrary.simpleMessage("ناموسيات"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "lastConfigurationSyncTime":
            MessageLookupByLibrary.simpleMessage("آخر تحديث"),
        "lastName": MessageLookupByLibrary.simpleMessage("اللقب"),
        "lastSync": MessageLookupByLibrary.simpleMessage("وقت آخر مزامنة"),
        "lastSyncStatus":
            MessageLookupByLibrary.simpleMessage("حالة آخر تحديث"),
        "lastmodifiedDate":
            MessageLookupByLibrary.simpleMessage("تاريخ آخر تعديل"),
        "level": MessageLookupByLibrary.simpleMessage("المستوى"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginUsername":
            MessageLookupByLibrary.simpleMessage("حساب تسجيل الدخول"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "logoutNote":
            MessageLookupByLibrary.simpleMessage("تسجيل خروج المستخدم الحالي"),
        "makeFormFinalOrSaveBody": MessageLookupByLibrary.simpleMessage(
            "قم بتعيين الاستمار كنهائية حتى يتسنى لك إرسالها، أو اختر (ليس الآن) لحفظها كمسودة إلى وقت لاحق!"),
        "managed": MessageLookupByLibrary.simpleMessage("إدارة"),
        "managedAssignments": MessageLookupByLibrary.simpleMessage("إدارة"),
        "managedTeams": MessageLookupByLibrary.simpleMessage("فرق تحت إدارتك"),
        "markAsFinalData": MessageLookupByLibrary.simpleMessage(
            "حقول مكتملة، هل تبريد تعيين هذه البيانات كنهائية وجاهزة للإرسال؟"),
        "maximumAllowedLengthIsError": m4,
        "merged": MessageLookupByLibrary.simpleMessage("مدمج"),
        "middleName": MessageLookupByLibrary.simpleMessage("الاسم الأوسط"),
        "mobile": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
        "month": m5,
        "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
        "months": MessageLookupByLibrary.simpleMessage("أشهر"),
        "networkConnectionFailed": MessageLookupByLibrary.simpleMessage(
            "فشل في الاتصال بالشبكة. يرجى التحقق من الاتصال والمحاولة مرة أخرى."),
        "networkTimeout": MessageLookupByLibrary.simpleMessage(
            "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى."),
        "newItem": MessageLookupByLibrary.simpleMessage("إضافة"),
        "nmcpYemen": MessageLookupByLibrary.simpleMessage(
            "البرنامج الوطني لمكافحة الملاريا"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "noAuthenticatedUser": MessageLookupByLibrary.simpleMessage(
            "بيانات الاعتماد المقدمة لا تطابق مستخدمًا سبق وأن سجل. لا يمكن تسجيل الدخول في وضع عدم الاتصال بالإنترنت."),
        "noAuthenticatedUserOffline": MessageLookupByLibrary.simpleMessage(
            "لم يتم توثيق المستخدم مسبقاً. لا يمكن تسجيل الدخول في وضع عدم الاتصال."),
        "noFormsAvailable": MessageLookupByLibrary.simpleMessage(
            "لا تتوفر استمارات لهذا النشاط"),
        "noInternetAccess": MessageLookupByLibrary.simpleMessage("غير متصل"),
        "noSubmissions": MessageLookupByLibrary.simpleMessage("لا توجد بيانات"),
        "noSyncYet": MessageLookupByLibrary.simpleMessage("لم يحدث بعد"),
        "notNow": MessageLookupByLibrary.simpleMessage("ليس الآن"),
        "not_started": MessageLookupByLibrary.simpleMessage("لم يبدأ"),
        "notifications": MessageLookupByLibrary.simpleMessage("تنبيهات"),
        "objectAccessClosed":
            MessageLookupByLibrary.simpleMessage("الوصول مغلق لهذا الكائن"),
        "objectAccessDenied":
            MessageLookupByLibrary.simpleMessage("الوصول مرفوض لهذا الكائن"),
        "ok": MessageLookupByLibrary.simpleMessage("موافق"),
        "online": MessageLookupByLibrary.simpleMessage("متصل"),
        "open": MessageLookupByLibrary.simpleMessage("فتح"),
        "openNewForm": MessageLookupByLibrary.simpleMessage("استمارة جديدة"),
        "openSettings": MessageLookupByLibrary.simpleMessage("فتح الإعدادات"),
        "orgUnitDialogTitle":
            MessageLookupByLibrary.simpleMessage("ابحث عن المكان"),
        "orgUnitHelpText":
            MessageLookupByLibrary.simpleMessage("اختر اسم المكان"),
        "orgUnitInputLabel":
            MessageLookupByLibrary.simpleMessage("اختر اسم المكان"),
        "organization":
            MessageLookupByLibrary.simpleMessage("الوحدة التنظيمية"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("تم رفض الإذن"),
        "personInformation":
            MessageLookupByLibrary.simpleMessage("معلومات الشخص"),
        "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
            "يرجى إدخال عنوان بريد إلكتروني صالح."),
        "population": MessageLookupByLibrary.simpleMessage("سكان"),
        "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
        "productionDate": MessageLookupByLibrary.simpleMessage("تاريخ الانتاج"),
        "reassigned":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين فريق آخر"),
        "reported": MessageLookupByLibrary.simpleMessage("مرسل"),
        "reportedResources":
            MessageLookupByLibrary.simpleMessage("موارد المرسلة"),
        "rescan": MessageLookupByLibrary.simpleMessage("إعادة مسح"),
        "rescheduled": MessageLookupByLibrary.simpleMessage("جدولة"),
        "reset": MessageLookupByLibrary.simpleMessage("تفريغ"),
        "resources": MessageLookupByLibrary.simpleMessage("الموارد"),
        "restoreItem": MessageLookupByLibrary.simpleMessage(
            "إلغاء الحذف واستعادة هذا العنصر"),
        "reviewFormData":
            MessageLookupByLibrary.simpleMessage("مراجعة الأخطاء"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "saveAndAddAnother": MessageLookupByLibrary.simpleMessage("إضافة"),
        "saveAndCheck": MessageLookupByLibrary.simpleMessage("حفظ وتحقق"),
        "saveAndClose": MessageLookupByLibrary.simpleMessage("حفظ"),
        "saveAndEditNext":
            MessageLookupByLibrary.simpleMessage("حفظ ثم التالي"),
        "scanBarcode": MessageLookupByLibrary.simpleMessage("قارئ باركود"),
        "scanYourCode": MessageLookupByLibrary.simpleMessage("مسح كود"),
        "scanningIsUnsupportedOnThisDevice":
            MessageLookupByLibrary.simpleMessage("الجهاز لا يدعم مسح الباركود"),
        "scope": MessageLookupByLibrary.simpleMessage("المسؤلية"),
        "search": MessageLookupByLibrary.simpleMessage("بحث..."),
        "searchOrgUnitsHelpText":
            MessageLookupByLibrary.simpleMessage("البحث عن مكان..."),
        "selectAColorExtractionImage":
            MessageLookupByLibrary.simpleMessage("حدد صورة لإستخلاص الألوان"),
        "selectASeedColor":
            MessageLookupByLibrary.simpleMessage("حدد لون الأساس"),
        "selectColorTheme": MessageLookupByLibrary.simpleMessage("ثيم الألوان"),
        "selectForm": MessageLookupByLibrary.simpleMessage("اختر استمارة"),
        "selectImageForColorExtraction":
            MessageLookupByLibrary.simpleMessage("حدد صورة لاستخلاص ثيم منها"),
        "selected": MessageLookupByLibrary.simpleMessage("عناصر محددة"),
        "send": MessageLookupByLibrary.simpleMessage("إرسال"),
        "serial": MessageLookupByLibrary.simpleMessage("التسلسلي"),
        "serverUrl": MessageLookupByLibrary.simpleMessage("رابط السيرفر"),
        "settings": MessageLookupByLibrary.simpleMessage("إعدادات"),
        "showPassword": MessageLookupByLibrary.simpleMessage("أظهر كلمة السر"),
        "startDate": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
        "startingSync": MessageLookupByLibrary.simpleMessage("بدء التحديث"),
        "status": MessageLookupByLibrary.simpleMessage("الحالة"),
        "submissionDataEntry": MessageLookupByLibrary.simpleMessage("بيانات"),
        "submissionInitialData":
            MessageLookupByLibrary.simpleMessage("الرئيسة"),
        "syncError": m6,
        "syncFormData":
            MessageLookupByLibrary.simpleMessage("مزامنة بيانات الاستمارة"),
        "syncInterval":
            MessageLookupByLibrary.simpleMessage("ظبط فترة التحديث التلقائي"),
        "syncNow": MessageLookupByLibrary.simpleMessage("التحديث الآن"),
        "syncSettings":
            MessageLookupByLibrary.simpleMessage("التحديث التلقائي"),
        "syncSubmissions": m7,
        "synced": MessageLookupByLibrary.simpleMessage("مزامنة"),
        "syncingConfiguration":
            MessageLookupByLibrary.simpleMessage("إعدادات المزامنة"),
        "syncingData": MessageLookupByLibrary.simpleMessage("مزامنة بيانات"),
        "syncingEvents":
            MessageLookupByLibrary.simpleMessage("مزامنة الإستمارات"),
        "team": MessageLookupByLibrary.simpleMessage("الفريق"),
        "teams": MessageLookupByLibrary.simpleMessage("الفرق"),
        "thisFieldIsRequired":
            MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب."),
        "to_post": MessageLookupByLibrary.simpleMessage("نهائية"),
        "to_update": MessageLookupByLibrary.simpleMessage("مسودة"),
        "toggleBetweenListAndCardView":
            MessageLookupByLibrary.simpleMessage("تغيير بين قائمة/جدول"),
        "toggleBrightness":
            MessageLookupByLibrary.simpleMessage("تبديل الإضاءة"),
        "toggleListTableView":
            MessageLookupByLibrary.simpleMessage("تحويل بين قائمة/جدول"),
        "undo": MessageLookupByLibrary.simpleMessage("تراجع"),
        "unknownError": m8,
        "unsavedChangesWarning":
            MessageLookupByLibrary.simpleMessage("تغييرات غير محفوظة"),
        "user": MessageLookupByLibrary.simpleMessage("مستخدم"),
        "userSettings":
            MessageLookupByLibrary.simpleMessage("إعدادات المستخدم"),
        "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "validationError": MessageLookupByLibrary.simpleMessage(
            "يرجى تصحيح الأخطاء في النموذج قبل المتابعة."),
        "valueMustBeGreaterThanOrEqualToError": m9,
        "valueMustBeLessThanOrEqualToError": m10,
        "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
        "viewAvailableForms": MessageLookupByLibrary.simpleMessage(
            "افتح لاستعرض الاستمارات المتاحة"),
        "viewDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
        "viewList": MessageLookupByLibrary.simpleMessage("عرض القائمة"),
        "weekly": MessageLookupByLibrary.simpleMessage("اسبوعي"),
        "year": m11,
        "years": MessageLookupByLibrary.simpleMessage("سنوات"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم")
      };
}
