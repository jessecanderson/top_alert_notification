import 'package:flutter/material.dart';

void showTopAlert(BuildContext context, Widget child, {OverlayState? overlayState}) async {
  overlayState ??= Overlay.of(context);

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: child,
        ),
      );
    },
  );

  overlayState?.insert(overlayEntry);

  // await Future.delayed(
  //   Duration(seconds: 2),
  // );

  // overlayEntry.remove();
}

class TopAlertNotification extends StatefulWidget {
  TopAlertNotification({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _TopAlertNotificationState createState() => _TopAlertNotificationState();
}

class _TopAlertNotificationState extends State<TopAlertNotification> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 100, 8, 0),
        child: Card(
          color: const Color(0xFFF79912),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          elevation: 1.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: widget.child,
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.close),
              ),
            ],
          ),
        ),
      );
}
