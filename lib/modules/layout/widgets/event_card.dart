import 'package:evently/modules/firebase_manager/model/event_model.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final EventModel eventModel;
  const EventCard({super.key,required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var prov = Provider.of<LayoutProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      height:250,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.purple,width: 2),
          borderRadius: BorderRadius.circular(16),
          image:  DecorationImage(image: AssetImage(eventModel.categoryImage),fit: BoxFit.contain)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: provider.themeMode == ThemeMode.light
                    ? AppColors.lightBg
                    : AppColors.darkBg,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(DateFormat.d().format(DateTime.parse(eventModel.eventDate)),
                    style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily)),
                Text(DateFormat.MMM().format(DateTime.parse(eventModel.eventDate)),
                    style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: provider.themeMode == ThemeMode.light
                    ? AppColors.lightBg
                    : AppColors.darkBg,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(eventModel.title,
                    style: TextStyle(
                        color:provider.themeMode==ThemeMode.light? AppColors.black:AppColors.lightBg,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily)),
                InkWell(
                    onTap: () {
                      prov.setFav(eventModel);
                    },
                    child:Icon(eventModel.isFav?Icons.favorite :Icons.favorite_border,color: AppColors.purple,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
