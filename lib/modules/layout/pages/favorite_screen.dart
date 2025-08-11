import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/authentication/widgets/custom_text_filed.dart';
import 'package:evently/modules/layout/pages/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/manager/app_provider.dart';
import '../manager/layout_provider.dart';
import '../widgets/event_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<LayoutProvider>(context, listen: false).getFavEvent();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var prov = Provider.of<LayoutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.themeMode == ThemeMode.light
            ? AppColors.lightBg
            : AppColors.darkBg,
        title: Text(
          "Favorites Events",
          style: TextStyle(
              color: AppColors.purple,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: GoogleFonts.inter().fontFamily),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.purple,width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.purple,width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.purple,width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: "Search for Event",
                  hintStyle: const TextStyle(
                      color: AppColors.purple, fontWeight: FontWeight.w500),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.purple,
                  ),),onChanged: (q) {
                prov.search(q);
                  },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prov.favEvents.length,
              itemBuilder: (context, index) {
                final event = prov.favEvents[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          event: event,
                          eventId: event.id!,
                        ),
                      ),
                    );
                  },
                  child: EventCard(eventModel: event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
