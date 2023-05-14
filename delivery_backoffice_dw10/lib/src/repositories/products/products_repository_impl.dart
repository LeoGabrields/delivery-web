import 'package:delivery_backoffice_dw10/src/core/rest_client/custom_dio.dart';
import 'package:delivery_backoffice_dw10/src/models/product_model.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;
  ProductsRepositoryImpl(this._dio);

  @override
  Future<List<ProductModel>> findAll() async {
    final productsResult = await _dio.unauth().get('products');

    return productsResult.data.map((p) => ProductModel.fromMap(p)).toList();
  }
}
