import 'package:carrots_lab_project/api/api.dart';
import 'package:carrots_lab_project/database/queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:provider/provider.dart';

class MapMain extends StatefulWidget {
  @override
  _MapMainState createState() {
    return new _MapMainState();
  }
}

class _MapMainState extends State<MapMain> {
  final MapController mapController = MapController();

  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Marker>>(
        future: getPlaces(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
              zoom: 13.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: snapshot.requireData),
            ],
            nonRotatedLayers: <LayerOptions>[
              LocationOptions(locationButton(),
                  onLocationUpdate: (LatLngData? ld) {
                latitude = ld!.location.latitude;
                longitude = ld!.location.longitude;
              },
                  onLocationRequested: (LatLngData? ld) {
                if (ld == null) {
                  return;
                }
                mapController.move(ld.location, 16.0);
              }, initiallyRequest: true),
            ],
            nonRotatedChildren: [
              temperatureWidget(),
            ],
          );
        });
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status, Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value, Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return Icon(
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

  Widget temperatureWidget() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: FutureBuilder<dynamic>(
            future: getActualTemperature(latitude, longitude),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              int temperatureKelvin = snapshot.data['main']['temp'].truncate();
              String temperature = (temperatureKelvin-273).toString() + "ºC";
              return Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
                ),
                child: Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(temperature, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                )
              );
            },
        )
    );
  }
}
