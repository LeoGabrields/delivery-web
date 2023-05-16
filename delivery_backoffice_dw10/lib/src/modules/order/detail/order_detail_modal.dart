import 'package:delivery_backoffice_dw10/src/core/extensions/formatter_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/size_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/dto/order/order_dto.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/detail/widgets/order_info_tile.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:flutter/material.dart';

import 'widgets/order_button_bar.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderDetailModal({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyles;
    final screenWidth = context.screenWidth;
    final order = widget.order;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth > 1300 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhe do Pedido',
                        textAlign: TextAlign.center,
                        style: textStyle.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Nome do Cliente: ',
                      style: textStyle.textBold,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      order.user.name,
                      style: textStyle.textRegular,
                    ),
                  ],
                ),
                const Divider(),
                ...order.orderProduct
                    .map((e) => OrderProductItem(orderProduct: e))
                    .toList(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do Pedido',
                        style: textStyle.textExtraBold.copyWith(fontSize: 20),
                      ),
                      Text(
                        order.orderProduct
                            .fold<double>(
                                0.0,
                                (previousValue, p) =>
                                    previousValue + p.totalPrice)
                            .currencyPTBR,
                        style: textStyle.textExtraBold.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                OrderInfoTile(
                  label: 'Endereço de entrega:',
                  info: order.address,
                ),
                const Divider(),
                OrderInfoTile(
                  label: 'Forma de Pagamento:',
                  info: order.paymentTypeModel.name,
                ),
                const SizedBox(height: 10),
                OrderButtonBar(controller: widget.controller, order: widget.order)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
