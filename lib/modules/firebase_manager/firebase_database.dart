import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/modules/firebase_manager/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  static CollectionReference<EventModel> getRef() {
    return FirebaseFirestore.instance.collection("Events").withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addEvent(EventModel data) async {
    var ref = getRef();
    var docRef = ref.doc();
    data.userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    data.id = docRef.id;
    return docRef.set(data);
  }

  static Future<void> deleteEvent(String id) {
    return getRef().doc(id).delete();
  }

  static Future<void> setFav(EventModel data) async {
    var ref = getRef();
    var docRef = ref.doc(data.id);
    return docRef.update({"isFav": !data.isFav ?? false});
  }

  static Stream<QuerySnapshot<EventModel>> getEvent([String? catId]) {
    var ref = catId == null || catId=="All"
        ? getRef().where("userID", isEqualTo:  FirebaseAuth.instance.currentUser!.uid)
        : getRef().where("categoryId", isEqualTo: catId);
    return ref.snapshots();
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getFavEvent() async {
    var ref = getRef();
    var docs = await ref.where("isFav", isEqualTo: true).get();
    return docs.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getAllEvents() {
    return getRef().snapshots();
  }
}
