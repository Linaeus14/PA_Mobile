import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pa_mobile/firebase_options.dart';
import 'package:pa_mobile/provider/provider.dart';
import 'package:pa_mobile/shared/shared.dart';
import 'package:pa_mobile/ui/page/page.dart';
import 'package:provider/provider.dart';
import 'dart:collection';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeModeData theme = ThemeModeData();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PlantData())],
      child: Builder(builder: (context) {
        return MaterialApp(
            title: 'Plantdex',
            debugShowCheckedModeBanner: false,
            themeMode: theme._themeMode,
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: theme.colorSchemeLight,
                textTheme: theme.textTheme),
            darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: theme.colorSchemeDark,
                textTheme: theme.textTheme),
            home: const LaunchApp());
      }),
    );
  }
}

class ThemeModeData {
  ThemeMode _themeMode = ThemeMode.system;
  final ColorScheme _colorSchemeDark = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 52, 189, 91), brightness: Brightness.dark);
  final ColorScheme _colorSchemeLight = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 23, 156, 61),
      brightness: Brightness.light);
  final List<bool> _isSelected = [true, false, false];
  final TextTheme _appTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: -1.5,
        fontFamily: 'Roboto',
        color: Colors.grey),
    displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.5,
        fontFamily: 'Roboto',
        color: Colors.grey),
    displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: 0,
        fontFamily: 'Roboto',
        color: Colors.grey),
    headlineLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        fontFamily: 'Roboto',
        color: Colors.grey),
    headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        fontFamily: 'Roboto',
        color: Colors.grey),
    headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0,
        fontFamily: 'Roboto',
        color: Colors.grey),
    titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,
        fontFamily: 'Roboto',
        color: Colors.grey),
    titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,
        fontFamily: 'Roboto',
        color: Colors.grey),
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.1,
        fontFamily: 'Roboto',
        color: Colors.grey),
    bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.5,
        fontFamily: 'Roboto',
        color: Colors.grey),
    bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        fontFamily: 'Roboto',
        color: Colors.grey),
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.4,
        fontFamily: 'Roboto',
        color: Colors.grey),
  );

  ThemeMode get themeMode => _themeMode;
  ColorScheme get colorSchemeDark => _colorSchemeDark;
  ColorScheme get colorSchemeLight => _colorSchemeLight;
  TextTheme get textTheme => _appTextTheme;
  UnmodifiableListView<bool> get isSelected =>
      UnmodifiableListView(_isSelected);

  void _themeSelect(int index) {
    _themeMode = index == 0
        ? ThemeMode.system
        : index == 1
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  void onPressToogle(int newIndex) {
    for (int index = 0; index < _isSelected.length; index++) {
      if (index == newIndex) {
        _isSelected[index] = true;
        _themeSelect(index);
      } else {
        _isSelected[index] = false;
      }
    }
  }
}

class LaunchApp extends StatelessWidget {
  const LaunchApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: checkFirstLaunch(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load"));
        } else {
          return snapshot.data!;
        }
      },
    );
  }

  Future<Widget> checkFirstLaunch(BuildContext context) async {
    Shared saveData = Shared();
    await saveData.open();
    bool isFirstLaunch = saveData.file.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {
      await saveData.file.setBool('firstLaunch', false);
      return const OnboardingScreen();
    } else {
      if (!context.mounted) return const MainPage();
      return checkAuthenticationState(context);
    }
  }
}

Future<Widget> checkAuthenticationState(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserData userData = Provider.of<UserData>(context, listen: false);
      userData.userId = user.uid;
      await userData.getData();
    }
    return const MainPage();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return const MainPage();
  }
}
