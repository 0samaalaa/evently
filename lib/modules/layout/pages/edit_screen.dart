import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:evently/modules/firebase_manager/model/event_model.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/category_data.dart';
import '../../../core/manager/app_provider.dart';
import '../../authentication/widgets/custom_text_filed.dart';
import '../../events/manager/event_provider.dart';

class EditEventScreen extends StatelessWidget {
  final EventModel event;
  final String eventId;

  const EditEventScreen({super.key, required this.event, required this.eventId});
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => EventProvider()
        ..initWithEvent(event),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Event",
              style: TextStyle(
                color: AppColors.purple,
                fontSize: 24,
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: appProvider.themeMode == ThemeMode.light
                ? AppColors.lightBg
                : AppColors.darkBg,
            foregroundColor: AppColors.purple,
          ),
          body: Consumer<EventProvider>(
            builder: (context, prov, child) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      CategoryData.eventCategories[prov.tapSelectedIndex].path,
                      height: 190,
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
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    "Title",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: appProvider.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFiled(
                    controller: prov.titleController,
                    hintText: "Event Title",
                    prefixIcon:  Icon(Icons.note_alt_sharp, color: appProvider.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text("Description",style: theme.textTheme.titleMedium?.copyWith(
              color: appProvider.themeMode == ThemeMode.light
              ? Colors.black
                  : Colors.white,
              ),
              ),
                  const SizedBox(height: 8),
                  CustomTextFiled(
                    controller: prov.descriptionController,
                    hintText: "Event Description",
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),


                  // Date & Time
                  _buildDateTimeSection(prov, context, appProvider),
                  const SizedBox(height: 16),
                  // Location (Static for now)
                  Text("Location", style: theme.textTheme.titleMedium?.copyWith(
                    color: appProvider.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  ),
                  _buildLocationSection(appProvider),

                  // Update Button
                  InkWell(

                    onTap: () {
                      prov.updateEvent(context, eventId, event);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "Update Event",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.lightBg,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.inter().fontFamily,
                          ),
                        ),
                      ),
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

  Widget _buildDateTimeSection(EventProvider prov, BuildContext context, AppProvider appProvider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: appProvider.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
                const SizedBox(width: 8),
                const Text("Event Date"),
              ],
            ),
            InkWell(
              onTap: () => prov.selectedDate(context),
              child: Text(
                prov.selectedEventDate == null
                    ? "Choose Date"
                    : DateFormat.yMd().format(prov.selectedEventDate!),
                style:  TextStyle(color: AppColors.purple),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.access_time,color: appProvider.themeMode == ThemeMode.light
    ? Colors.black
        : Colors.white,
    ),
                SizedBox(width: 8),
                Text("Event Time"),
              ],
            ),
            InkWell(
              onTap: () => prov.selectedTime(context),
              child: Text(
                prov.selectedEventTime == null
                    ? "Choose Time"
                    : prov.selectedEventTime!.format(context),
                style: const TextStyle(color: AppColors.purple),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection(AppProvider appProvider) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.purple),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.purple,
              ),
              child: const Icon(Icons.location_on, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text("Cairo , Egypt"),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.purple)
          ],
        ),
      ),
    );
  }
}
