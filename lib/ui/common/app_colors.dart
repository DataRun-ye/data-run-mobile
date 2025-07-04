import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

class DColors {
  static const Color Blue50 = Color(0xFFF1F9FF);
  static const Color Blue100 = Color(0xFFE2F2FF);
  static const Color Blue150 = Color(0xFFCFEAFF);
  static const Color Blue200 = Color(0xFFBADFFF);
  static const Color Blue300 = Color(0xFF57B0FB);
  static const Color Blue400 = Color(0xFF1287EE);
  static const Color Blue500 = Color(0xFF007DEB);
  static const Color Blue600 = Color(0xFF096DD9);
  static const Color Blue700 = Color(0xFF1260BA);
  static const Color Blue800 = Color(0xFF0C3966);
  static const Color Blue900 = Color(0xFF0A2E52);
  static const Color Red50 = Color(0xFFFEF7F6);
  static const Color Red100 = Color(0xFFFFF1F0);
  static const Color Red200 = Color(0xFFFFE3E2);
  static const Color Red300 = Color(0xFFFFA2A2);
  static const Color Red400 = Color(0xFFF45B55);
  static const Color Red500 = Color(0xFFE52F28);
  static const Color Red600 = Color(0xFFD21B14);
  static const Color Red700 = Color(0xFFBA1F19);
  static const Color Red800 = Color(0xFF9D1F1A);
  static const Color Red900 = Color(0xFF731814);
  static const Color Charcoal200 = Color(0xFF93A1B0);
  static const Color Charcoal300 = Color(0xFF667685);
  static const Color Charcoal400 = Color(0xFF556575);
  static const Color Charcoal500 = Color(0xFF405261);
  static const Color Charcoal600 = Color(0xFF314351);
  static const Color Charcoal700 = Color(0xFF253642);
  static const Color Charcoal800 = Color(0xFF1D2B36);
  static const Color Charcoal800A32 = Color(0x521D2B36);
  static const Color Charcoal800A40 = Color(0x661D2B36);
  static const Color Ash200 = Color(0xFFF9FAFA);
  static const Color Ash300 = Color(0xFFF1F3F5);
  static const Color Ash400 = Color(0xFFE5E9EC);
  static const Color Ash500 = Color(0xFFD5DCE1);
  static const Color Ash600 = Color(0xFFC5CED6);
  static const Color Ash700 = Color(0xFFB7C2CC);
  static const Color Ash800 = Color(0xFFA5B2BD);
  static const Color Orange50 = Color(0xFFFFF3E0);
  static const Color Orange100 = Color(0xFFFFE0B2);
  static const Color Orange200 = Color(0xFFFFCC80);
  static const Color Orange300 = Color(0xFFFFB74D);
  static const Color Orange400 = Color(0xFFFFA726);
  static const Color Orange500 = Color(0xFFFF9800);
  static const Color Orange600 = Color(0xFFFB8C00);
  static const Color Orange700 = Color(0xFFF57C00);
  static const Color Orange800 = Color(0xFFEF6C00);
  static const Color Orange900 = Color(0xFFE65100);
  static const Color NeutralVariant = Color(0xFFEFF6FA);
  static const Color NeutralWhite = Color(0xFFFFFFFF);
  static const Color CustomGreen = Color(0xFF00A940);
  static const Color CustomDarkPink = Color(0xFFE12F58);
  static const Color CustomYellow = Color(0xFFFADB14);
  static const Color CustomBrown = Color(0xFF7A130F);
  static const Color CustomGray = Color(0xFFDADADA);
}

class SurfaceColors {
  static const Primary = DColors.Blue500;
  static const Error = DColors.Red600;
  static const Warning = DColors.Orange800;
  static const PrimaryContainer = DColors.Blue50;
  static const Surface = DColors.NeutralVariant;
  static const SurfaceBright = DColors.NeutralWhite;
  static const SurfaceDim = DColors.Ash400;
  static const DisabledSurface = DColors.Ash300;
  static const DisabledSurfaceBright = DColors.Ash200;
  static const ErrorContainer = DColors.Red100;
  static const ErrorContainerHighest = DColors.Red200;
  static const WarningContainer = DColors.Orange50;
  static const ContainerLowest = DColors.NeutralWhite;
  static const ContainerLow = DColors.Blue50;
  static const Container = DColors.Blue100;
  static const ContainerHigh = DColors.Blue150;
  static const ContainerHighest = DColors.Blue200;
  static const Scrim = DColors.Charcoal800A32;
  static const CustomGreen = DColors.CustomGreen;
  static const CustomPink = DColors.CustomDarkPink;
  static const CustomYellow = DColors.CustomYellow;
  static const CustomBrown = DColors.CustomBrown;
  static const CustomGray = DColors.CustomGray;
}

/// A comprehensive reference of Material 3 color roles, ideal for quick lookup.
class AppColors {
  // static const Color dataRunPrimary     = Color(0xFF00796B);
  // static const Color onDataRunPrimary   = Colors.white;
  // static const Color dataRunAccent      = Color(0xFFFFA000);
  // static const Color dataRunSurface     = Color(0xFFF5F5F5);
  // static const Color onDataRunSurface   = Color(0xFF212121);
  // 👉 Accent Groups: used for key UI elements like buttons, FABs, etc.

  /// The main brand-color for prominent components (FABs, buttons, app bars).
  static const Color primary = Color(0xFF1976D2); // Blue700

  /// Foreground content (text/icons) to ensure contrast on `primary`.
  static const Color onPrimary = Color(0xFFFFFFFF); // White

  /// Lighter/darker variant for cards, chips, or sections.
  static const Color primaryContainer = Color(0xFFBBDEFB); // Blue100

  /// Foreground content for `primaryContainer`.
  static const Color onPrimaryContainer = Color(0xFF0D47A1); // Blue900

