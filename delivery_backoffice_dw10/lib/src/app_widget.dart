import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'core/ui/theme/theme_config.dart';
import 'global/global_context.dart';

class AppWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');
    Modular.setNavigatorKey(_navigatorKey);

    return MaterialApp.router(
      title: 'Delivery Backoffice Dw10',
      theme: ThemeConfig.theme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
