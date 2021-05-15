import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class FadeRoute extends PageRouteBuilder {
  final WidgetBuilderArgs child;
  final Object? routerArgs;
  final String routerName;
  FadeRoute({
    required this.child,
    this.routerArgs,
    required this.routerName,
  }) : super(
          settings: RouteSettings(
            name: routerName,
            arguments: routerArgs,
          ),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child.call(context, routerArgs),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
}
