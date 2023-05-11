import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'src/core/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  runApp(
    ModularApp(
      module: AppModular(),
      child: AppWidget(),
    ),
  );
}
