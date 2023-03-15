import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:worldtimerapp/Constants.dart';
import 'package:worldtimerapp/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  // List<WorldTimer> locations = [
  //   WorldTimer(url: 'Europe/London', location: 'London', flag: 'uk.png'),
  //   WorldTimer(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
  //   WorldTimer(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
  //   WorldTimer(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
  //   WorldTimer(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
  //   WorldTimer(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
  //   WorldTimer(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
  //   WorldTimer(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  // ];
  //
  //

  List locationArray = [];
  String url_endpoint = "";
  Constants constants = Constants();

  //get all locations
  void getAllLocations() async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
    print('Locations = ' + response.body);
    locationArray = jsonDecode(response.body);
    setState(() {});
  }

  void updateTime(index){
    // WorldTimer worldTimer = locationArray[index];
    url_endpoint = locationArray[index].toString();
    Navigator.pushReplacementNamed(context, constants.loading, arguments: {
      'url_endpoint' : url_endpoint
    });
  }

  @override
  void initState(){
    super.initState();
  }


  //since getALlLocations() method is async, it is getting skipped and then build method is making the widgets before
  //we have the locations and we cannot use "await" here cuz we cannot make init method aysnc. So to resolve that,
  // we use this method which runs whenever the dependencies involved like "locations" updates and its also run after
  // the initState.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Location'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locationArray.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 10.0,
              child: ListTile(
                onTap: () {
                  print(locationArray[index]);
                  updateTime(index);
                },
                title: Text(locationArray[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
