import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15/ThemeProvider.dart';
import 'package:evently_c15/core/remote/local/PrefsManager.dart';
import 'package:evently_c15/core/resources/AppStyle.dart';
import 'package:evently_c15/core/resources/ColorManager.dart';
import 'package:evently_c15/core/resources/constants.dart';
import 'package:evently_c15/ui/forget_password/screen/forget_password_screen.dart';
import 'package:evently_c15/ui/home/screen/home_screen.dart';
import 'package:evently_c15/ui/login/screen/login_screen.dart';
import 'package:evently_c15/ui/login/screen/login_screen.dart';
import 'package:evently_c15/ui/register/screen/register_screen.dart';
import 'package:evently_c15/ui/register/screen/register_screen.dart';
import 'package:evently_c15/ui/splash/screen/splash_screen.dart';
import 'package:evently_c15/ui/start/screen/start_screen.dart';
import 'package:evently_c15/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider()..initTheme(),
      child: EasyLocalization(
          path: "assets/translations",
          supportedLocales: [
            Locale("en"),
            Locale("ar"),
          ],
          fallbackLocale: Locale("en"),
          child: const MyApp())));
}
// .
// ..
// ...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode:themeProvider.themeMode,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute:SplashScreen.routeName ,
      routes: {
        SplashScreen.routeName:(_)=>SplashScreen(),
        StartScreen.routeName:(_)=>StartScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        ForgetPasswordScreen.routeName:(_)=>ForgetPasswordScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routeName:(_)=>HomeScreen()
      },
      );
  }
}

