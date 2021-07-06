import 'package:flutter/material.dart';
import 'package:top_alert_notification/src/top_banner_widget.dart';

/// This is the main class to contain the Overlay State and the Overlay Entry to allow manipulation of the overlay
class TopAlertNotification {
  TopAlertNotification(this.context, this.child,
      {this.color = Colors.white,
      this.closeOnX,
      this.onTap,
      this.duration = Duration.zero});

  BuildContext context;
  Widget child;
  bool? closeOnX;
  VoidCallback? onTap;
  Duration duration;
  Color color;

  OverlayState? overlayState;
  late OverlayEntry overlayEntry;

  void showTopAlert() async {
    overlayState ??= Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: TopBannerWidget(
              overlayEntry,
              color,
              child,
              onTap: onTap,
              closeOnX: closeOnX,
            ),
          ),
        );
      },
    );

    overlayState?.insert(overlayEntry);

    if (duration != Duration.zero) {
      await Future.delayed(
        duration,
      );

      overlayEntry.remove();
    }
  }

  void dismissTopAlert() {
    overlayEntry.remove();
  }
}
