import 'package:flutter/material.dart';
import 'package:mass_pro/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

/// A list of `Chip`s that acts like radio buttons
class ReactiveChoiceChips<T> extends ReactiveFormField<T, T> {
  final List<ReactiveChipOption<T>> options;
  final double? elevation;
  final double? pressElevation;
  final Color? selectedColor;

  /// Color to be used for the chip's background indicating that it is disabled.
  ///
  /// The chip is disabled when [isEnabled] is false, or all three of
  /// [SelectableChipAttributes.onSelected], [TappableChipAttributes.onPressed],
  /// and [DeletableChipAttributes.onDelete] are null.
  ///
  /// It defaults to [Colors.black38].
  final Color? disabledColor;

  /// Color to be used for the unselected, enabled chip's background.
  ///
  /// The default is light grey.
  final Color? backgroundColor;

  /// Color of the chip's shadow when the elevation is greater than 0 and the
  /// chip is selected.
  ///
  /// The default is [Colors.black].
  final Color? selectedShadowColor;

  /// Color of the chip's shadow when the elevation is greater than 0.
  ///
  /// The default is [Colors.black].
  final Color? shadowColor;

  /// The [OutlinedBorder] to draw around the chip.
  ///
  /// Defaults to the shape in the ambient [ChipThemeData]. If the theme
  /// shape resolves to null, the default is [StadiumBorder].
  ///
  /// This shape is combined with [side] to create a shape decorated with an
  /// outline. If it is a [WidgetStateOutlinedBorder],
  /// [WidgetStateProperty.resolve] is used for the following
  /// [WidgetState]s:
  ///
  ///  * [WidgetState.disabled].
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.pressed].
  final OutlinedBorder? shape;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// The padding around the [label] widget.
  ///
  /// By default, this is 4 logical pixels at the beginning and the end of the
  /// label, and zero on top and bottom.
  final EdgeInsets? labelPadding;

  /// The style to be applied to the chip's label.
  ///
  /// If null, the value of the [ChipTheme]'s [ChipThemeData.labelStyle] is used.
  //
  /// This only has an effect on widgets that respect the [DefaultTextStyle],
  /// such as [Text].
  ///
  /// If [labelStyle.color] is a [MaterialStateProperty<Color>], [WidgetStateProperty.resolve]
  /// is used for the following [WidgetState]s:
  ///
  ///  * [WidgetState.disabled].
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.pressed].
  final TextStyle? labelStyle;

  /// The padding between the contents of the chip and the outside [shape].
  ///
  /// Defaults to 4 logical pixels on all sides.
  final EdgeInsets? padding;

  /// Defines how compact the chip's layout will be.
  ///
  /// Chips are unaffected by horizontal density changes.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [density] for all widgets
  ///    within a [Theme].
  final VisualDensity? visualDensity;

  // Wrap Settings
  /// The direction to use as the main axis when wrapping chips.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment runAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [Wrap] (e.g., because
  /// the wrap has a minimum size that is not filled), the additional free space
  /// will be allocated according to the [runAlignment].
  ///
  /// Defaults to 0.0.
  final double runSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [direction] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If the [direction] is [Axis.horizontal], this controls order in which the
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [alignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [textDirection] (or the ambient
  /// [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  final ShapeBorder avatarBorder;

  /// Creates a list of `Chip`s that acts like radio buttons
  ReactiveChoiceChips({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    required this.options,
    this.alignment = WrapAlignment.start,
    InputDecoration decoration = const InputDecoration(),
    this.avatarBorder = const CircleBorder(),
    this.backgroundColor,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.direction = Axis.horizontal,
    this.disabledColor,
    this.elevation,
    this.labelPadding,
    this.labelStyle,
    this.materialTapTargetSize,
    this.padding,
    this.pressElevation,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.selectedColor,
    this.selectedShadowColor,
    this.shadowColor,
    this.shape,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.visualDensity,
  }) : super(builder: (field) {
          final state = field;
          final effectiveDecoration = decoration
              .applyDefaults(Theme.of(state.context).inputDecorationTheme);

          return InputDecorator(
            decoration:
                effectiveDecoration.copyWith(errorText: state.errorText),
            child: Wrap(
              direction: direction,
              alignment: alignment,
              crossAxisAlignment: crossAxisAlignment,
              runAlignment: runAlignment,
              runSpacing: runSpacing,
              spacing: spacing,
              textDirection: textDirection,
              verticalDirection: verticalDirection,
              children: <Widget>[
                for (ReactiveChipOption<T> option in options)
                  ChoiceChip(
                    label: option,
                    shape: shape,
                    selected: field.value == option.value,
                    onSelected: state.control.enabled
                        ? (selected) {
                            final choice = selected ? option.value : null;
                            state.didChange(choice);
                          }
                        : null,
                    avatar: option.avatar,
                    selectedColor: selectedColor,
                    disabledColor: disabledColor,
                    backgroundColor: backgroundColor,
                    shadowColor: shadowColor,
                    selectedShadowColor: selectedShadowColor,
                    elevation: elevation,
                    pressElevation: pressElevation,
                    materialTapTargetSize: materialTapTargetSize,
                    labelStyle: labelStyle,
                    labelPadding: labelPadding,
                    padding: padding,
                    visualDensity: visualDensity,
                    avatarBorder: avatarBorder,
                  ),
              ],
            ),
          );
        });

  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}
