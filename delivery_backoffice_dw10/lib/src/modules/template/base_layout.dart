import 'package:flutter/material.dart';
import '../../core/ui/helpers/size_extensions.dart';
import 'menu/menu_bar.dart' as menu;

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final showtestSide = context.screenShortesSide;
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: showtestSide * .17,
                maxHeight: showtestSide * .17,
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: showtestSide * .13,
                margin: const EdgeInsets.only(left: 50, bottom: 15),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Positioned.fill(
              top: showtestSide * .13,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50],
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
