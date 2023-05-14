import 'package:mobx/mobx.dart';
part 'products_controller.g.dart';


class ProductsController = ProductsControllerBase with _$ProductsController;

abstract class ProductsControllerBase with Store {}
