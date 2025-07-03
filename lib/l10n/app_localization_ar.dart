// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get networkTimeout => 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get networkConnectionFailed => 'فشل في الاتصال بالشبكة. يرجى التحقق من الاتصال والمحاولة مرة أخرى.';

  @override
  String get authInvalidCredentials => 'بيانات الدخول التي تم إدخالها غير صحيحة. يرجى التحقق والمحاولة مرة أخرى.';

  @override
  String get authSessionExpired => 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول للمتابعة.';

  @override
  String get noAuthenticatedUser => 'بيانات الاعتماد المقدمة لا تطابق مستخدمًا سبق وأن سجل. لا يمكن تسجيل الدخول في وضع عدم الاتصال بالإنترنت.';

  @override
  String get noAuthenticatedUserOffline => 'لم يتم توثيق المستخدم مسبقاً. لا يمكن تسجيل الدخول في وضع عدم الاتصال.';

  @override
  String get differentOfflineUser => 'جلسة عدم الاتصال الحالية موثقة لمستخدم مختلف.';

  @override
  String get accountDisabled => 'تم تعطيل هذا الحساب. يرجى الاتصال بالمسؤول للمساعدة.';

  @override
  String get databaseConnectionFailed => 'فشل في الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى أو الاتصال بالدعم.';

  @override
  String get databaseQueryFailed => 'حدث خطأ أثناء معالجة طلب قاعدة البيانات. يرجى المحاولة مرة أخرى.';

  @override
  String databaseInternalError(Object error) {
    return 'واجهت قاعدة البيانات خطأ: $error.';
  }

  @override
  String syncError(Object error) {
    return 'حدث خطأ أثناء مزامنة البيانات: $error. يرجى المحاولة مرة أخرى.';
  }

  @override
  String unexpected(Object error) {
    return 'حدث خطأ غير متوقع: $error. يرجى المحاولة مرة أخرى.';
  }

  @override
  String get validationError => 'يرجى تصحيح الأخطاء في النموذج قبل المتابعة.';

  @override
  String apiError(Object error) {
    return 'حدث خطأ أثناء التواصل API النظام: $error.';
  }

  @override
  String get appName => 'Datarun';

  @override
  String get showPassword => 'أظهر كلمة السر';

  @override
  String get hidePassword => 'اخفاء كلمة السر';

  @override
  String get syncingConfiguration => 'إعدادات المزامنة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get configurationReady => 'اكتملت تهيئة التطبيق';

  @override
  String get syncingData => 'مزامنة بيانات';

  @override
  String get syncingEvents => 'مزامنة الإستمارات';

  @override
  String get password => 'كلمة المرور';

  @override
  String get user => 'مستخدم';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get viewList => 'عرض القائمة';

  @override
  String get addNew => 'إضافة جديد';

  @override
  String form(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString استمارة متوفرة',
      two: 'تتوفر استمارتان',
      one: 'تتوفر 1 استمارة',
      zero: 'لا تتوفر استمارات لهذا النشاط',
    );
    return '$_temp0';
  }

  @override
  String get viewAvailableForms => 'افتح لاستعرض الاستمارات المتاحة';

  @override
  String get dashboard => 'الرئيسية';

  @override
  String get enterYourUsername => 'من فضلك أدخل اسم المستخدم';

  @override
  String get syncFormData => 'مزامنة بيانات الاستمارة';

  @override
  String get confirmSyncFormData => 'هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟';

  @override
  String get error => 'خطأ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get ok => 'موافق';

  @override
  String get finalData => 'بيانات نهائية';

  @override
  String get discard => 'تجاهل';

  @override
  String get open => 'فتح';

  @override
  String get openNewForm => 'استمارة جديدة';

  @override
  String get errorOpeningNewForm => 'حدث خطأ أثناء فتح الإستمارة';

  @override
  String get markAsFinalData => 'حقول مكتملة، هل تبريد تعيين هذه البيانات كنهائية وجاهزة للإرسال؟';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get send => 'إرسال';

  @override
  String get nmcpYemen => 'البرنامج الوطني لمكافحة الملاريا';

  @override
  String get objectAccessDenied => 'الوصول مرفوض لهذا الكائن';

  @override
  String get objectAccessClosed => 'الوصول مغلق لهذا الكائن';

  @override
  String get noFormsAvailable => 'لا تتوفر استمارات لهذا النشاط';

  @override
  String get months => 'أشهر';

  @override
  String get years => 'سنوات';

  @override
  String get and => 'و';

  @override
  String year(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString سنة',
      few: '$countString سنوات',
      two: 'سنتان',
      one: 'سنة',
      zero: '',
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
      other: '$countString شهر',
      few: '$countString أشهر',
      two: 'شهران',
      one: 'شهر',
      zero: ' ',
    );
    return '$_temp0';
  }

  @override
  String get version => 'الإصدار';

  @override
  String get clear => 'تصفية';

  @override
  String get accept => 'قبول';

  @override
  String get level => 'المستوى';

  @override
  String get orgUnitHelpText => 'اختر اسم المكان';

  @override
  String get orgUnitInputLabel => 'اختر اسم المكان';

  @override
  String get orgUnitDialogTitle => 'ابحث عن المكان';

  @override
  String get searchOrgUnitsHelpText => 'البحث عن مكان...';

  @override
  String get submissionInitialData => 'الرئيسة';

  @override
  String get submissionDataEntry => 'بيانات';

  @override
  String get notifications => 'تنبيهات';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get middleName => 'الاسم الأوسط';

  @override
  String get lastName => 'اللقب';

  @override
  String get home => 'الرئيسة';

  @override
  String get itemRemoved => 'تم الحذف';

  @override
  String get conformDeleteMsg => 'هل أنت متأكد أنك تريد إزالة هذا القسم؟';

  @override
  String get undo => 'تراجع';

  @override
  String get selected => 'عناصر محددة';

  @override
  String get thisFieldIsRequired => 'هذا الحقل مطلوب.';

  @override
  String get pleaseEnterAValidEmailAddress => 'يرجى إدخال عنوان بريد إلكتروني صالح.';

  @override
  String get enterAValidNumber => 'يرجى إدخال رقم صالح.';

  @override
  String valueMustBeGreaterThanOrEqualToError(Object error) {
    return 'يجب أن تكون القيمة أكبر من أو تساوي $error.';
  }

  @override
  String valueMustBeLessThanOrEqualToError(Object error) {
    return 'يجب أن تكون القيمة أقل من أو تساوي $error.';
  }

  @override
  String maximumAllowedLengthIsError(Object error) {
    return 'الحد الأقصى للطول المسموح به هو $error.';
  }

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get settings => 'إعدادات';

  @override
  String get fetchUpdates => 'مزامنة إعدادات';

  @override
  String get appearance => 'المظهر';

  @override
  String get userSettings => 'إعدادات المستخدم';

  @override
  String get toggleBrightness => 'تبديل الإضاءة';

  @override
  String get selectColorTheme => 'ثيم الألوان';

  @override
  String get selectImageForColorExtraction => 'حدد صورة لاستخلاص ثيم منها';

  @override
  String get selectASeedColor => 'حدد لون الأساس';

  @override
  String get selectAColorExtractionImage => 'حدد صورة لإستخلاص الألوان';

  @override
  String get organization => 'الوحدة التنظيمية';

  @override
  String get currentUsername => 'المستخدم الحالي';

  @override
  String get changePassword => 'تغيير كلمة السر';

  @override
  String get language => 'اللغة';

  @override
  String get logoutNote => 'تسجيل خروج المستخدم الحالي';

  @override
  String get formContainsSomeErrors => ' يوجد أخطاء في بعض الحقول';

  @override
  String get dismiss => 'حسنًا';

  @override
  String get fieldsWithErrorInfo => 'قم بالرجوع ومراجعة الإخطاء أو (ليس الآن) للحفظ والمراجعة في وقت لاحق! لن يتسنى لك تعيين الاستمارة كنهائية وإرسالها إلا بعد تصحيح الأخطاء: ';

  @override
  String get reviewFormData => 'مراجعة الأخطاء';

  @override
  String get checkFieldsLater => 'ليس الآن';

  @override
  String get makeFormFinalOrSaveBody => 'قم بتعيين الاستمار كنهائية حتى يتسنى لك إرسالها، أو اختر (ليس الآن) لحفظها كمسودة إلى وقت لاحق!';

  @override
  String get deleteConfirmationMessage => 'هل تريد بالتأكيد حذف هذا العنصر؟';

  @override
  String get formSummaryView => 'عرض خلاصة الاستمارة';

  @override
  String get edit => 'تعديل';

  @override
  String get noInternetAccess => 'غير متصل';

  @override
  String get online => 'متصل';

  @override
  String get empty => 'فارغ';

  @override
  String get saveAndCheck => 'حفظ وتحقق';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get fieldContainErrors => 'يحوي أخطاء';

  @override
  String get startingSync => 'بدء التحديث';

  @override
  String get serverUrl => 'رابط السيرفر';

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get personInformation => 'معلومات الشخص';

  @override
  String get loginUsername => 'حساب تسجيل الدخول';

  @override
  String get done => 'اكتمل';

  @override
  String get failed => 'فشل';

  @override
  String get lastConfigurationSyncTime => 'آخر تحديث';

  @override
  String get lastSyncStatus => 'حالة آخر تحديث';

  @override
  String get about => 'عنا';

  @override
  String get appInformation => 'معلومات التطبيق';

  @override
  String get developerInformation => 'معلومات المطور';

  @override
  String get developer => 'البرنامج الوطني لمكافحة الملاريا';

  @override
  String get developerInfoText => 'info@nmcpye.org';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get accountInformation => 'معلومات الحساب';

  @override
  String get mobile => 'رقم الموبايل';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get internetIsConnected => 'متصل بالإنترنت';

  @override
  String get noSyncYet => 'لم يحدث بعد';

  @override
  String get daily => 'يومي';

  @override
  String get everyTwoDays => 'كل يومين';

  @override
  String get weekly => 'اسبوعي';

  @override
  String get everyFifteenDays => 'كل 15 يوم';

  @override
  String get monthly => 'شهري';

  @override
  String get syncNow => 'التحديث الآن';

  @override
  String get syncInterval => 'ظبط فترة التحديث التلقائي';

  @override
  String get syncSettings => 'التحديث التلقائي';

  @override
  String get saveAndEditNext => 'حفظ ثم التالي';

  @override
  String get saveAndClose => 'حفظ';

  @override
  String get saveAndAddAnother => 'إضافة';

  @override
  String get newItem => 'إضافة';

  @override
  String get editItem => 'تعديل';

  @override
  String get unsavedChangesWarning => 'تغييرات غير محفوظة';

  @override
  String get closeWithoutSaving => 'إغلاق وحذف؟';

  @override
  String get scanYourCode => 'مسح كود';

  @override
  String get barcodeQrScan => 'Barcode/QR Code';

  @override
  String get acceptCode => 'معلومات الكود؟';

  @override
  String get scanBarcode => 'قارئ باركود';

  @override
  String get invalidScannedCode => 'باركود غير صالح!';

  @override
  String get rescan => 'إعادة مسح';

  @override
  String get gtin => 'الرقم التجاري';

  @override
  String get batch => 'رقم التشغيلة';

  @override
  String get serial => 'التسلسلي';

  @override
  String get count => 'الكمية';

  @override
  String get productionDate => 'تاريخ الانتاج';

  @override
  String get controllerNotReady => 'المتحكم غير جاهز.';

  @override
  String get permissionDenied => 'تم رفض الإذن';

  @override
  String get scanningIsUnsupportedOnThisDevice => 'الجهاز لا يدعم مسح الباركود';

  @override
  String get genericError => 'خطأ غير محدد';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get dueDate => 'تاريخ الاستحقاق';

  @override
  String get dueDay => 'يوم الاستحقاق';

  @override
  String get scope => 'المسؤلية';

  @override
  String get formsAssigned => 'إستمارات';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get resources => 'الموارد';

  @override
  String get team => 'الفريق';

  @override
  String get not_started => 'لم يبدأ';

  @override
  String get in_progress => 'قيد التنفيذ';

  @override
  String get cancelled => 'ملغى';

  @override
  String get completed => 'مكتمل';

  @override
  String get rescheduled => 'جدولة';

  @override
  String get merged => 'مدمج';

  @override
  String get reassigned => 'إعادة تعيين فريق آخر';

  @override
  String get assigned => 'مهام';

  @override
  String get managed => 'إدارة';

  @override
  String get entity => 'الكيان';

  @override
  String get forms => 'استمارات';

  @override
  String get assignmentDetail => 'تفاصيل المهمة';

  @override
  String get activity => 'النشاط';

  @override
  String get status => 'الحالة';

  @override
  String get allocatedResources => 'الموارد المخصصة';

  @override
  String get reportedResources => 'موارد المرسلة';

  @override
  String get errorOpeningForm => 'حدث خطأ أثناء فتح الاستمارة';

  @override
  String get noSubmissions => 'لا توجد بيانات';

  @override
  String get search => 'بحث...';

  @override
  String get day => 'اليوم';

  @override
  String get toggleListTableView => 'تحويل بين قائمة/جدول';

  @override
  String get clearFilters => 'إلغا التصفية';

  @override
  String get assignedTeam => 'فريقك';

  @override
  String get managedTeams => 'فرق تحت إدارتك';

  @override
  String get assignedAssignments => 'مهام';

  @override
  String get managedAssignments => 'إدارة';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String syncSubmissions(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'عدد $countString استمارة',
      two: 'عدد استمارتان',
      one: 'عدد 1 استمارة',
      zero: 'لا تتوفر استمارات نهائية',
    );
    return '$_temp0';
  }

  @override
  String get allSubmissions => 'كل المرسلات';

  @override
  String get createdDate => 'تاريخ الإنشاء';

  @override
  String get lastmodifiedDate => 'تاريخ آخر تعديل';

  @override
  String get population => 'سكان';

  @override
  String get households => 'منازل';

  @override
  String get itns => 'ناموسيات';

  @override
  String get selectForm => 'اختر استمارة';

  @override
  String get reported => 'مرسل';

  @override
  String get lastSync => 'وقت آخر مزامنة';

  @override
  String get to_post => 'نهائية';

  @override
  String get to_update => 'مسودة';

  @override
  String get synced => 'مزامنة';

  @override
  String get toggleBetweenListAndCardView => 'تغيير بين قائمة/جدول';

  @override
  String get filters => 'تصفية البيانات';

  @override
  String get reset => 'تفريغ';

  @override
  String get apply => 'تطبيق';

  @override
  String get teams => 'الفرق';

  @override
  String get clearAll => 'تفريق الكل';

  @override
  String copiedToClipboard(Object value) {
    return 'تم نسخ $value للحافظة';
  }

  @override
  String get changingStateMightResultClearingDependentsElements => 'قد يؤدي إلى تفريغ بيانات حقول تعتمد على الحالة!';

  @override
  String get restoreItem => 'استعادة العنصر';

  @override
  String get deleteRestore => 'حذف/استعادة';

  @override
  String get fieldIsMandatory => 'الحقل مطلوب';

  @override
  String get validationErrorMessage => 'خطأ تحقق';

  @override
  String get deleteItem => 'حذف العنصر';

  @override
  String get copyToClipboard => 'نسخ للحافظة';

  @override
  String get loading => 'تحميل ...';

  @override
  String get loadMore => 'Load More';

  @override
  String get noMoreItems => 'No more items.';

  @override
  String get assignmentList => 'Assignment List';

  @override
  String noActiveDatabaseFound(Object error) {
    return 'لم يتم العثور على قاعدة بيانات نشطة: $error.';
  }

  @override
  String sessionExpired(Object error) {
    return 'انتهت صلاحية الجلسة: $error.';
  }

  @override
  String badCertificate(Object error) {
    return 'شهادة غير صالحة: $error.';
  }

  @override
  String invalidData(Object error) {
    return 'بيانات غير صالحة: $error.';
  }

  @override
  String badHttpRequest(Object error) {
    return 'طلب HTTP غير صحيح: $error.';
  }

  @override
  String badRequestToEndPoint(Object error) {
    return 'طلب غير صحيح: $error.';
  }

  @override
  String endPointNotFound(Object error) {
    return 'لم يتم العثور على نقطة المورد: $error.';
  }

  @override
  String serverError(Object error) {
    return 'خطأ في الخادم: $error.';
  }

  @override
  String unauthorizedAccessToEndPoint(Object error) {
    return 'وصول غير مصرح به إلى نقطة المورد: $error.';
  }

  @override
  String forbidden(Object error) {
    return 'ممنوع: $error.';
  }

  @override
  String noUserDetailsFetchedFromServer(Object error) {
    return 'لم يتمكن من مزامنة معلومات المستخدم من السيرفر: $error.';
  }

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
}
