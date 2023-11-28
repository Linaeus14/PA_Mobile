import 'package:flutter/material.dart';
import 'package:pa_mobile/provider/provider.dart';
import 'package:pa_mobile/ui/page/page.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PlantData())],
      child: Builder(builder: (context) {
        return MaterialApp(
            title: 'Plantdex',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF338249)),
              useMaterial3: true,
            ),
            home: OnboardingScreen(
                mediaQueryWidth: width, mediaQueryHeight: height));
      }),
    );
  }
}
