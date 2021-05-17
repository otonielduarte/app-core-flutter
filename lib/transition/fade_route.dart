import 'package:core/core.dart';
import 'package:core/interfaces/arguments.dart';
import 'package:flutter/widgets.dart';

class FadeRoute extends PageRouteBuilder {
  final WidgetBuilderArgs child;
  final Arguments? routerArgs;
  final String path;
  FadeRoute({
    required this.child,
    this.routerArgs,
    required this.path,
  }) : super(
          settings: RouteSettings(
            name: path,
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
