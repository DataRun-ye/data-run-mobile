import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

final marketTap = AutoRoute(
  page: const EmptyShellRoute('emptyShellRoute'),
  children: [
    // assuming this is the page that will launch the bottom sheet
    // inside of MarketPage simply call
    // context.pushRoute(BottomSheetRouter());
    // AutoRoute(page: MarketPage, initial: true),
    CustomRoute(
        page: const EmptyShellRoute('emptyShellRoute'),
        customRouteBuilder: modalSheetBuilder),
  ],
);

Route<T> modalSheetBuilder<T>(
    BuildContext context, Widget child, AutoRoutePage<T> page) {
  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true,
  );
}

Route<T> dialogBuilder<T>(
    BuildContext context, Widget child, AutoRoutePage<T> page) {
  return DialogRoute(
    settings: page,
    builder: (context) => child,
    context: context,
  );
}

// DialogRoute
