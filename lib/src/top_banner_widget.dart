import 'package:flutter/material.dart';

/// This is the actual banner
class TopBannerWidget extends StatefulWidget {
  TopBannerWidget(
    this.overlayEntry,
    this.color,
    this.child, {
    Key? key,
    this.closeOnX = true,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final bool closeOnX;
  final Function? onTap;
  final Color color;

  OverlayEntry overlayEntry;

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
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
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
        color: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        elevation: 1.0,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 8;
                    if (details.delta.dy < -sensitivity) {
                      // remove for swipe up
                      widget.overlayEntry.remove();
                    }
                  },
                  onTap: _runOnTap,
                  child: widget.child,
                ),
              ),
              if (widget.closeOnX) rightIconButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _runOnTap() {
    widget.onTap;
  }

  Widget rightIconButton() {
    return IconButton(
      onPressed: widget.overlayEntry.remove,
      icon: Icon(Icons.close),
    );
  }
}
