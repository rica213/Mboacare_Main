import 'package:flutter/material.dart';
import 'package:mboacare/dashboard.dart';
import 'package:mboacare/facilities/view/screens/facilities_page.dart';
import 'package:mboacare/settingsPage/aboutUs/aboutUs.dart';
import 'package:mboacare/settingsPage/settings.dart';
import 'package:mboacare/settingsPage/theme/themeConstants.dart';
import 'package:mboacare/settingsPage/theme/themeScreen.dart';
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
import 'package:mboacare/facilities/provider/facilities_provider.dart';

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
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => FacilitiesProvider()),
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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? ThemeData.dark().copyWith(
                // colorScheme: ,
                scaffoldBackgroundColor: DarkThemeColors.background,
                cardColor: DarkThemeColors.cardBackground,
                primaryColor: DarkThemeColors.primaryText,
                //accentColor: DarkThemeColors.accentColor,
                //buttonColor: DarkThemeColors.buttonBackground,
                textTheme: const TextTheme(
                  headlineSmall: TextStyle(
                    color: DarkThemeColors.primaryText,
                  ),
                  bodyMedium: TextStyle(
                    color: DarkThemeColors.secondaryText,
                  ),
                ),
              )
            : ThemeData.light(),
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        //notifier.darkTheme ? themeLight : themeDark,
        //     ThemeData(
        //   colorScheme:
        //       ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        //   useMaterial3: true,
        // ),
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
          //'/deleteDialog': (context) => DeleteAccountDialog(),
          '/profilePage': (context) => const ProfilePage(),
          '/aboutUs': (context) => const AboutUs(),
          '/home': (context) => const DashboardContent(),
          '/facilities': (context) => const FacilitiesPage(),
        });
  }
}
