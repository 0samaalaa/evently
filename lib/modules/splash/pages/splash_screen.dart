import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/manager/app_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ZoomIn(
                duration: const Duration(seconds: 2),
                child: Image.asset(AppAssets.splashLogo)),
            ZoomIn(
              duration: const Duration(seconds: 2),
              child: Text(
                "Evently",
                style: TextStyle(
                    fontSize: 36,
                    color: AppColors.purple,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.jockeyOne().fontFamily),
              ),
            ),
            const Spacer(),
            FadeInUp(
                delay: const Duration(seconds: 3),
                onFinish: (direction) async {
                  provider.getOntime().then(
                    (value) {
                      if (value) {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.startScreen);
                      } else {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginPage);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.LayoutScreen);
                        }
                      }
                    },
                  );
                },
                child: Image.asset(AppAssets.routeLogo)),
          ],
        ),
      ),
    );
  }
}
