import 'package:delivery_backoffice_dw10/src/models/orders/order_status.dart';
import 'package:flutter/material.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/dto/order/order_dto.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';

class OrderButtonBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderButtonBar({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButton(
          label: 'FINALIZAR',
          image: 'assets/images/icons/finish_order_white_ico.png',
          onPressed: order.status == OrderStatus.confirmado
              ? () {
                  controller.changeStatus(OrderStatus.finalizado);
                }
              : null,
          buttonColor: Colors.blue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        OrderBottomBarButton(
          label: 'CONFIRMAR',
          image: 'assets/images/icons/confirm_order_white_icon.png',
          onPressed: order.status == OrderStatus.pendente
              ? () {
                  controller.changeStatus(OrderStatus.confirmado);
                }
              : null,
          buttonColor: Colors.green,
          borderRadius: BorderRadius.zero,
        ),
        OrderBottomBarButton(
          label: 'CANCELAR',
          image: 'assets/images/icons/cancel_order_white_icon.png',
          onPressed: order.status != OrderStatus.cancelado &&
                  order.status != OrderStatus.finalizado
              ? () {
                  controller.changeStatus(OrderStatus.cancelado);
                }
              : null,
          buttonColor: Colors.red,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ],
    );
  }
}

class OrderBottomBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final String label;
  final Color buttonColor;
  final String image;
  final VoidCallback? onPressed;
  const OrderBottomBarButton({
    super.key,
    required this.borderRadius,
    required this.label,
    required this.buttonColor,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: onPressed != null ? buttonColor : Colors.transparent,
            ),
            backgroundColor: buttonColor,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(width: 5),
              Text(label, style: context.textStyles.textBold),
            ],
          ),
        ),
      ),
    );
  }
}
