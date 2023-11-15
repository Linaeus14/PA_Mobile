import 'package:flutter/material.dart';
import 'package:pa_mobile/ui/widget/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Plantdex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: ButtonPrimary(
              text: "Sign In",
              mediaQueryWidth: width,
              mediaQueryHeight: height,
              onPressed: () {}),
        ),
      ),
    );
  }
}
