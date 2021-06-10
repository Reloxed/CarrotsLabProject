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
    return new Scaffold(
      appBar: AppBar(
        title: Text("Carrots Lab Map", style: Theme.of(context).textTheme.headline1),
      ),
      body: FlutterMap(
        options: new MapOptions(
          center: new LatLng(37.285427171289975, -5.910435014322033),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 200.0,
                height: 200.0,
                point: new LatLng(37.285427171289975, -5.910435014322033),
                builder: (ctx) => new Container(
                  child: new Icon(
                    Icons.push_pin,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        items: [BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
        BottomNavigationBarItem(icon: Icon(Icons.push_pin), label: "Lugares")],
      ),
    );
  }
}