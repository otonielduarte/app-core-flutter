import 'package:core/interfaces/arguments.dart';
import 'package:flutter/widgets.dart';

typedef WidgetBuilderArgs = Widget Function(
    BuildContext context, Arguments? args);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
