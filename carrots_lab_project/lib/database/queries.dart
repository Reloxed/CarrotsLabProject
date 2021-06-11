import 'package:carrots_lab_project/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Place>> getPlaces() async {
  List<Place> places = [];
  await FirebaseFirestore.instance
      .collection("places")
      .get()
      .then((placesQuery) => placesQuery.docs.forEach((element) {
        Place place = Place.placeFromMap(element.data());
        places.add(place);
  }));
  return places;
}