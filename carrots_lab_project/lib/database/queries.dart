import 'package:carrots_lab_project/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Future<List<Marker>> getPlaces(BuildContext context) async {
  List<Place> _places = [];
  List<Marker> _markers = [];
  await FirebaseFirestore.instance
      .collection("places")
      .get()
      .then((placesQuery) => placesQuery.docs.forEach((element) {
        Place place = Place.placeFromMap(element.data());
        _places.add(place);
        for(Place item in _places) {
          Marker marker = new Marker(
            width: 200.0,
            height: 200.0,
            point: new LatLng(item.latitude, item.longitude),
            builder: (ctx) =>
                  Icon(
                    Icons.push_pin,
                    color: Theme.of(context).accentColor,
                    size: 30.0,
                  ),
            );
          _markers.add(marker);
        }
  }));
  return _markers;
}