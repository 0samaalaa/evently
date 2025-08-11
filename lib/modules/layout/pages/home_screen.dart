import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/firebase_manager/firebase_database.dart';
import 'package:evently/modules/layout/pages/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/category_data.dart';
import '../../../core/manager/app_provider.dart';
import '../manager/layout_provider.dart';
import '../widgets/event_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return Consumer<LayoutProvider>(
      builder: (context, prov, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: provider.themeMode == ThemeMode.light
                ? AppColors.purple
                : AppColors.darkBg,
            toolbarHeight: 180,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24)
              ),
            ),
            leadingWidth: double.infinity,
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome Back ✨",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightBg,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              FirebaseAuth.instance.currentUser?.displayName ?? "",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightBg,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Cairo , Egypt",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lightBg,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          provider.themeMode == ThemeMode.light
                              ? Image.asset(AppAssets.sun)
                              : Image.asset(AppAssets.moon),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.lightBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              provider.lang,
                              style: TextStyle(
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColors.purple
                                    : AppColors.darkBg,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: CategoryData.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final e = CategoryData.categories[index];
                        final isSelected = prov.tapSelectedIndex == index;

                        return GestureDetector(
                          onTap: () => prov.onTapSelected(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (provider.themeMode == ThemeMode.light
                                  ? AppColors.lightBg
                                  : AppColors.purple)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(37),
                              border: Border.all(
                                width: 1,
                                color: isSelected
                                    ? AppColors.purple
                                    : (provider.themeMode == ThemeMode.light
                                    ? Colors.white
                                    : AppColors.purple),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  e.icon,
                                  size: 20,
                                  color: isSelected
                                      ? (provider.themeMode == ThemeMode.light
                                      ? AppColors.purple
                                      : Colors.white)
                                      : (provider.themeMode == ThemeMode.light
                                      ? Colors.white
                                      : AppColors.purple),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  e.name,
                                  style: TextStyle(
                                    color: isSelected
                                        ? (provider.themeMode == ThemeMode.light
                                        ? AppColors.purple
                                        : Colors.white)
                                        : (provider.themeMode == ThemeMode.light
                                        ? Colors.white
                                        : AppColors.purple),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseDatabase.getEvent(CategoryData.categories[prov.tapSelectedIndex].id),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs ?? [];

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final eventModel = data[index].data();
                  final eventId = data[index].id;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            event: eventModel,
                            eventId: eventId,
                          ),
                        ),
                      );
                    },
                    child: EventCard(eventModel: eventModel),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
