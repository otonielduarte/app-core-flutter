import 'package:core/routing/routing_data.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    final uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
