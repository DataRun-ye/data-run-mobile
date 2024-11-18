import 'package:d2_remote/modules/datarun/form/shared/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_tree/form_node.dart';
import 'package:d2_remote/modules/datarun/form/shared/tree_node/tree_node.dart';

abstract class TreeTemplateVisitor<T> {
  T visitField(AbstractTreeNode inputNode);

  T visitSection(FieldTemplate group);

  T visitRepeatableSection(FieldTemplate table);
}

abstract class TreeNodeVisitor<T> {
  T visitField(InputNode inputNode);

  T visitSection(GroupNode group);

  T visitRepeatableSection(TableNode table);
}
