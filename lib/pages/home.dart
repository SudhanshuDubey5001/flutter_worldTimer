import 'package:flutter/material.dart';
import 'package:worldtimerapp/Constants.dart';
import 'package:worldtimerapp/pages/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  Map dataReceived = {};
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {

    //use ModalRoute to access the sent data. "!" is used to check if it is not null. "as Map" is used because it returns an object
    //and we need a Map (also we are sending a Map so we know its a Map. What is it? its a MAP!!! MAAAAAAAP)
    //also we do not need to wrap it in setState because this is the first line of build function and therefore it is already loaded
    //before building the Scaffold below
    dataReceived = ModalRoute.of(context)!.settings.arguments as Map;
    print('Data received -> '+ dataReceived.toString());

    //setup the image
    String bgImage = dataReceived['isDayTime']? 'day.png': 'night.png';
    //setup the top color
    Color bgColor = dataReceived['isDayTime']? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/'+bgImage),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      Navigator.pushReplacementNamed(context, constants.chooseLocation);

                      //another way to do it --->
                      //use pushNamed so that this screen is underneath and also make this method async cuz we use await
                      dynamic result = await Navigator.pushNamed(context, constants.chooseLocation);
                      // we will get the data in result because we use pop() method there to send arguments.
                      //pop() simply means the screen gets destroyed and underneath screen shows.
                      //then call the setState to update the UI

                      // setState(() {
                      //   dataReceived = {
                      //     'location': result['location'],
                      //     'flag': result['flag'],
                      //     'time': result['time'],
                      //     'isDayTime': result['isDayTime'],
                      //   };
                      //
                      // });
                    },
                    child: Text('Choose Location'),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dataReceived['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  dataReceived['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
