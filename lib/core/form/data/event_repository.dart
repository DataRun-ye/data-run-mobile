import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/core/form/data/data_entry_base_repository.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EventRepository)
class EventRepository extends DataEntryBaseRepository {
  EventRepository(
    super.fieldFactory, {
   @factoryParam this.eventUid,
  });

  final String? eventUid;

  //
  // Future<Event?>? _event;
  // Future<List<ProgramStageSection>> _programStageSections =
  //     Future.value(<ProgramStageSection>[]);
  // Future<Map<String, ProgramStageSection>> _sectionMap = Future.value({});

  @override
  bool isEvent() {
    return true;
  }

  @override
  Future<List<FieldUiModel>> list() async {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> sectionUids() async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getFieldsForMultipleSections() async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getFieldsForSingleSection() async {
    throw UnimplementedError();
  }

  /// transform Section Entity to [FieldUiModelImpl] for the UI
  Future<FieldUiModel> _transform(
      /*ProgramStageDataElement programStageDataElement*/) async {
    throw UnimplementedError();
  }

  List<FieldUiModel> getSpecificDataEntryItems(String uid) {
    return [];
    // return when (uid) {
    // EVENT_REPORT_DATE_UID,
    // EVENT_ORG_UNIT_UID,
    // -> {
    // getEventDetails()
    // }
    //
    // else -> {
    // emptyList()
    // }
    // }
  }

  @override
  // TODO: implement disableCollapsableSections
  bool? get disableCollapsableSections => throw UnimplementedError();

  @override
  String? firstSectionToOpen() {
    // TODO: implement firstSectionToOpen
    throw UnimplementedError();
  }

  @override
  Pair<String, List<FormOption>> options(
      {required String optionSetUid,
      List<String> optionsToHide = const [],
      List<String> optionGroupsToHide = const [],
      List<String> optionGroupsToShow = const []}) {
    // TODO: implement options
    throw UnimplementedError();
  }
// SectionRenderingType? _getSectionRenderingType(
//     ProgramStageSection? programStageSection) {
//   return SectionRenderingType.valueOf(programStageSection?.renderType);
// }

// FeatureType? _getFeatureType(ValueType? valueType) {
//   if (valueType == ValueType.COORDINATE) {
//     return FeatureType.POINT;
//   }
//   return null;
// }

// ValueTypeDeviceRendering? _getValueTypeDeviceRendering(
//     ProgramStageDataElement programStageDataElement) {
//   // if (programStageDataElement.renderType != null) programStageDataElement.renderType()!!
//   //     .mobile() else null
//   return null;
// }
}
