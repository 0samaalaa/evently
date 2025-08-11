import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:evently/modules/firebase_manager/model/event_model.dart';
import 'package:evently/modules/firebase_manager/firebase_database.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';
import 'edit_screen.dart';


class DetailsScreen extends StatelessWidget {
  final EventModel event;
  final String eventId;

  const DetailsScreen({super.key, required this.event, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMMM yyyy').format(DateTime.parse(event.eventDate));
    final time = event.eventTime;
    final theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details",style: TextStyle(fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.purple,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventScreen(
                    event: event,
                    eventId: eventId,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.red),
            onPressed: () async {
              await FirebaseDatabase.getRef().doc(eventId).delete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                event.categoryImage,
                width: double.infinity,
                height: 203.06,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              event.title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.purple,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    shape: BoxShape.rectangle,borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Icon(Icons.calendar_today_outlined, color: provider.themeMode == ThemeMode.dark
                      ? AppColors.black
                      : Colors.white,size: 24,)),
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.purple),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14, color: theme.primaryColorDark),
                    ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: const BorderSide(color: AppColors.purple),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.centerLeft,
                  backgroundColor: theme.primaryColorLight,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  side: const BorderSide(color: AppColors.purple),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: theme.primaryColorLight,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.purple, shape: BoxShape.rectangle,borderRadius: BorderRadius.all(Radius.circular(8),)
                      ),
                      child: Icon(Icons.my_location_outlined, color: provider.themeMode == ThemeMode.dark
                          ? AppColors.black
                          : Colors.white,size: 24,)),
                    const SizedBox(width: 12),
                    const Text(
                      "Cairo , Egypt",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.purple),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.purple),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                height: 361,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.purple,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: provider.themeMode == ThemeMode.dark
                    ? AppColors.offWhite
                    : AppColors.black,)),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(fontSize: 16, color: provider.themeMode == ThemeMode.dark
              ? AppColors.offWhite
                : AppColors.black,)),
          ],
        ),
      ),
    );
  }
}
