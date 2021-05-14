import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class FadeRoute extends PageRouteBuilder {
  final WidgetBuilderArgs child;
  final Object? routerArgs;
  final String routeName;
  FadeRoute({
    required this.child,
    required this.routeName,
    required this.routerArgs,
  }) : super(
          settings: RouteSettings(name: routeName),
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
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
