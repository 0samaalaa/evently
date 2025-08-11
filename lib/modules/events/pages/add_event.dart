import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/authentication/widgets/custom_text_filed.dart';
import 'package:evently/modules/events/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/category_data.dart';
import '../../../core/manager/app_provider.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Event",
              style: TextStyle(
                  color: AppColors.purple,
                  fontSize: 24,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w700),
            ),
            backgroundColor: provider.themeMode == ThemeMode.light
                ? AppColors.lightBg
                : AppColors.darkBg,
            foregroundColor: AppColors.purple,
          ),
          body: Consumer<EventProvider>(
            builder: (context, prov, child) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            CategoryData
                                .eventCategories[prov.tapSelectedIndex].path,
                            height: 203,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        DefaultTabController(
                          length: CategoryData.eventCategories.length,
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            onTap: prov.onTapSelected,
                            indicatorColor: Colors.transparent,
                            indicatorWeight: 1,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: const EdgeInsets.all(0),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            tabs: CategoryData.eventCategories.map((e) {
                              final index = CategoryData.eventCategories.indexOf(e);
                              final isSelected = prov.tapSelectedIndex == index;

                              return Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.purple : Colors.transparent,
                                    borderRadius: BorderRadius.circular(37),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.purple,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        e.icon,
                                        size: 20,
                                        color: isSelected ? Colors.white : AppColors.purple,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : AppColors.purple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.lightBg),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFiled(
                          controller: prov.titleController,
                          prefixIcon: ImageIcon(
                            const AssetImage(AppAssets.tittle_icon),
                            color: provider.themeMode == ThemeMode.light
                                ? null
                                : AppColors.lightBg,
                          ),
                          hintText: "Event Title",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.lightBg),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFiled(
                          controller: prov.descriptionController,
                          maxLines: 3,
                          hintText: "Event Description",
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_rounded,
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.lightBg,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Event Date",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily,
                                          color: provider.themeMode ==
                                                  ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.lightBg),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    prov.selectedDate(context);
                                  },
                                  child: Text(
                                    prov.selectedEventDate == null
                                        ? "Choose Date"
                                        : DateFormat.yMd()
                                            .format(prov.selectedEventDate!),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        color: AppColors.purple),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.lightBg,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Event Time",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily,
                                          color: provider.themeMode ==
                                                  ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.lightBg),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    prov.selectedTime(context);
                                  },
                                  child: Text(
                                    prov.selectedEventTime == null
                                        ? "Choose Time"
                                        : prov.selectedEventTime!
                                            .format(context),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        color: AppColors.purple),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.lightBg),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.purple),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.purple),
                                    child: ImageIcon(
                                      const AssetImage(AppAssets.location_icon),
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? AppColors.lightBg
                                              : AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Choose Event Location",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.purple,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.purple,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            prov.addEvent(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add Event",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.lightBg,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
