import '../../model/Ui_render_type.dart';
import '../../model/field_ui_model.dart';
import '../../model/ui_event_type.dart';
import 'list_view_ui_events.data.dart';

abstract class UiEventFactory {
  ListViewUiEvents? generateEvent(String? value, UiEventType? uiEventType,
      UiRenderType? renderingType, FieldUiModel fieldUiModel);
}
