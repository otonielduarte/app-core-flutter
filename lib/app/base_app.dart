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

    Arguments routerArgs = settings.arguments != null
        ? (settings.arguments as Arguments)
        : Arguments(uri: uri, params: uri.queryParameters);

    print('[RouteSettings] settings $settings');

    final navigateTo = routes[routerName];

    if (navigateTo == null) {
      Route<dynamic>? dynamicRoute;
      routes.forEach((key, value) {
        final result = _parseUrlParams(key, uri);
        if (result != null) {
          Map<String, dynamic> combinedArgs = {};
          combinedArgs.addAll(result.params);
          combinedArgs.addAll(routerArgs.params);

          dynamicRoute = _generateRoute(
            value,
            Uri(path: uri.path, queryParameters: routerArgs.params).toString(),
            Arguments(params: combinedArgs, uri: result.uri),
          );
          return;
        }
      });
      if (dynamicRoute != null) return dynamicRoute!;
      return _generateUnknownRoute();
    }

    String path = routerArgs.uri?.toString() ?? routerName;

    return _generateRoute(navigateTo, path, routerArgs);
  }

  Route<dynamic> _generateRoute(
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

  _generateUnknownRoute() {
    return FadeRoute(
      child: (context, args) => PageNotFound(),
      path: '/404',
    );
  }
}

String prepareToRegex(String url) {
  final newUrl = <String>[];
  for (var part in url.split('/')) {
    var url = part.contains(":") ? "(.*?)" : part;
    newUrl.add(url);
  }

  return newUrl.join("/");
}

RoutingData? _parseUrlParams(String routeNamed, Uri uri) {
  if (routeNamed.contains('/:')) {
    final regExp =
        RegExp("^${prepareToRegex(routeNamed)}\$", caseSensitive: true);

    var r = regExp.firstMatch(uri.path);
    if (r != null) {
      final Map<String, dynamic> params = {};
      final routeParts = routeNamed.split('/');
      final pathParts = uri.path.split('/');
      int paramPos = 0;

      print('Match! Processing $r as $routeNamed');

      for (final routePart in routeParts) {
        print('routePart: $routePart');
        if (routePart.contains(":")) {
          final paramName = routePart.replaceFirst(':', '');
          if (pathParts[paramPos].isNotEmpty) {
            params[paramName] = pathParts[paramPos];
            routeNamed = routeNamed.replaceFirst(routePart, params[paramName]!);
            print('paramName $paramName, paramsMap $params');
          }
        }
        paramPos++;
      }
      print('params >>>> $params');
      uri = uri.replace(path: routeNamed);

      return RoutingData(uri, params);
    }
  }

  return null;
}

class RoutingData {
  final Uri uri;
  final Map<String, dynamic> params;

  RoutingData(this.uri, this.params);
}
