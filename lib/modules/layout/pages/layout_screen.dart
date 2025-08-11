import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider()..getEvent(),
      child: Consumer<LayoutProvider>(
        builder: (context, prov, child) {
          return Scaffold(
            floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(
              splashColor: AppColors.lightBg.withOpacity(0.1),
              backgroundColor: provider.themeMode == ThemeMode.light
                  ? AppColors.purple
                  : AppColors.darkBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(360),
                side: const BorderSide(color: AppColors.lightBg, width: 6),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.AddEvent);
              },
              child: const Icon(
                Icons.add,
                color: AppColors.lightBg,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: prov.changeBottomNavigationBar,
                currentIndex: prov.selectedIndex,
                iconSize: 25,
                elevation: 0,
                selectedItemColor: AppColors.lightBg,
                unselectedItemColor: AppColors.lightBg,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    fontFamily: GoogleFonts.inter().fontFamily),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    fontFamily: GoogleFonts.inter().fontFamily),
                backgroundColor: provider.themeMode == ThemeMode.light
                    ? AppColors.purple
                    : AppColors.darkBg,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: "Home",
                      activeIcon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on_outlined),
                      label: "Map",
                      activeIcon: Icon(Icons.location_on)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: "favorite",
                      activeIcon: Icon(Icons.favorite)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_rounded),
                      label: "Profile",
                      activeIcon: Icon(Icons.person)),
                ]),
            body:prov.screens[prov.selectedIndex],
          );
        },
      ),
    );
  }
}
