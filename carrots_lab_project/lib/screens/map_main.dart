import 'package:carrots_lab_project/database/queries.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapMain extends StatefulWidget {
  @override
  _MapMainState createState() {
    return new _MapMainState();
  }
}

class _MapMainState extends State<MapMain> {

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Marker>>(
        future: getPlaces(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return FlutterMap(
            options: new MapOptions(
              center: new LatLng(37.285427171289975, -5.910435014322033),
              zoom: 13.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: snapshot.requireData),
            ],
          );
        });
  }
}
