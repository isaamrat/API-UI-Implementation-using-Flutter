//This page will show the option of API Testing and UI Testing. 
//From here user can navigate to API Testing and UI Testing.

import 'package:api_ui_implementation/Pages/ApiPages/apiHomePage.dart';
import 'package:api_ui_implementation/Pages/splashScreen.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color appThemeColor = const Color.fromRGBO(68, 181, 80, 1);

    Color appThemeTextColor = const Color.fromRGBO(0, 143, 26, 1);

    Color textColor = const Color.fromRGBO(123, 123, 123, 1);

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.all(28.0),
            child: Image(image: AssetImage('Assets/appLogoNew.png')),
          ),
          Container(
            child: Column(
              children: [
                //Creating a button to take the user to the API Testing app.
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => myApiHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appThemeTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 80),
                    child: Text('API TEST'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Creating a button to take the user to the UI Testing app.
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appThemeTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 80),
                    child: Text('UI TEST'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