  /// Fixed version of brand color (stays same in light/dark themes).
  static const Color primaryFixed = Color(0xFF2196F3); // Blue500

  /// Dimmed fixed variant — stronger, more emphasized.
  static const Color primaryFixedDim = Color(0xFF64B5F6); // Blue300

  /// Foreground color for `primaryFixed`.
  static const Color onPrimaryFixed = Color(0xFFFFFFFF); // White

  /// Lower-emphasis foreground for fixed variant.
  static const Color onPrimaryFixedVariant = Color(0xFFBBDEFB); // Blue100

  // 👉 Secondary accent group: less prominent UI accents.

  /// Secondary accent for UI, e.g., filter chips.
  static const Color secondary = Color(0xFF388E3C); // Green700

  /// Foreground for `secondary`.
  static const Color onSecondary = Color(0xFFFFFFFF); // White

  /// Background variant for `secondary`–used in surfaces.
  static const Color secondaryContainer = Color(0xFFC8E6C9); // Green100

  /// Foreground for `secondaryContainer`.
  static const Color onSecondaryContainer = Color(0xFF1B5E20); // Green900

  /// Fixed secondary color across themes.
  static const Color secondaryFixed = Color(0xFF4CAF50); // Green500

  /// Dimmed fixed secondary variant.
  static const Color secondaryFixedDim = Color(0xFF81C784); // Green300

  /// Foreground for `secondaryFixed`.
  static const Color onSecondaryFixed = Color(0xFFFFFFFF); // White

  /// Lower-emphasis foreground for fixed secondary variant.
  static const Color onSecondaryFixedVariant = Color(0xFFC8E6C9); // Green100

  // 👉 Tertiary accent group: contrasting or balancing accents at dev’s discretion.

  /// Tertiary accent to highlight or balance UI segments.
  static const Color tertiary = Color(0xFF512DA8); // Deep Purple700

  /// Foreground for `tertiary`.
  static const Color onTertiary = Color(0xFFFFFFFF); // White

  /// Background variant for `tertiary`.
  static const Color tertiaryContainer = Color(0xFFD1C4E9); // Purple100

  /// Foreground for `tertiaryContainer`.
  static const Color onTertiaryContainer = Color(0xFF311B92); // Purple900

  /// Fixed tertiary color across themes.
  static const Color tertiaryFixed = Color(0xFF673AB7); // Deep Purple500

  /// Dimmed fixed tertiary variant.
  static const Color tertiaryFixedDim = Color(0xFF9575CD); // Deep Purple300

  /// Foreground for `tertiaryFixed`.
  static const Color onTertiaryFixed = Color(0xFFFFFFFF); // White

  /// Lower-emphasis foreground for fixed tertiary variant.
  static const Color onTertiaryFixedVariant = Color(0xFFD1C4E9); // Purple100

  // 👉 Error & Outline: for error states and UI boundaries.

  /// Standard error color, e.g., form validation errors.
  static const error = DColors.Red600;
  static const warning = DColors.Orange800;
  static const warningContainer = DColors.Orange50;
  /// Foreground for `error`.
  static const Color onError = Color(0xFFFFFFFF); // White

  /// Background container for error messages.
  static const errorContainer = DColors.Red100;

  /// Foreground for `errorContainer`.
  static const Color onErrorContainer = Color(0xFFB71C1C); // Red900

  /// Color for outlines, borders, dividers.
  static const Color outline = Color(0xFF9E9E9E); // Grey500

  /// A variant for outlines with different emphasis.
  static const Color outlineVariant = Color(0xFF616161); // Grey700

  // 👉 Surface layers: manage backgrounds, elevation, and visual hierarchy.

  /// Default “canvas” background, like Scaffold/Dialogs.
  static const Color surface = Color(0xFFFAFAFA); // Grey50

  /// Content color for `surface`.
  static const Color onSurface = Color(0xFF000000); // Black

  /// Darkest surface tone (for elevated or overlay surfaces).
  static const Color surfaceDim = Color(0xFF212121); // Grey900

  /// Lightest surface tone (brightest background).
  static const Color surfaceBright = Color(0xFFFFFFFF); // White

  /// Lowest-emphasis surface container.
  static const Color surfaceContainerLowest = Color(0xFFF5F5F5); // Grey100

  /// Low-emphasis surface container.
  static const Color surfaceContainerLow = Color(0xFFEEEEEE); // Grey200

  /// Mid-level surface container.
  static const Color surfaceContainer = Color(0xFFE0E0E0); // Grey300

  /// High-emphasis surface container (elevated look).
  static const Color surfaceContainerHigh = Color(0xFFBDBDBD); // Grey400

  /// Highest-emphasis, most elevated surface container.
  static const Color surfaceContainerHighest = Color(0xFF9E9E9E); // Grey500

  /// Foreground for variant surfaces.
  static const Color onSurfaceVariant = Color(0xFF616161); // Grey700

  // 👉 Inverse & Depth: for overlays, modal dialogs, shadows.

  /// Inverted surface background – e.g. snackbars over surfaces.
  static const Color inverseSurface = Color(0xFF424242); // Grey800

  /// Content for `inverseSurface`.
  static const Color onInverseSurface = Color(0xFFFFFFFF); // White

  /// Brand color variant for use on inverse surfaces.
  static const Color inversePrimary = Color(0xFF90CAF9); // Blue200

  /// Color of shadow cast by elevated elements.
  static const Color shadow = Color(0x40000000); // Black 25% opacity

  /// Scrim overlay color for modal backgrounds.
  static const Color scrim = Color(0x66000000); // Black 40% opacity

  /// Tint applied to surfaces when elevated or layered.
  static const Color surfaceTint = Color(0xFF1976D2); // Blue700
}
