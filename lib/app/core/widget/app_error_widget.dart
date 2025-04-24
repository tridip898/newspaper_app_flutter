import 'package:flutter/material.dart';

import '../constraints/app_constraints.dart';
import '../constraints/app_text_style.dart';

class AppErrorWidget extends StatelessWidget {
  final String headerMsg;
  final String bodyMsg;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Widget? iconWidget;
  final double gapBetweenIconAndHeader;

  const AppErrorWidget({
    super.key,
    this.headerMsg = "So... something funny happened",
    this.bodyMsg =
        "This error is crazy large it covers your whole screen. But no worries though, we\'re working to fix it.",
    this.icon = Icons.warning,
    this.iconSize = 200,
    this.iconColor = Colors.amber,
    this.iconWidget,
    this.gapBetweenIconAndHeader = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: mainPadding(24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget ??
                Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
            appWidget.gapH(gapBetweenIconAndHeader),
            Text(
              headerMsg,
              textAlign: TextAlign.center,
              style: textStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH16,
            Text(
              bodyMsg,
              textAlign: TextAlign.center,
              style: text16Style(),
            ),
          ],
        ),
      ),
    );
  }
}
