import 'package:core/app/core_utils.dart';
import 'package:core/interfaces/arguments.dart';

class NavigatorService {
  Future<dynamic> navigateTo(
    String routeName, {
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) {
    Uri uri = Uri(path: routeName);
    if (queryParams != null) {
      uri = Uri(path: routeName, queryParameters: queryParams);
    }
    print('queryParameters: ${uri.queryParameters} path: ${uri.path}');
    return navigatorKey.currentState!.pushNamed(routeName,
        arguments:
            Arguments().copyWith(params: queryParams, uri: uri, data: data));
  }

  void goBack() async {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    } else {
      navigateTo('/');
    }
  }
}
