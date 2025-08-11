import 'package:evently/modules/firebase_manager/firebase_database.dart';
import 'package:evently/modules/firebase_manager/model/event_model.dart';
import 'package:evently/modules/layout/pages/favorite_screen.dart';
import 'package:evently/modules/layout/pages/home_screen.dart';
import 'package:evently/modules/layout/pages/map_screen.dart';
import 'package:evently/modules/layout/pages/profile_screen.dart';
import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  int selectedIndex = 0;
  int tapSelectedIndex = 0;
  void changeBottomNavigationBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [
    HomeScreen(),
    MapScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];

  void onTapSelected(int index) {
    tapSelectedIndex = index;
    notifyListeners();
  }

  List<EventModel> events = [];
  List<EventModel> favEvents = [];

  setFav(EventModel data) {
    FirebaseDatabase.setFav(data);
    getEvent();
    getFavEvent();
  }

  Future<void> getEvent() async {
    events.clear();
    var data = FirebaseDatabase.getEvent();
    data.asBroadcastStream(
      onListen: (subscription) {
        subscription.onData(
          (data) {
            for (var element in data.docs) {
              events.add(element.data());
            }
            notifyListeners();
          },
        );
      },
    );
  }

  Future<void> getFavEvent() async {
    favEvents.clear();
    var data = await FirebaseDatabase.getFavEvent();

    for (var element in data) {
      favEvents.add(element.data());
    }
    notifyListeners();
  }

  Future<void> search(String q) async {
    if (q.isEmpty) {
      getFavEvent();
      return;
    }
    var data = favEvents.where(
      (element) {
        return element.title.contains(q);
      },
    ).toList();
    favEvents = data;
    notifyListeners();
  }
}
