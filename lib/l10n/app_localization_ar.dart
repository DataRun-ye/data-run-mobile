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
  String get networkConnectionFailed =>
      'فشل في الاتصال بالشبكة. يرجى التحقق من الاتصال والمحاولة مرة أخرى.';

  @override
  String get authInvalidCredentials =>
      'بيانات الدخول التي تم إدخالها غير صحيحة. يرجى التحقق والمحاولة مرة أخرى.';

  @override
  String get authSessionExpired =>
      'انتهت صلاحية الجلسة. يرجى تسجيل الدخول للمتابعة.';

  @override
  String get noAuthenticatedUser =>
      'بيانات الاعتماد المقدمة لا تطابق مستخدمًا سبق وأن سجل. لا يمكن تسجيل الدخول في وضع عدم الاتصال بالإنترنت.';

  @override
  String get noAuthenticatedUserOffline =>
      'لم يتم توثيق المستخدم مسبقاً. لا يمكن تسجيل الدخول في وضع عدم الاتصال.';

  @override
  String get differentOfflineUser =>
      'جلسة عدم الاتصال الحالية موثقة لمستخدم مختلف.';

  @override
  String get accountDisabled =>
      'تم تعطيل هذا الحساب. يرجى الاتصال بالمسؤول للمساعدة.';

  @override
  String get databaseConnectionFailed =>
      'فشل في الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى أو الاتصال بالدعم.';

  @override
  String get databaseQueryFailed =>
      'حدث خطأ أثناء معالجة طلب قاعدة البيانات. يرجى المحاولة مرة أخرى.';

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
  String get addNew => 'جديد';

  @override
  String form(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تتوفر $countString استمارات',
      two: 'تتوفر استمارتان',
      one: 'تتوفر استمارة واحدة',
      zero: 'لا تتوفر استمارات لهذا العنصر',
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
  String get confirmSyncFormData =>
      'هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟';

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
  String get markAsFinalData =>
      'حقول مكتملة، هل تبريد تعيين هذه البيانات كنهائية وجاهزة للإرسال؟';

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
  String get pleaseEnterAValidEmailAddress =>
      'يرجى إدخال عنوان بريد إلكتروني صالح.';

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
  String get fieldsWithErrorInfo =>
      'قم بالرجوع ومراجعة الإخطاء أو (ليس الآن) للحفظ والمراجعة في وقت لاحق! لن يتسنى لك تعيين الاستمارة كنهائية وإرسالها إلا بعد تصحيح الأخطاء: ';

  @override
  String get reviewFormData => 'مراجعة الأخطاء';

  @override
  String get checkFieldsLater => 'ليس الآن';

  @override
  String get makeFormFinalOrSaveBody =>
      'قم بتعيين الاستمار كنهائية حتى يتسنى لك إرسالها، أو اختر (ليس الآن) لحفظها كمسودة إلى وقت لاحق!';

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
  String get lastConfigurationSyncTime => 'آخر مزامنة';

  @override
  String get lastSyncStatus => 'حالة آخر عملية مزامنة';

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
  String get viewDetails => 'تفاصيل';

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
      other: '$countString استمارات للمزامنة',
      two: 'استمارتان للمزامنة',
      one: 'استمارة 1 للمزامنة',
      zero: 'لا تتوفر استمارات نهائية للمزامنة',
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
      other: '$countString حذف المحدد',
      two: '2 حذف عنصرين',
      one: '1 حذف',
      zero: 'No Elements selected',
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
  String get confirmationWarning =>
      'قد يؤدي تغيير الخيار إلى تفريغ أي بيانات تعتمد على إجابة هذا السؤال، تأكيد؟';

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
  String get loadMore => 'تحميل المزيد';

  @override
  String get noMoreItems => 'لا توجد عناصر أخرى.';

  @override
  String get assignmentList => 'قائمة المهام';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get yearsMonths => 'أشهر/سنوات';

  @override
  String get days => 'أيام';

  @override
  String get textHint => 'أدخل نصًا';

  @override
  String get longTextHint => 'أدخل نصًا لا يتجاوز 500 حرف';

  @override
  String get oneLetterFieldHint => 'أدخل حرفًا واحدًا';

  @override
  String get numberFieldHint => 'أدخل رقمًا';

  @override
  String get unitIntervalFieldHint => 'أدخل قيمة بين 0 و1';

  @override
  String get percentageFieldHint => 'أدخل نسبة مئوية';

  @override
  String get integerFieldHint => 'أدخل عددًا صحيحًا';

  @override
  String get positiveIntegerFieldHint => 'أدخل عددًا صحيحًا موجبًا';

  @override
  String get negativeIntegerFieldHint => 'أدخل عددًا صحيحًا سالبًا';

  @override
  String get integerOrZeroFieldHint => 'أدخل عددًا صحيحًا أو صفرًا';

  @override
  String get phoneNumberFieldHint => 'أدخل رقم هاتف';

  @override
  String get emailFieldHint => 'أدخل بريدًا إلكترونيًا';

  @override
  String get urlFieldHint => 'أدخل رابط URL';

  @override
  String get fileResourceFieldHint => 'اختر ملفًا';

  @override
  String get usernameFieldHint => 'أدخل اسم مستخدم';

  @override
  String get ageFieldHint => 'أدخل العمر';

  @override
  String get booleanFieldHint => 'أدخل قيمة منطقية';

  @override
  String get trueOnlyFieldHint => 'قيمة صحيحة فقط';

  @override
  String get orgunitFieldHint => 'اختر وحدة تنظيمية';

  @override
  String get dataFieldHint => 'اختر تاريخًا';

  @override
  String get dataTimeFieldHint => 'أدخل تاريخًا ووقتًا';

  @override
  String get referenceFieldHint => 'اختر مرجعًا';

  @override
  String get timeFieldHint => 'اختر وقتًا';

  @override
  String get teamFieldHint => 'اختر فريقًا';

  @override
  String get fullNameFieldHint => 'أدخل الاسم الكامل';

  @override
  String get selectMultiFieldHint => 'اختر خيارات متعددة';

  @override
  String get selectOneFieldHint => 'اختر خيارًا واحدًا';

  @override
  String get yesOrNoFieldHint => 'اختر نعم أو لا';

  @override
  String get scanCodeFieldHint => 'امسح الرمز';

  @override
  String get coordinatesFieldHint => 'اختر إحداثيات';

  @override
  String get imageFieldHint => 'اختر صورة';

  @override
  String get progressFieldHint => 'أدخل تقدمًا';

  @override
  String get unknownValueType => 'نوع غير معروف للقيمة';

  @override
  String get unsupportedValueType => 'نوع غير مدعوم للقيمة';

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
    return 'شهادة غير صالحة: $error';
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
  String get noActivitiesYet => 'لا توجد أنشطة حتى الآن';

  @override
  String get materialVersion => 'Material Version';

  @override
  String get syncSummaryLoadError => 'خطأ في تحميل ملخص المزامنة';

  @override
  String get noSyncsYet => 'لم تتم أي مزامنة بعد';

  @override
  String get performFirstSync => 'قم بالمزامنة الأولى';

  @override
  String get successCount => 'عدد النجاحات';

  @override
  String get failureCount => 'عدد الإخفاقات';

  @override
  String get close => 'إغلاق';

  @override
  String get copyAll => 'نسخ الكل';

  @override
  String get errorSummary => 'ملخص الأخطاء';

  @override
  String get syncErrors => 'أخطاء المزامنة';

  @override
  String get viewErrors => 'عرض الأخطاء';

  @override
  String get syncSummaryTitle => 'ملخص المزامنة';

  @override
  String get projects => 'المشاريع';

  @override
  String get activities => 'الأنشطة';

  @override
  String get formTemplates => 'النماذج';

  @override
  String get dataSubmissions => 'بيانات مرسلة';

  @override
  String get dataSubmission => 'بيانات مرسلة';

  @override
  String get assignments => 'المهام';

  @override
  String get optionSets => 'مجموعات الاختيار';

  @override
  String get options => 'خيارات';

  @override
  String get dataElements => 'عناصر البيانات';

  @override
  String get orgUnits => 'وحدات تنظيمية';

  @override
  String get downloaded => 'حفظ';

  @override
  String get currentOperations => 'العملية الحالية:';

  @override
  String get showLess => 'عرض أقل';

  @override
  String get showMore => 'عرض المزيد';

  @override
  String get syncProgressDashboard => 'مزامنة إعدادات المستخدم';

  @override
  String get checkingSession => 'ضبط جلسة المستخدم...';

  @override
  String get datarun => 'DATARUN';

  @override
  String get signingOutWarning =>
      'سيؤدي تسجيل الخروج إلى فقدان أي تغييرات لم يتم مزامنتها. هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get logOutAnyway => 'نأكيد تسجيل الخروج';

  @override
  String get logOut => 'تسجيل الخروج؟';

  @override
  String systemFilesAccessError(Object error) {
    return 'خطأ عند محاولة الوصول لملفات التخزين: $error';
  }

  @override
  String connectionTimeout(Object error) {
    return 'الإتصال بالسيرفر يستغرق وقتًا طويلًا، ابحث عن انترنت جيد وحاول مجدداً: $error';
  }

  @override
  String sendTimeout(Object error) {
    return 'الإتصال بالسيرفر يستغرق وقتًا طويلًا، حاول مرة أخرى: $error';
  }

  @override
  String receiveTimeout(Object error) {
    return 'الإتصال بالسيرفر يستغرق وقتًا طويلًا، حاول مرة أخرى: $error';
  }

  @override
  String badResponse(Object error) {
    return 'bad response: $error';
  }

  @override
  String connectionError(Object error) {
    return 'لم يتمكن من الإتصال بالسيرفر: $error';
  }

  @override
  String get requestCancelled => 'تم إلغاء الطلب';

  @override
  String get actionNeedsConfirmation => 'تأكيد الطلب';

  @override
  String get noConnection => 'لا يتوفر إنترنت';

  @override
  String get noConnectionMessage =>
      'يرجى التأكد من اتصال بالإنترنت والمحاولة مرة أخرى';

  @override
  String get generalErrorMessage =>
      'The application has encountered an unknown error, Please try again later.';

  @override
  String get generalErrorTitle => 'حدث خطأ ما';

  @override
  String get ouLevels => 'مستويات إدارية';

  @override
  String submissionError(Object error) {
    return 'حدث خطأ أثناء محاولة الإرسال، حاول مرة أخرى:\n $error';
  }

  @override
  String get errorSubmittingForm => 'خطأ وقت الإرسال';

  @override
  String get draft => 'مسودة';

  @override
  String get finalized => 'نهائية';

  @override
  String get syncFailed => 'فشل مزامنة';

  @override
  String get cancelSyncing => 'إيقاف والمزامنة لاحقًا';

  @override
  String get formPermissions => 'صلاحيات وصول';

  @override
  String get warning => 'تنبيه';

  @override
  String get selectMonth => 'اختر الشهر';

  @override
  String get selectWeek => 'اختر الإسبوع';

  @override
  String get selectYear => 'اختر السنة';

  @override
  String week(Object weekNum) {
    return 'الإسبوع $weekNum';
  }

  @override
  String ofYear(Object year) {
    return 'من عام $year';
  }

  @override
  String get created => 'الإنشاء';

  @override
  String get modified => 'التعديل';

  @override
  String get demoLogin => 'Demo Login';

  @override
  String get draftDataInstance => 'تسويد نسخة';

  @override
  String get initializingDataInstance => 'تهيئة النسخة';

  @override
  String get all => 'الكل';

  @override
  String get addAnItem => 'إضافة عنصر';

  @override
  String get dateRange => 'الوقت';

  @override
  String get includeDeleted => 'تضمين المحذوف';

  @override
  String get applyFilters => 'تطبيق';

  @override
  String get today => 'اليوم';

  @override
  String get lastThreeDays => 'آخر 3 أيام';

  @override
  String get thisWeek => 'هذا الإسبوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get lastThreeMonths => 'آخر 3 أشهر';

  @override
  String get thisYear => 'هذه السنة';

  @override
  String get allDates => 'كل الأوقات';

  @override
  String get editView => 'تعديل/عرض';

  @override
  String get view => 'استعراض';

  @override
  String get userSavedInstances => 'مدخلات المستخدم';

  @override
  String get openSpeedDial => 'فتح الوصول السريع';

  @override
  String get noItemsFound => 'لا يوجد أي عنصر';

  @override
  String confirmDeleteItemsSelected(Object count) {
    return 'سيتم حذف $count عنصر، هل أنت متأكد؟';
  }

  @override
  String get fixedTableColumns => 'تثبيت أعمدة التفاعل';

  @override
  String get tableAppearance => 'مظهر الجدول';

  @override
  String get tableControl => 'إعدادات جدول';

  @override
  String get compactTable => 'جدول مضموم';

  @override
  String get hideSyncedRows => 'إخفاء دائم للمزامن';
}
