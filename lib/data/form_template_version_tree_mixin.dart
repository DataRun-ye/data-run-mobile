import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/tree/tree_element.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_template_model.dart';
import 'package:datarunmobile/data/form_template_service.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormTemplateRepository {
  FormTemplateRepository._(
      {required FormTemplateModel formTemplateModel, required this.optionMap})
      : _formTemplateModel = formTemplateModel;

  static Future<FormTemplateRepository> create(
      {required String versionUid}) async {
    // final formVersion = await DSdk.db.managers.formTemplateVersions
    //     .filter((f) => f.id(versionUid))
    //     .getSingle();
    // final formTemplate = await DSdk.db.managers.formTemplates
    //     .filter((f) => f.id(formVersion.template))
    //     .getSingle();
    final FormTemplateModel versionModel =
        await appLocator<FormTemplateService>()
            .getTemplateByVersionOrLatest(versionId: versionUid);
    final options =
        await appLocator<OptionSetService>().getOptionSets(versionModel);
    return FormTemplateRepository._(
        formTemplateModel: versionModel, optionMap: options);
  }

  // final FormTemplate _formTemplate;
  // final FormTemplateVersion _formTemplateVersion;
  final FormTemplateModel _formTemplateModel;
  final Map<String, List<DataOption>> optionMap;
  SectionTemplate? _root;
  final Map<String, Template> _rootsFlatCache = {};

  FormTemplateModel get template => _formTemplateModel;

  List<Template> get sections => template.sections.toList();

  List<Template> get repeatSections =>
      template.sections.where((s) => s.repeatable).toList();

  SectionTemplate get rootSection => _root != null
      ? _root!
      : SectionTemplate(
          id: template.id,
          path: '',
          children: List.unmodifiable(_buildTree(fieldsAndSections: [
            ...template.fields,
            ...template.sections,
          ])));

  /// Get ImmediateChildren of a specific path
  List<T> getChildrenOfType<T extends TreeElement>(String path) {
    final normalizedPath =
        path.endsWith('.') ? path.substring(0, path.length - 1) : path;

    return rootsFlatLookupMap()
        .values
        .where((node) =>
            node.path!.startsWith('$normalizedPath.') &&
            node.path!.split('.').length ==
                normalizedPath.split('.').length + 1)
        .whereType<T>()
        .toList();
  }

  Map<String, Template> rootsFlatLookupMap() {
    if (_rootsFlatCache.isEmpty) {
      _rootsFlatCache.addAll(Map.fromIterable([
        ...template.fields,
        ...template.sections,
      ], key: (template) => template.id, value: (template) => template));
      return Map.unmodifiable(_rootsFlatCache);
    }
    return Map.unmodifiable(_rootsFlatCache);
  }

  List<Template> _buildTree({required Iterable<Template> fieldsAndSections}) {
    // a lookup of all nodes by their id:
    final IMap<String, Template> lookup = IMap.fromIterable(fieldsAndSections,
        keyMapper: (template) => template.id,
        valueMapper: (template) => template);

    // Link children into parents:
    final List<Template> roots = [];
    lookup.forEach((id, node) {
      if (node.parent == null || !lookup.containsKey(node.parent)) {
        // no parent in our data ⇒ this is a root
        roots.add(node);
      } else {
        lookup[node.parent!]!.children.add(node);
      }
    });

    // 3) Optional: sort each node’s children by the `order` property:
    void sortRecursively(List<Template> list) {
      list.sort((a, b) => a.order.compareTo(b.order));
      for (var n in list) {
        if (n.children.isNotEmpty) sortRecursively(n.children);
      }
    }

    sortRecursively(roots);

    return roots;
  }
}
