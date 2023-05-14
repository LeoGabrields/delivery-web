import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/colors_app.dart';
import '../../core/ui/styles/text_styles.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<LoginController>();
  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction(
      (_) => controller.loginStatus,
      (status) {
        switch (status) {
          case LoginStateStatus.initial:
          case LoginStateStatus.loading:
            showLoader();
          case LoginStateStatus.success:
            hideLoader();
            Modular.to.navigate('/');
          case LoginStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro');
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  void _formSubmit() {
    final formValid = formKey.currentState?.validate() ?? false;

    if (formValid) {
      controller.login(emailEC.text, passwordEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenShortestSide = context.screenShortesSide;
    final screeWidth = context.screenWidth;

    return Scaffold(
      backgroundColor: context.colors.black,
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenShortestSide * .5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/lanche.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: context.percentHeight(.1)),
              width: screenShortestSide * .5,
              child: Image.asset('assets/images/logo.png'),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        context.percentWidth(screeWidth < 1300 ? .6 : .35),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .3,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 20),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Login',
                            style: context.textStyles.textTitle,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailEC,
                          onFieldSubmitted: (_) => _formSubmit(),
                          decoration: const InputDecoration(
                            label: Text('E-mail'),
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail obrigatorio'),
                            Validatorless.email('E-mail inválido'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordEC,
                          onFieldSubmitted: (_) => _formSubmit(),
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                          ),
                          validator:
                              Validatorless.required('Password Obrigatório'),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _formSubmit,
                            child: const Text('Entrar'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
