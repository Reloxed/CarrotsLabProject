import 'package:carrots_lab_project/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void uploadPlace(String name, double latitude, double longitude) async {
  Place place = new Place(name, longitude, latitude);
  await FirebaseFirestore.instance
      .collection("places")
      .add(place.placeToJson());
}