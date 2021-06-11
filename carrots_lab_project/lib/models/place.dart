class Place {
  late String name;
  late double longitude;
  late double latitude;

  Place(String name, double longitude, double latitude){
    this.name = name;
    this.longitude = longitude;
    this.latitude = latitude;
  }

  static placeFromMap(Map <String, dynamic> map){
    return new Place(map['name'], map['longitude'], map['latitude']);
  }

  Map<String, dynamic> placeToJson() => {
    "name": name,
    "longitude": longitude,
    "latitude": latitude
  };
}