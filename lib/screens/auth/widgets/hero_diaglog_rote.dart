import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    @required WidgetBuilder widgetBuilder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _widgetBuilder = widgetBuilder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _widgetBuilder;
  @override
  Color get barrierColor => Colors.black38;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _widgetBuilder(context);
  }

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;
  @override
  String get barrierLabel => "Popup opened";

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
