import 'package:core/app/core_utils.dart';
import 'package:core/core.dart';
import 'package:core/interfaces/arguments.dart';
import 'package:core/pages/page_not_found.dart';
import 'package:core/transition/fade_route.dart';
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

  Route<dynamic> generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);
    final String routerName = uri.path;

    final Arguments routerArgs = settings.arguments != null
        ? (settings.arguments as Arguments)
        : Arguments(uri: uri, params: uri.queryParameters);
    print('settings $settings');

    final navigateTo = routes[routerName];
    if (navigateTo == null) {
      return _generateUnknownRoute(settings);
    }

    String path = routerArgs.uri?.toString() ?? routerName;
    //print('navigate > $navigateTo, path > $path, routerArgs > $routerArgs');

    return _generateRoute(navigateTo, path, routerArgs);
  }

  _generateRoute(
    WidgetBuilderArgs navigateTo,
    String path,
    Arguments? routerArgs,
  ) {
    return FadeRoute(
      child: navigateTo,
      path: path,
      routerArgs: routerArgs,
    );
  }

  _generateUnknownRoute(RouteSettings settings) {
    return FadeRoute(
      child: (context, args) => PageNotFound(),
      path: '/404',
    );
  }
}
