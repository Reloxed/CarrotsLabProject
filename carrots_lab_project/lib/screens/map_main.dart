import 'package:carrots_lab_project/database/queries.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';

class MapMain extends StatefulWidget {
  @override
  _MapMainState createState() {
    return new _MapMainState();
  }
}

class _MapMainState extends State<MapMain> {
  final MapController mapController = MapController();

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
            mapController: mapController,
            options: new MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              plugins: [
                LocationPlugin(),
              ],
              center: new LatLng(37.285427171289975, -5.910435014322033),
              zoom: 13.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: snapshot.requireData),
            ],
            nonRotatedLayers: <LayerOptions>[
              // USAGE NOTE 3: Add the options for the plugin
              LocationOptions(
                locationButton(),
                onLocationRequested: (LatLngData? ld) {
                  if (ld == null) {
                    return;
                  }
                  mapController.move(ld.location, 16.0);
                },
              ),
            ],
          );
        });
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
