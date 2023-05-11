import 'package:flutter_modular/flutter_modular.dart';

import 'products_page.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const ProductsPage(),
        )
      ];
}
