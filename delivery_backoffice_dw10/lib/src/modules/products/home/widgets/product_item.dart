import 'package:delivery_backoffice_dw10/src/modules/products/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:delivery_backoffice_dw10/src/core/extensions/formatter_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/env/env.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: constraints.maxHeight * .6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${Env.instance.get('backend_base_url')}${product.image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Tooltip(
                  message: product.name,
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.textMedium,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(product.price.currencyPTBR),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ProductController>().editProduct(product);
                    },
                    child: const Text('Editar'),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
