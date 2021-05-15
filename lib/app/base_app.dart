import 'package:core/app/core_utils.dart';
import 'package:core/core.dart';
import 'package:core/pages/page_not_found.dart';
import 'package:core/routing/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/extensions/string_extension.dart';

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

  Route<dynamic> generateUnknownRoute(RouteSettings settings) {
    print('page not found $settings');
    return FadeRoute(
      child: (context, args) => PageNotFound(),
      routerName: '/404',
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final String routerName = settings.name!;

    final routingData = settings.name!.getRoutingData;
    final routerArgs = routingData.args;
    final navigateTo = routes[routingData.route];

    if (navigateTo == null) {
      return generateUnknownRoute(settings);
    }
    return FadeRoute(
      child: navigateTo,
      routerName: routerName,
      routerArgs: routerArgs,
    );
  }
}
