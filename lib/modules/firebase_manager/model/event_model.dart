class EventModel {
  String? userID;
  String? id;
  String? categoryId;
  String categoryImage;
  String title;
  String description;
  String eventDate;
  String eventTime;
  bool isFav;

  EventModel({
    this.id,
    this.userID,
    required this.categoryId,
    required this.categoryImage,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.eventTime,
    this.isFav = false,
  });

  EventModel.fromJson(Map<String, dynamic> json)
      : this(
    userID: json["userID"],
    id: json["id"],
    categoryId: json["categoryId"],
    categoryImage: json["categoryImage"],
    title: json["title"],
    description: json["description"],
    eventDate: json["eventDate"],
    eventTime: json["eventTime"],
    isFav: json["isFav"] ?? false,
  );

  // toJson
  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "id": id,
      "categoryId": categoryId,
      "categoryImage": categoryImage,
      "title": title,
      "description": description,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "isFav": isFav,
    };
  }
  EventModel copyWith({
    String? userID,
    String? id,
    String? categoryId,
    String? categoryImage,
    String? title,
    String? description,
    String? eventDate,
    String? eventTime,
    bool? isFav,
  }) {
    return EventModel(
      userID: userID ?? this.userID,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryImage: categoryImage ?? this.categoryImage,
      title: title ?? this.title,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      isFav: isFav ?? this.isFav,
    );
  }
}
