import 'package:datarunmobile/core/form/model/Ui_render_type.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/ui_event_type.dart';
import 'package:datarunmobile/core/form/ui/event/list_view_ui_events.data.dart';

abstract class UiEventFactory {
  ListViewUiEvents? generateEvent(String? value, UiEventType? uiEventType,
      UiRenderType? renderingType, FieldUiModel fieldUiModel);
}
