import 'package:datarunmobile/core/network/if_online_abstract.provider.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ConnWidgetBuilder = Widget Function(BuildContext, WidgetRef);

/// Example:
/// ```dart
/// ConnectivityBuilder(
///   onlineBuilder: (c, ref) => ItemsListView(),        // your normal list
///   offlineBuilder: (c, ref) => OfflinePlaceholder(),  // any offline UI
/// );
/// ```
class ConnectivityBuilder extends ConsumerWidget {
  ConnectivityBuilder({
    required this.onlineBuilder,
    required this.offlineBuilder,
    this.loadingWidget,
    this.errorWidget,
  });

  final ConnWidgetBuilder onlineBuilder;
  final ConnWidgetBuilder offlineBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isOnlineProvider).when(
          data: (online) => online
              ? onlineBuilder(context, ref)
              : offlineBuilder(context, ref),
          loading: () =>
              loadingWidget ?? Center(child: CircularProgressIndicator()),
          error: (e, st) => errorWidget ?? getErrorWidget(e, st),
        );
  }
}
