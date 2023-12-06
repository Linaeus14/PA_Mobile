import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pa_mobile/firebase_options.dart';
import 'package:pa_mobile/provider/provider.dart';
import 'package:pa_mobile/shared/shared.dart';
import 'package:pa_mobile/ui/page/page.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DarkMode()),
        ChangeNotifierProvider(create: (context) => UserData())
      ],
      child: Builder(builder: (context) {
        DarkMode darkMode = Provider.of<DarkMode>(context);
        ThemeModeData theme = ThemeModeData();
        return FutureBuilder(
            future: darkMode.getThemeMode(),
            builder: (context, snapshot) {
              return MaterialApp(
                  title: 'Plantdex',
                  debugShowCheckedModeBanner: false,
                  themeMode: darkMode.active,
                  theme: ThemeData(
                      useMaterial3: true,
                      colorScheme: theme.colorSchemeLight,
                      textTheme: theme.textThemeLight),
                  darkTheme: ThemeData(
                      useMaterial3: true,
                      colorScheme: theme.colorSchemeDark,
                      textTheme: theme.textThemeDark),
                  home: const LaunchApp());
            });
      }),
    );
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
          return Center(child: Text("Failed to load: ${snapshot.error}"));
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
      if (!context.mounted) {
        return const Scaffold(
            body: Center(child: Text("LaunchApp Failed")));
      }
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
      return const MainPage();
    }
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  return const MainPage();
}

class ThemeModeData {
  static ThemeModeData? _instance;
  final ColorScheme colorSchemeLight;
  final ColorScheme colorSchemeDark;
  late TextTheme textThemeLight;
  late TextTheme textThemeDark;

  factory ThemeModeData() {
    _instance ??= ThemeModeData._internal();
    return _instance!;
  }

  ThemeModeData._internal()
      : colorSchemeLight = ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 23, 156, 61),
            brightness: Brightness.light),
        colorSchemeDark = ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 23, 156, 61),
            brightness: Brightness.dark) {
    textThemeLight = TextTheme(
      displayLarge: TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: -1.5,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      displayMedium: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.5,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeLight.primary),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.1,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.4,
          fontFamily: 'Roboto',
          color: colorSchemeLight.onBackground),
    );

    textThemeDark = TextTheme(
      displayLarge: TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: -1.5,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      displayMedium: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.5,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeDark.primary),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.1,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.4,
          fontFamily: 'Roboto',
          color: colorSchemeDark.onBackground),
    );
  }
}
