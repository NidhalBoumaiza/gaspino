import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/Low code development-amico.jpg')),
              ReusableText(
                text: "Under development...",
                textSize: 20,
                textColor: Color(0xff263238),
                textFontWeight: FontWeight.w800,
              )
            ],
          ),
        ),
      ),
    );
  }
}
