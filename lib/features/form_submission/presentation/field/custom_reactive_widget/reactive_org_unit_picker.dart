import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/org_unit_display.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:datarunmobile/selectable_org_unit/helper/empty_page.dart';
import 'package:datarunmobile/selectable_org_unit/helper/error_page.dart';
import 'package:datarunmobile/selectable_org_unit/model/build_tree.dart';
import 'package:datarunmobile/selectable_org_unit/model/org_unit_node.dart';
import 'package:datarunmobile/selectable_org_unit/vts/show_org_unit_selection_sheet.dart';
import 'package:datarunmobile/selectable_org_unit/widgets/dash_line.dart';
import 'package:datarunmobile/selectable_org_unit/widgets/default_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:recursive_tree_flutter/functions/tree_traversal_functions.dart';
import 'package:recursive_tree_flutter/models/tree_type.dart';

class ReactiveOrgUnitPicker extends ReactiveFormField<String, String> {
  ReactiveOrgUnitPicker({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    String? initialData,
    TextDirection? textDirection,
    bool singleChoice = true,
    List<String> leafIds = const [],
    TextStyle? style,
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // common params
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    String? cancelText,
    String? confirmText,
    String? helpText,
    // input decorator props
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    bool canRequestFocus = true,
    double disabledOpacity = 0.5,
    ReactiveFormFieldCallback<String>? onChanged,
    MouseCursor cursor = SystemMouseCursors.click,
    Widget Function(BuildContext context, String? value)? valueBuilder,
    Future<String?> Function(
      BuildContext context,
      String? value,
    )? onTap,
  }) : super(
          builder: (ReactiveFormFieldState<String, String> field) {
            Widget? suffixIcon = decoration?.suffixIcon;
            final isEmptyValue = field.value.isNotNullOrEmpty;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            final errorText = field.errorText;

            return HoverBuilder(builder: (context, isHovered) {
              return IgnorePointer(
                ignoring: !field.control.enabled,
                child: MouseRegion(
                  cursor: cursor,
                  child: GestureDetector(
                    onTap: () async {
                      List<OrgUnitNode>? chosenNodes;
                      field.control.focus();
                      field.control.updateValueAndValidity();
                      final fValue = field.control.value;
                      showOrgUnitSelectionSheet<OrgUnitNode>(
                        context: context,
                        sheetTitle: 'BRUH BRUH LMAO LMAO',
                        singleChoice: singleChoice,
                        selectedIds:
                            initialData != null ? initialData.split(',') : [],
                        sheetTitleStyle: kDefaultSheetTitleStyle,
                        titleLeadingWidget: const DefaultLeadingWidget(),
                        titleTrailingWidget: const DefaultTrailingWidget('Add'),
                        loadingWidget: const DefaultLoadingWidget(),
                        emptyPage: const EmptyPage(),
                        errorPage: const ErrorPage(),
                        handleBar: const DefaultHandleBar(),
                        funcParseDataToTree: buildOrgUnitTree(leafIds),
                        funcWhenComplete: (TreeType<OrgUnitNode> tree) {
                          List<TreeType<OrgUnitNode>> result = [];
                          returnChosenLeaves(tree, result);

                          if (result.isEmpty) field.didChange(null);

                          field.didChange(result
                              .map((node) => node.data.id as String)
                              .toList()
                              .join(','));
                          field.control.unfocus();
                          field.control.updateValueAndValidity();
                          field.control.markAsTouched();
                        },
                        buildLeadingWidgetNode:
                            (tree, VoidCallback setStateCallback) {
                          if (tree.isRoot) {
                            return _buildLeadingRoot(field.context, tree);
                          } else if (tree.isLeaf) {
                            return _buildLeadingLeafWithFavoriteIcon(
                                field.context, tree, setStateCallback);
                          } else {
                            return _buildLeadingInnerNode(field.context, tree);
                          }
                        },
                        //   // cancelText: cancelText,
                        //   // confirmText: confirmText,
                        //   // textDirection: textDirection,
                        //   // fieldHintText: fieldHintText,
                        //   // fieldLabelText: fieldLabelText,
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: InputDecorator(
                      isHovering: isHovered,
                      isFocused: field.control.hasFocus,
                      isEmpty: isEmptyValue,
                      baseStyle: baseStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      expands: expands,
                      decoration: effectiveDecoration.copyWith(
                        enabled: field.control.enabled,
                        errorText: field.errorText,
                      ),
                      child: DefaultTextStyle.merge(
                        style: Theme.of(field.context)
                            .textTheme
                            .titleMedium
                            ?.merge(style)
                            .copyWith(
                              color: !field.control.enabled
                                  ? Theme.of(field.context).disabledColor
                                  : null,
                            ),
                        child: valueBuilder?.call(field.context, field.value) ??
                            (field.value != null
                                ? OrgUnitDisplay(id: field.value)
                                : Text(
                                    // textAlign: TextAlign.center,
                                    field.value ?? '',
                                    textDirection: textDirection,
                                    style: Theme.of(field.context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.copyWith(),
                                  )),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        );

  static Widget _buildLeadingWidgetNode(
      ReactiveFormFieldState<String, String> field,
      TreeType<OrgUnitNode> tree,
      VoidCallback setStateCallback) {
    if (tree.isRoot) {
      return _buildLeadingRoot(field.context, tree);
    } else if (tree.isLeaf) {
      return _buildLeadingLeafWithFavoriteIcon(
          field.context, tree, setStateCallback);
    } else {
      return _buildLeadingInnerNode(field.context, tree);
    }
  }

  static Widget _buildLeadingRoot(
      BuildContext context, TreeType<OrgUnitNode> tree) {
    return Row(
      children: [
        const SizedBox(width: 20),
        tree.data.isExpanded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedRotation(
                    turns: tree.data.isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    child:
                        SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
                  ),
                  CustomPaint(
                    painter: BottomDashedLinePainterWhenClicked(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                  ),
                ],
              )
            : AnimatedRotation(
                turns: tree.data.isExpanded ? 0.25 : 0,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
              ),
        const SizedBox(width: 8),
      ],
    );
  }

  static Widget _buildLeadingInnerNode(
      BuildContext context, TreeType<OrgUnitNode> tree) {
    if (tree.data.isExpanded) {
      return SizedBox(
        width: 40,
        height: 50,
        child: Row(
          children: [
            CustomPaint(
              painter: TopDashedLinePainterWhenClicked(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedRotation(
                  turns: tree.data.isExpanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
                ),
                CustomPaint(
                  painter: BottomDashedLinePainterWhenClicked(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 30,
        height: 50,
        child: Row(
          children: [
            CustomPaint(
              painter: tree.data.toString() ==
                      findRightmostOfABranch(tree).data.toString()
                  ? TopDashedLinePainterWhenClicked()
                  : DashedLinePainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            AnimatedRotation(
              turns: tree.data.isExpanded ? 0.25 : 0,
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
            ),
          ],
        ),
      );
    }
  }

  static Widget _buildLeadingLeafWithFavoriteIcon(BuildContext context,
      TreeType<OrgUnitNode> tree, VoidCallback setStateCallback) {
    return SizedBox(
      height: 70.0,
      width: 35.0,
      child: Row(
        children: [
          CustomPaint(
            painter: tree.data.toString() ==
                    findRightmostOfABranch(tree).data.toString()
                ? TopDashedLinePainterWhenClicked()
                : DashedLinePainter(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ),
          SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
        ],
      ),
    );
  }

  // final List<ReactiveChipOption<T>> options;
  //
  @override
  ReactiveFormFieldState<String, String> createState() =>
      ReactiveFormFieldState<String, String>();
}
