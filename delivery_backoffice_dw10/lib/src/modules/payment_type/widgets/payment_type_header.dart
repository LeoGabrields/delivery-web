import 'package:delivery_backoffice_dw10/src/core/ui/widgets/base_header.dart';
import 'package:delivery_backoffice_dw10/src/modules/payment_type/payment_type_controller.dart';
import 'package:flutter/material.dart';

class PaymentTypeHeader extends StatefulWidget {
  final PaymentTypeController controller;

  const PaymentTypeHeader({super.key, required this.controller});

  @override
  State<PaymentTypeHeader> createState() => _PaymentTypeHeaderState();
}

class _PaymentTypeHeaderState extends State<PaymentTypeHeader> {
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'ADMINISTRAR FORMAS DE PAGAMENTO',
      buttonLabel: 'ADICONAR',
      buttonPressed: () {
        widget.controller.addPayment();
      },
      filterWidget: DropdownButton<bool?>(
        value: null,
        items: const [
          DropdownMenuItem(value: null, child: Text('Todos')),
          DropdownMenuItem(value: true, child: Text('Ativos')),
          DropdownMenuItem(value: false, child: Text('Inativos')),
        ],
        onChanged: (value) {
          setState(() {
            enabled = value;
            widget.controller.changeFilter(value);
          });
        },
      ),
    );
  }
}
