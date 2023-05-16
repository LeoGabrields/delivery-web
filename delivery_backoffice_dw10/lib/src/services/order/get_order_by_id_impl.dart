import 'package:delivery_backoffice_dw10/src/dto/order/order_dto.dart';
import 'package:delivery_backoffice_dw10/src/dto/order/order_product_dto.dart';
import 'package:delivery_backoffice_dw10/src/models/orders/order_model.dart';
import 'package:delivery_backoffice_dw10/src/models/payment_type_model.dart';
import 'package:delivery_backoffice_dw10/src/models/user_model.dart';
import 'package:delivery_backoffice_dw10/src/repositories/payment_type/payment_type_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/products_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/user/user_repository.dart';
import './get_order_by_id.dart';

class GetOrderBydImpl implements GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductRepository _productRepository;
  GetOrderBydImpl(
    this._paymentTypeRepository,
    this._userRepository,
    this._productRepository,
  );

  @override
  Future<OrderDto> call(OrderModel order) => _orderDtoParse(order);

  Future<OrderDto> _orderDtoParse(OrderModel order) async {
    final paymenetTypeFuture =
        _paymentTypeRepository.getById(order.paymentTypeId);
    final userFuture = _userRepository.getById(order.userId);
    final orderProductsFuture = _orderProductParse(order);

    final responses = await Future.wait(
        [paymenetTypeFuture, userFuture, orderProductsFuture]);

    return OrderDto(
      id: order.id,
      date: order.date,
      status: order.status,
      orderProduct: responses[2] as List<OrderProductDto>,
      user: responses[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentTypeModel: responses[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> _orderProductParse(OrderModel order) async {
    final orderProducts = <OrderProductDto>[];
    final productsFuture = order.orderProducts
        .map((e) => _productRepository.getProduct(e.productId))
        .toList();

    final products = await Future.wait(productsFuture);

    for (var i = 0; i < order.orderProducts.length; i++) {
      final orderProduct = order.orderProducts[i];
      final productDto = OrderProductDto(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );
      orderProducts.add(productDto);
    }
    return orderProducts;
  }
}
