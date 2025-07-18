import 'package:datarunmobile/core/network/network_util.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InternetAwareAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const InternetAwareAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InternetAwareAppBarState createState() => _InternetAwareAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _InternetAwareAppBarState extends State<InternetAwareAppBar> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    appLocator<NetworkUtil>().connectivityStatusStream.listen((isOnline) {
      setState(() {
        _isOnline = isOnline;
      });
      // if (!_isOnline) {
      //   _showNoInternetBanner();
      // }
    });
  }

  // void _showNoInternetBanner() {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(S.of(context).noInternetAccess),
  //     duration: const Duration(days: 1), // Make the banner stay persistent
  //     action: SnackBarAction(
  //       label: S.of(context).openSettings,
  //       onPressed: () {
  //         // Open the device's internet settings
  //       },
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isOnline
                ? Icon(
                    MdiIcons.webCheck,
                    key: ValueKey<bool>(_isOnline),
                    color: Colors.green,
                  )
                : Icon(MdiIcons.webOff, key: ValueKey<bool>(_isOnline)),
          ),
          tooltip: _isOnline
              ? S.of(context).internetIsConnected
              : S.of(context).noInternetAccess,
          onPressed: () {
            // You can add additional actions here for when the icon is tapped
          },
        ),
      ],
    );
  }
}
