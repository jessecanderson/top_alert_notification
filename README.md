# top_alert_notification

## Welcome to the top alert notification widget

Flutter snackbars and toast widgets only show at the bottom of the main application out of the box. This is a customizable framework to allow a top alert to show when needed, as well as being able to dismiss the alert as required. 

## Features
- Custom `onTap` VoidCallback to allow for the overlay to exicute funcontality
- Swipe up to dismiss 
- Optional `closeOnX` icon to show in the right side to dismiss
- Custom color background for view
- Supports taking a widget as the child


## Future plans
- Expand the view to be flexible height
- Allow more dynamic widgets to be child of the overlay
- Work through any navigation issues to auto remove the overlay

## Getting Started

1. Add `top_alert_notification: 0.0.1` to the `pubspec.yaml` file
1. Run `flutter pub get` to include the package
1. Add `import 'package:import 'package:top_alert_notification/top_alert_notification.dart';`
1. Create new object with the `BuildContext` and child widgets to show. Then call `.showTopAlert()` to show the alert or `.dismissTopAlert()` to remove the alert

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
