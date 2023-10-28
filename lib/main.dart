import 'package:flutter/material.dart';
import 'package:mboacare/blog/add_blog_page.dart';
import 'package:mboacare/blog/blog_page.dart';
import 'package:mboacare/settingsPage/settings.dart';
import 'package:mboacare/settingsPage/theme.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/sign_up/view_model/signup_provider.dart';
import 'package:mboacare/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mboacare/user_profile_page.dart';
import 'package:mboacare/user_provider.dart';
import 'package:mboacare/user_data.dart';
import 'package:mboacare/sign_up/view_model/signup_provider.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:provider/provider.dart';
import 'add_hospital/add_hospital_provider.dart';
import 'hospital_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'login/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HospitalProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ChangeNotifierProvider(create: (_) => SignUpProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => AddHospitalProvider()),
      ChangeNotifierProvider(
          create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
      // Add other providers here if needed.
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mboacare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: scaffoldKey,
      // Add supported locales and localizations delegates
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('hi', 'IN'), // Hindi
        Locale('es', 'ES'), // Spanish
        Locale('fr', 'FR'), // French
        // Add more locales here for other languages
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const SplashScreen(),
      routes: {
        '/themeScreen': (context) => const ThemeScreen(),
        '/deleteDialog': (context) => const DeleteAccountDialog(),
        '/profilePage': (context) => const ProfilePage(),
        '/blogPage' : (context) => const BlogPage(),
        '/newBlog' : (context) => const AddBlogPage(),
      },
    ); //MaterialApp
  }
}
