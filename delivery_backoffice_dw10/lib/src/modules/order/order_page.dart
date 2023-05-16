import 'package:delivery_backoffice_dw10/src/core/ui/helpers/loader.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'detail/order_detail_modal.dart';
import 'widgets/order_header.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messages {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer reactionDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reactionDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case OrderStateStatus.initial:
            break;
          case OrderStateStatus.loading:
            showLoader();
            break;
          case OrderStateStatus.loaded:
            hideLoader();
            break;
          case OrderStateStatus.showDetailModal:
            hideLoader();
            showOrderDetail();
            break;
          case OrderStateStatus.statusChanged:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.findOrders();
            break;
          case OrderStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro');
            break;
        }
      });
      controller.findOrders();
    });
    super.initState();
  }

  void showOrderDetail() {
    showDialog(
      context: context,
      builder: (context) {
        return OrderDetailModal(
          controller: controller,
          order: controller.orderSelected!,
        );
      },
    );
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.grey[50],
          padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
          child: Column(
            children: [
              OrderHeader(controller: controller),
              const SizedBox(height: 50),
              Expanded(
                child: Observer(
                  builder: (context) {
                    return GridView.builder(
                      itemCount: controller.orders.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 91,
                        maxCrossAxisExtent: 600,
                      ),
                      itemBuilder: (context, index) {
                        return OrderItem(order: controller.orders[index]);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
