import 'package:brasil_fields/brasil_fields.dart';
import 'package:delivery_backoffice_dw10/src/core/extensions/formatter_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/loader.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/size_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/upload_html_helper.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/env/env.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with Loader, Messages {
  final controller = Modular.get<ProductDetailController>();
  final _formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final priceEC = TextEditingController();
  final descriptionEC = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => controller.status, (status) {
        switch (status) {
          case ProductDetailStateStatus.initial:
            break;
          case ProductDetailStateStatus.loading:
            showLoader();
            break;
          case ProductDetailStateStatus.loaded:
            hideLoader();
            final model = controller.productModel!;
            nameEC.text = model.name;
            priceEC.text = model.price.currencyPTBR;
            descriptionEC.text = model.description;
            break;
          case ProductDetailStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro');
            break;
          case ProductDetailStateStatus.errorLoadProduct:
            hideLoader();
            showError('Erro ao carregar o produto para alteração');
            Navigator.pop(context);
            break;
          case ProductDetailStateStatus.uploaded:
            hideLoader();
            break;
          case ProductDetailStateStatus.deleted:
          case ProductDetailStateStatus.saved:
            hideLoader();
            Navigator.pop(context);
            break;
        }
      });
      controller.loadProduct(widget.productId);
    });
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    priceEC.dispose();
    descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthButtonAction = context.percentWidth(.4);
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.productId != null ? 'ALTERAR' : 'ADICIONAR'} PRODUTO',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Observer(
                        builder: (context) {
                          if (controller.imagePath != null) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                '${Env.instance.get('backend_base_url')}${controller.imagePath}',
                                width: 200,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () {
                            UploadHtmlHelper()
                                .startUpload(controller.uploadImageProduct);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(.9),
                          ),
                          child: Observer(
                            builder: (context) {
                              return Text(
                                  '${controller.imagePath == null ? 'Adicionar' : 'Alterar'} Foto');
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: nameEC,
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        ),
                        validator: Validatorless.required('Nome obrigatório'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: priceEC,
                        decoration: const InputDecoration(
                          label: Text('Preço'),
                        ),
                        validator: Validatorless.required('Preço obrigatório'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true)
                        ],
                      ),
                    ],
                  ))
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionEC,
                maxLines: null,
                minLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                  alignLabelWithHint: true,
                ),
                validator: Validatorless.required('Descrição obrigatória'),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: widthButtonAction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: widget.productId != null,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 60,
                          width: widthButtonAction / 2,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: Text(
                                        'Confirma a exclusão do produto ${controller.productModel!.name}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancelar',
                                          style: context.textStyles.textBold
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.deleteProduct();
                                        },
                                        child: Text(
                                          'Confirmar',
                                          style: context.textStyles.textBold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Deletar',
                              style: context.textStyles.textBold
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 60,
                        width: widthButtonAction / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            if (valid) {
                              if (controller.imagePath == null) {
                                showWarning(
                                  'Image obrigatória, por favor clique em adiconar foto',
                                );
                                return;
                              }
                              controller.save(
                                nameEC.text,
                                UtilBrasilFields.converterMoedaParaDouble(
                                    priceEC.text),
                                descriptionEC.text,
                              );
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: context.textStyles.textBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
