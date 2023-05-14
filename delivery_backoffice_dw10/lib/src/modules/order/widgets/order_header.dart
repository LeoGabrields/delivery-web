import 'package:delivery_backoffice_dw10/src/core/ui/widgets/base_header.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'ADMINISTRAR PEDIDOS',
      buttonLabel: 'NOVO PEDIDO',
      buttonPressed: () {},
    );
  }
}
