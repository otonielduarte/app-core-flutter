import 'package:core/app/core_utils.dart';
import 'package:core/app/fade_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'microapp.dart';

abstract class BaseApp {
  List<MicroApp> get microApps;

  Map<String, WidgetBuilderArgs> get baseRoutes;

  final Map<String, WidgetBuilderArgs> routes = {};

  void registerRouters() {
    if (baseRoutes.isNotEmpty) routes.addAll(baseRoutes);
    if (microApps.isNotEmpty) {
      for (MicroApp microapp in microApps) {
        routes.addAll(microapp.routes);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    var routerName = settings.name;
    var routerArgs = settings.arguments;

    var navigateTo = routes[routerName];
    if (navigateTo == null) return null;

    return FadeRoute(
      child: navigateTo,
      routeName: routerName!,
      routerArgs: routerArgs,
    );
  }
}
