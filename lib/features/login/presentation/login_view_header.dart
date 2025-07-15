import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginViewHeader extends StatelessWidget {
  const LoginViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                cs.onPrimaryContainer,
                cs.onPrimaryContainer,
              ]),
          boxShadow: const [
            BoxShadow(
                offset: Offset.zero,
                spreadRadius: 0,
                blurRadius: .5,
                color: Colors.black)
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/launcher_icon/header_logo_white.png',
            height: 80,
            width: 80,
          ),
          Text(
            S.of(context).nmcpYemen,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  cs.primary.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
