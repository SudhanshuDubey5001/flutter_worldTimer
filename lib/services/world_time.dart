import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTimer {
  String location = ""; //to know which location we want the time of
  String url = ""; //url endpoint of location
  String flag = ""; //flag icon of the country/location
  String time = ""; //time of that place
  bool isDayTime =
      true; //to know if its day or night so we can change the background

  WorldTimer({required this.location, required this.url, required this.flag});

  //now lets create the worldTimer by calling their API ------>
  //because this method is async, we need to make it Future<void> because when we call the method we need to use "await" keyword
  // because we don't want to skip over the method and call something that hasn't been arrived yet. And in order to use await keyword
  // we need to make this method with Future placeholder
  Future<void> getDateTime() async {
    //because we are going to call API and it can cause error because of URl link mistakes etc. we are going to wrap it around
    //try and catch
    try {
      //make the request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      //parse the response
      Map data = jsonDecode(response.body);

      print(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      offset = offset.substring(1, 3);

      print(dateTime);
      print(offset);

      //correct the dateTime by adding the offset
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time to now
      time = now.toString();

      //tidy up the date time by using package intl
      time = DateFormat.jm().format(now);

      //check if its day or night (after 6am and before 8pm)
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

    } catch (e) {
      print('error: ' + e.toString());
      time = 'could not get time because ' + e.toString();
    }
  }
}
