import 'package:evently/modules/authentication/pages/forget_password_screen.dart';
import 'package:evently/modules/authentication/pages/login_page.dart';
import 'package:evently/modules/authentication/pages/register_screen.dart';
import 'package:evently/modules/layout/pages/layout_screen.dart';
import 'package:evently/modules/onboarding/pages/onboarding_view.dart';
import 'package:evently/modules/onboarding/pages/start_screen.dart';
import 'package:evently/modules/splash/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../modules/events/pages/add_event.dart';

class AppRoutes {
  AppRoutes._();
  static const String splash ="/";
    static const String startScreen ="StartScreen";
  static const String onboardingView ="OnboardingView";
  static const String loginPage ="login";
  static const String RegisterScreen ="register";
  static const String ForgetPasswordScreen ="forgetpassword";
  static const String LayoutScreen ="layout";
  static const String AddEvent ="Addevent";
}


class ROUTES{
  ROUTES._();
  static Map<String, Widget Function(BuildContext)> routes ={
 AppRoutes.splash:(_)=> SplashScreen(),
 AppRoutes.startScreen:(_)=> StartScreen(),
 AppRoutes.onboardingView:(_)=> OnboardingView(),
 AppRoutes.loginPage:(_)=> LoginPage(),
 AppRoutes.RegisterScreen:(_)=> RegisterScreen(),
 AppRoutes.ForgetPasswordScreen:(_)=> ForgetPasswordScreen(),
 AppRoutes.LayoutScreen:(_)=> LayoutScreen(),
 AppRoutes.AddEvent:(_)=> AddEvent(),
  };
}