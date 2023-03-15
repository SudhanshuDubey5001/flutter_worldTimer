import 'package:flutter/material.dart';
import 'package:worldtimerapp/Constants.dart';
import 'package:worldtimerapp/pages/choose_location.dart';
import 'package:worldtimerapp/pages/home.dart';
import 'package:worldtimerapp/pages/loading.dart';

void main() {

  Constants constants = Constants();

  runApp(MaterialApp(
      // initial screen
      initialRoute: '/location',
      //to go from one screen to another we use routes. "context" -> so that widget knows where they are in the widget tree
      routes:{
        constants.chooseLocation: (context) => ChooseLocation(),
        constants.loading: (context) => Loading(),
        constants.home: (context) => Home(),
          }
        )
    );
}
