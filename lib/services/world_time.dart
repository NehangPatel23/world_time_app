import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  late String time; // Time at the location
  String flag; // URL to an asset flag icon
  String url; // Location URL for API endpoints
  late bool isDaytime; // Boolean to check whether it is day/night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // Make the HTTP Request to the worldtime API
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      // Get the necessary properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // Create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.subtract(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error - $e');
      time = 'Could not get time data!';
    }
  }
}
