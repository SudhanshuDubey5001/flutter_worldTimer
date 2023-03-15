import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:worldtimerapp/Constants.dart';
import 'package:worldtimerapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //
  // //async code ---->
  // //lets say you are calling an API and need to wait for its result, lets simulate that with Future class
  // void getData() async{
  //
  //   String wait3 = await Future.delayed(Duration(seconds: 3), (){
  //     return 'retured string after 3 seconds';
  //   });
  //
  //   //with await keywords, it is going wait until that line of code has run then it will come back to next line
  //   print(wait3);
  //   //use it when your data like in print method depends on that line of code. Otherwise skipping that line will make a nullpointexception error
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   //the await keywords will work only for code written inside the getData method. Other lines of code outside the getData will run
  //   getData();
  //   //for example -
  //   print('heyoooo'); //this line of code will run and will not wait for the getData to complete.
  // }
  //
  //

  //how to call http request and get JSON data and parse it------------------------------>

  // void getData() async{
  //
  //   //to get data from API, store the data in ready made Response object by getting it from get(Uri) method--->
  //   Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  //   print(response.body);
  //
  //   //now just use jsonDecode method to convert JSON string into Map object! Simple!! :)
  //   Map data = jsonDecode(response.body);
  //   print(data['userId']);
  // }

  Constants CONSTANTS = Constants();

  String location = 'location';
  String flag = 'flag';
  String time = 'time';
  String isDayTime = 'isDayTime';

  Map location_endpoint_map = {};
  String location_endpoint = "";

  void setupDateTime() async {
    print('setting up date and time in loading screen');

    //receive the data first
    location_endpoint_map = ModalRoute.of(context)!.settings.arguments as Map;
    location_endpoint = location_endpoint_map['url_endpoint'];
    print('loading screen -> url endppint : ' + location_endpoint);

    WorldTimer worldTimer = WorldTimer(
        location: location_endpoint, url: location_endpoint, flag: 'UK.png');
    await worldTimer.getDateTime();
    print('Time of $location_endpoint -> ' + worldTimer.time);

    //now lets take the data to home screen and display it there. We will not use "pushNamed" because it will keep this screen
    // underneath it and we don't want to stack up this screen. So instead we will use pushReplacementNamed so that this screen
    //get destroyed once it goes to /home screen/ Got it? huh..tell me!!!
    //also we can pass on data using 3rd argument

    Navigator.pushReplacementNamed(context, CONSTANTS.home, arguments: {
      location: worldTimer.location,
      flag: worldTimer.flag,
      time: worldTimer.time,
      isDayTime: worldTimer.isDayTime
    });

    // //update the UI
    // setState(() {
    //   time = worldTimer.time;
    // });
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 80.0,
            ),
          ),
        ));
  }
}
