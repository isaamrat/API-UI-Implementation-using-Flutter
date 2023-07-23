import 'package:flutter/material.dart';
import 'package:api_ui_implementation/Pages/onBoardingPage.dart';

//This page will show the splash screen consisting the logo of the UBazar
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);

  Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);

  //This function will keep the page for 3 seconds, after that it will take to the onboaring page
  Future.delayed(Duration(seconds: 3), () {
      // Navigate to the onboarding page after the delay
      // Here it will replace the page with the next page, so that it does not show up again by pressing the back button
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onBoardingPage()),
      );
    });

    return Scaffold(
      backgroundColor: appThemeTextColor,
      body: Center(child: Image(image: AssetImage('Assets/logoBig.png'),),),
    );
  }
}