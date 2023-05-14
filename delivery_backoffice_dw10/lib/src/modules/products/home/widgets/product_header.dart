import 'package:delivery_backoffice_dw10/src/core/ui/widgets/base_header.dart';
import 'package:flutter/material.dart';

class ProductHearder extends StatelessWidget {
  const ProductHearder({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'ADMINISTRAR PRODUTOS',
      buttonLabel: 'ADICIONAR PRODUTO',
      buttonPressed: () {},
    );
  }
}
