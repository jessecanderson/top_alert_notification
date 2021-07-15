import 'package:flutter/material.dart';

/// This is the actual banner
class TopBannerWidget extends StatefulWidget {
  TopBannerWidget(
    this.overlayEntry,
    this.color,
    this.child, {
    Key? key,
    this.customKey,
    this.closeOnX,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final bool? closeOnX;
  final VoidCallback? onTap;
  final Color color;
  final String? customKey;

  final OverlayEntry overlayEntry;

  @override
  _TopBannerWidgetState createState() => _TopBannerWidgetState();
}

class _TopBannerWidgetState extends State<TopBannerWidget> with SingleTickerProviderStateMixin {
  late Animation offsetAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    _animationSetup();
    super.initState();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  void _animationSetup() async {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );

    Tween<Offset> offsetTween = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.linearToEaseOut,
      ),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 3),
          curve: Curves.easeInOut,
          child: SlideTransition(
            position: offsetAnimation as Animation<Offset>,
            child: buildBannerWidget(context),
          ),
        ),
      ],
    );
  }

  Widget buildBannerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Card(
        key: Key(widget.customKey ?? ""),
        color: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        elevation: 1.0,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 8;
                    if (details.delta.dy < -sensitivity) {
                      // remove for swipe up
                      widget.overlayEntry.remove();
                    }
                  },
                  onTap: _runOnTap,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (checkCloseOption()) rightIconButton(),
          ],
        ),
      ),
    );
  }

  void _runOnTap() {
    var onTapFucntion = widget.onTap;

    if (onTapFucntion != null) {
      onTapFucntion();
    }

    widget.overlayEntry.remove();
  }

  bool checkCloseOption() {
    bool? closeCheckOption = widget.closeOnX;

    if (closeCheckOption != null) {
      return closeCheckOption;
    }
    return false;
  }

  Widget rightIconButton() {
    return IconButton(
      onPressed: widget.overlayEntry.remove,
      icon: Icon(Icons.close),
    );
  }
}
