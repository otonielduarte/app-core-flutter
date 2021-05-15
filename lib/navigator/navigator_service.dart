import 'package:core/app/core_utils.dart';

class NavigatorService {
  Future<dynamic> navigateTo(
    String routeName, {
    Map<String, String>? queryParams,
  }) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: queryParams,
    );
  }

  void goBack() async {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    } else {
      navigateTo('/example');
    }
  }
}
