import 'package:flutter/material.dart';

class CategoryData {
  String name;
  String id;
  String path;
  IconData? icon;

  CategoryData({
    required this.name,
    required this.id,
    required this.path,
    required this.icon,
  });

  static List<CategoryData> categories = [
    CategoryData(name: "All", id: "All", path: "", icon: Icons.apps),
    CategoryData(name: "Sport",
        id: "Sport",
        path: "assets/images/sport.png",
        icon: Icons.directions_bike_outlined),
    CategoryData(name: "Birthday",
        id: "Birthday",
        path: "assets/images/birthday.png",
        icon: Icons.cake),
    CategoryData(name: "Meeting",
        id: "Meeting",
        path: "assets/images/meeting.png",
        icon: Icons.business_center),
    CategoryData(name: "Gaming",
        id: "Gaming",
        path: "assets/images/gaming.png",
        icon: Icons.videogame_asset),
    CategoryData(name: "Eating",
        id: "Eating",
        path: "assets/images/eating.png",
        icon: Icons.restaurant),
    CategoryData(name: "Holiday",
        id: "Holiday",
        path: "assets/images/holiday.png",
        icon: Icons.beach_access),
    CategoryData(name: "Exhibition",
        id: "Exhibition",
        path: "assets/images/exhibition.png",
        icon: Icons.art_track),
    CategoryData(name: "Workshop",
        id: "Workshop",
        path: "assets/images/workshop.png",
        icon: Icons.handyman),
    CategoryData(name: "Book Club",
        id: "Book Club",
        path: "assets/images/Book Club.png",
        icon: Icons.menu_book),
  ];

  static List<CategoryData> eventCategories = [
    CategoryData(name: "Sport", id: "Sport", path: "assets/images/sport.png", icon: Icons.sports_soccer),
    CategoryData(name: "Birthday", id: "Birthday", path: "assets/images/birthday.png", icon: Icons.cake),
    CategoryData(name: "Meeting", id: "Meeting", path: "assets/images/meeting.png", icon: Icons.groups),
    CategoryData(name: "Gaming", id: "Gaming", path: "assets/images/gaming.png", icon: Icons.videogame_asset),
    CategoryData(name: "Eating", id: "Eating", path: "assets/images/eating.png", icon: Icons.restaurant),
    CategoryData(name: "Holiday", id: "Holiday", path: "assets/images/holiday.png", icon: Icons.beach_access),
    CategoryData(name: "Exhibition", id: "Exhibition", path: "assets/images/exhibition.png", icon: Icons.museum),
    CategoryData(name: "Workshop", id: "Workshop", path: "assets/images/workshop.png", icon: Icons.handyman),
    CategoryData(name: "Book Club", id: "Book Club", path: "assets/images/Book Club.png", icon: Icons.menu_book),
  ];
}