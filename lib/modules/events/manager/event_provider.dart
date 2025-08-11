import 'package:evently/core/constant/category_data.dart';
import 'package:evently/modules/layout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../firebase_manager/firebase_database.dart';
import '../../firebase_manager/model/event_model.dart';

class EventProvider extends ChangeNotifier {
  int selectedIndex = 0;
  int tapSelectedIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;

  void changeBottomNavigationBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onTapSelected(int index) {
    tapSelectedIndex = index;
    notifyListeners();
  }

  void selectedDate(BuildContext context) {
    showDatePicker(
      context: context,
      currentDate: selectedEventDate,
      initialDate: selectedEventDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 5000)),
    ).then((value) {
      if (value != null) {
        selectedEventDate = value;
        notifyListeners();
      }
    });
  }

  void selectedTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: selectedEventTime ?? TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        selectedEventTime = value;
        notifyListeners();
      }
    });
  }

  Future<void> addEvent(BuildContext context) async {
    Loading.show(context);
    EventModel data = EventModel(
      categoryId: CategoryData.eventCategories[tapSelectedIndex].id,
      categoryImage: CategoryData.eventCategories[tapSelectedIndex].path,
      title: titleController.text,
      description: descriptionController.text,
      eventDate: selectedEventDate!.toIso8601String(),
      eventTime: selectedEventTime!.format(context),
    );
    await FirebaseDatabase.addEvent(data);
    Loading.hide(context);
    Navigator.pop(context);
  }

  void initWithEvent(EventModel event) {
    titleController.text = event.title;
    descriptionController.text = event.description;
    selectedEventDate = DateTime.tryParse(event.eventDate);

    try {
      final parts = event.eventTime.split(":");
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      selectedEventTime = TimeOfDay(hour: hour, minute: minute);
    } catch (_) {}

    tapSelectedIndex = CategoryData.eventCategories.indexWhere(
          (cat) => cat.id == event.categoryId,
    );

    if (tapSelectedIndex == -1) tapSelectedIndex = 0;

    notifyListeners();
  }


  Future<void> updateEvent(BuildContext context, String eventId, EventModel oldEvent) async {
    Loading.show(context);
    final updatedEvent = EventModel(
      id: eventId,
      userID: oldEvent.userID,
      categoryId: CategoryData.eventCategories[tapSelectedIndex].id,
      categoryImage: CategoryData.eventCategories[tapSelectedIndex].path,
      title: titleController.text,
      description: descriptionController.text,
      eventDate: selectedEventDate?.toIso8601String() ?? oldEvent.eventDate,
      eventTime: selectedEventTime?.format(context) ?? oldEvent.eventTime,
      isFav: oldEvent.isFav,
    );
    await FirebaseDatabase.getRef().doc(eventId).update(updatedEvent.toJson());
    Loading.hide(context);
    if (context.mounted) Navigator.pop(context);
  }
}
