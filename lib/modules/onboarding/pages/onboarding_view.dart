import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/manager/app_provider.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/onboarding/pages/onboarding_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final Pagecontroller = PageController();
  bool isLastPage = false;
  bool isFirstPage = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          color:  provider.themeMode==ThemeMode.light?AppColors.lightBg:AppColors.darkBg,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child:IconButton(
                          onPressed: () => Pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.decelerate),
                          icon: provider.themeMode == ThemeMode.light
                              ? Image.asset(
                                  AppAssets.arrow_back,
                                )
                              : Image.asset(AppAssets.arrow_back_D)),
                ),
                SmoothPageIndicator(
                  onDotClicked: (index) => Pagecontroller.animateToPage(index,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.decelerate),
                  controller: Pagecontroller,
                  count: provider.themeMode == ThemeMode.light
                      ? controller.itemsLight.length
                      : controller.itemsDark.length,
                  effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: theme.primaryColorDark,
                      activeDotColor: AppColors.purple),
                ),
                Container(
                  child: isLastPage
                      ? finishButton()
                      : IconButton(
                          onPressed: () => Pagecontroller.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.decelerate),
                          icon: provider.themeMode == ThemeMode.light
                              ? Image.asset(
                                  AppAssets.arrow_forward,
                                )
                              : Image.asset(AppAssets.arrow_fowrard_D)),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInLeftBig(
                    delay: const Duration(milliseconds: 2),
                    child: Image.asset(
                      AppAssets.splashLogo,
                      height: 55,
                    )),
                const SizedBox(
                  width: 8,
                ),
                FadeInRightBig(
                  delay: const Duration(milliseconds: 2),
                  child: Text(
                    "Evently",
                    style: TextStyle(
                        fontSize: 36,
                        color: AppColors.purple,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.jockeyOne().fontFamily),
                  ),
                ),
              ],
            ),
            Container(
              child: Expanded(
                child: PageView.builder(
                  controller: Pagecontroller,
                  onPageChanged: provider.themeMode == ThemeMode.light
                      ? (index) => setState(() => isLastPage =
                          controller.itemsLight.length - 1 == index)
                      : (index) => setState(() => isLastPage =
                          controller.itemsDark.length - 1 == index),
                  itemCount: provider.themeMode == ThemeMode.light
                      ? controller.itemsLight.length
                      : controller.itemsDark.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 44,
                          ),
                          Center(
                              child: provider.themeMode == ThemeMode.light
                                  ? Image.asset(
                                      controller.itemsLight[index].image)
                                  : Image.asset(
                                      controller.itemsDark[index].image)),
                          const SizedBox(
                            height: 44,
                          ),
                          Text(
                            controller.itemsLight[index].title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: AppColors.purple),
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Text(
                            controller.itemsLight[index].descriptions,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w500,
                                color: theme.primaryColorDark),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget finishButton() {
    return TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", true);

          if (!mounted) return;
          Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        },
        child: const Text(
          "Finish",
          style: TextStyle(
              color: AppColors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ));
  }
}
