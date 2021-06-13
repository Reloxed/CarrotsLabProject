import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getActualTemperature(double latitude, double longitude) async {
  String apiKey = "ac8e3422e507fa6c5994fa95f3dd8e96";
  var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=" + latitude.toString()
      + "&lon=" + longitude.toString() + "&appid=" + apiKey);

  var response = await http.get(url);

  return jsonDecode(response.body);
}