// import 'package:datarunmobile/core/main_constants.dart';
// import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:injectable/injectable.dart';
//
// @injectable
// class AppTheme {
//   ThemeData buildTheme(
//       {required ColorSeed colorSeed,
//       required ThemeData base,
//       required TargetPlatform platform,
//       Brightness brightness = Brightness.light}) {
//     final cs = ColorScheme.fromSeed(
//         seedColor: colorSeed.color, brightness: brightness, contrastLevel: 0.5);
//
//     final bool isDark = brightness == Brightness.dark;
//
//     // For surfaces that use primary color in light themes and surface color in dark
//     final Color primarySurfaceColor = isDark ? cs.surface : cs.primary;
//     final Color onPrimarySurfaceColor = isDark ? cs.onSurface : cs.onPrimary;
//
//     final barBg = isDark ? cs.surface : cs.primary;
//     final barFg = isDark ? cs.onSurface : cs.onPrimary;
//
//     return base.copyWith(
//       colorScheme: cs,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       typography: Typography.material2021(platform: platform, colorScheme: cs),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: cs.primary,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           // textStyle: Typography.material2021().bodyMedium,
//         ),
//       ),
//       tabBarTheme: base.tabBarTheme.copyWith(
//         labelColor: barFg.withValues(alpha: 0.8),
//         unselectedLabelColor: barFg.withValues(alpha: 0.5),
//       ),
//       appBarTheme: base.appBarTheme.copyWith(
//         backgroundColor: barBg,
//         foregroundColor: barFg,
//         centerTitle: true,
//         iconTheme: IconThemeData(color: barFg),
//         actionsIconTheme: IconThemeData(color: barFg),
//         surfaceTintColor: barBg,
//         // M3 elevation tint :contentReference[oaicite:1]{index=1}
//         systemOverlayStyle:
//             isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
//       ),
//       cardTheme: CardThemeData(
//         color: cs.surfaceContainerLow,
//         surfaceTintColor: cs.surfaceTint,
//         elevation: 4,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         // alignLabelWithHint: true,
//         fillColor: isDark ? cs.surfaceContainerHighest : cs.surface,
//         errorStyle: TextStyle(
//             color: SurfaceColors.Error,
//             backgroundColor: SurfaceColors.ErrorContainerHighest),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: SurfaceColors.Error, width: 2),
//         ),
//         hintStyle: TextStyle(
//             color: cs.onSurfaceVariant.withValues(alpha: 0.8), fontSize: 13),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: cs.outlineVariant, width: 0.5),
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: cs.primary, width: 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: cs.primary, width: 1),
//         ),
//         prefixIconColor: cs.onSurfaceVariant,
//         floatingLabelStyle: TextStyle(color: cs.primary),
//       ),
//
//       //
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: cs.primary,
//           foregroundColor: cs.onPrimary,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//           // textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//
//       // textButtonTheme: TextButtonThemeData(
//       //   style: TextButton.styleFrom(
//       //     foregroundColor: cs.primary,
//       //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       //     textStyle: Typography.material2021().bodyMedium,
//       //   ),
//       // ),
//
//       dividerTheme: DividerThemeData(
//         color: cs.primary,
//         thickness: 0.3,
//         // space: 3,
//         indent: 16,
//         endIndent: 16,
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: cs.primary,
//           side: BorderSide(color: cs.outline),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//         ),
//       ),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: cs.secondary,
//         foregroundColor: cs.onSecondary,
//         elevation: 4,
//       ),
//       // bottomSheetTheme: base.bottomSheetTheme.copyWith(
//       //   elevation: 2,
//       //   surfaceTintColor: cs.surfaceTint,
//       //   // backgroundColor: cs.surfaceContainer,
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.circular(16),
//       //   ),
//       // ),
//
//       actionIconTheme: ActionIconThemeData(
//         // backButtonIconBuilder: (BuildContext context) {
//         //   return const Icon(Icons.arrow_back_ios_new_rounded);
//         // },
//         drawerButtonIconBuilder: (BuildContext context) {
//           return const _CustomDrawerIcon();
//         },
//         endDrawerButtonIconBuilder: (BuildContext context) {
//           return const _CustomEndDrawerIcon();
//         },
//       ),
//       dataTableTheme: DataTableThemeData(
//         headingRowColor:
//             WidgetStateProperty.all(cs.primary.withValues(alpha: 0.08)),
//         headingTextStyle: base.textTheme.titleSmall!.copyWith(
//           color: cs.onSurface,
//           fontWeight: FontWeight.w600,
//         ),
//         dataTextStyle: base.textTheme.bodyMedium!.copyWith(
//           color: cs.onSurface,
//         ),
//         dividerThickness: 0.3,
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: cs.outline),
//             bottom: BorderSide(color: cs.outline),
//           ),
//         ),
//       ),
//       radioTheme: RadioThemeData(
//         fillColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.selected)) return cs.primary;
//           return cs.outline;
//         }),
//       ),
//       textTheme: _buildShrineTextTheme(base.textTheme),
//       // 1️⃣ Global ChipTheme (applies to basic Chip/ActionChip/InputChip)
//       chipTheme: base.chipTheme.copyWith(
//         // backgroundColor:  cs.surfaceContainerLow,
//         // brightness: brightness,
//         // selectedColor: DColors.Orange500,
//         secondarySelectedColor: cs.primaryFixedDim, // label color when selected
//         // secondaryLabelStyle: base.textTheme.bodyMedium!.copyWith(
//         //   fontSize: 14,
//         // ),
//         // checkmarkColor: isDark ? cs.onPrimary : cs.onSurface,
//         // elevation: 1,
//         // labelStyle: base.textTheme.bodyMedium!.copyWith(
//         //   color: isDark ? cs.onSurface : cs.onPrimary,
//         // ),
//         // disabledColor: cs.onSurface.withValues(alpha:0.12),
//         // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: cs.outline),
//         ),
//         // labelPadding: const EdgeInsets.symmetric(horizontal: 8),
//       ),
//       // focusColor: cs.primarywithValues(alpha:0.12),
//       // hoverColor: cs.primarywithValues(alpha:0.06),
//       splashColor: cs.primary.withValues(alpha: 0.08),
//       // highlightColor: cs.primary.withValues(alpha:0.1),
//       //
//       // 2️⃣ FilterChip (for “multi‑select” filters)
//       // filterChipTheme: FilterChipThemeData(
//       //   selectedColor: cs.primary.withValues(alpha:0.16),
//       //   checkmarkColor: cs.primary,
//       //   backgroundColor: cs.surfaceVariant,
//       //   disabledColor: cs.onSurface.withValues(alpha:0.12),
//       //   labelStyle: base.textTheme.bodyMedium!,
//       //   secondaryLabelStyle:
//       //       base.textTheme.bodyMedium!.copyWith(color: cs.onPrimary),
//       //   side: BorderSide(color: cs.outline),
//       //   selectedShadowColor: cs.primary.withValues(alpha:0.24),
//       //   elevation: 0,
//       //   pressElevation: 2,
//       //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.circular(8),
//       //   ),
//       // ),
//     );
//   }
//
//   TextTheme _buildShrineTextTheme(TextTheme base) {
//     return base.apply(
//       fontFamily: 'Rubik', //'Raleway',
//     );
//   }
// }
//
// class _CustomEndDrawerIcon extends StatelessWidget {
//   const _CustomEndDrawerIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     final MaterialLocalizations localization =
//         MaterialLocalizations.of(context);
//     return Icon(
//       Icons.more_horiz,
//       semanticLabel: localization.openAppDrawerTooltip,
//     );
//   }
// }
//
// class _CustomDrawerIcon extends StatelessWidget {
//   const _CustomDrawerIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     final MaterialLocalizations localization =
//         MaterialLocalizations.of(context);
//     return Icon(
//       Icons.segment,
//       semanticLabel: localization.openAppDrawerTooltip,
//     );
//   }
// }
