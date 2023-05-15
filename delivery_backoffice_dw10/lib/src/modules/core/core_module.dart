import 'package:delivery_backoffice_dw10/src/repositories/payment_type/payment_type_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/payment_type/payment_type_repository_impl.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/products_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/products_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../core/storage/session_storage.dart';
import '../../core/storage/storage.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton((i) => CustomDio(i()), export: true),
        Bind.lazySingleton<PaymentTypeRepository>(
          (i) => PaymentTypeRepositoryImpl(i()),
          export: true,
        ),
        Bind.lazySingleton<ProductRepository>(
          (i) => ProductRepositoryImpl(i()),
          export: true,
        )
      ];
}
