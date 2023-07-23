import 'package:flutter/material.dart';
import 'package:api_ui_implementation/Pages/homePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//This page will show all the onboarding pages

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({super.key});

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  //Creating a _controller variable to keep the track of the onboard pages
  final _controller = PageController();
  Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);
  Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);
  Color textColor = Color.fromRGBO(123, 123, 123, 1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: SafeArea(
          child: PageView(//This widget will contain three pages of the onbording
            controller: _controller,
            children: [
              OnBoardingPagesContainers(false, true, 'Assets/ubazarLogo.png',
                  'Welcome to', 'Application', 'Assets/welcomeGraphic.png'),
              OnBoardingPagesContainers(true, false, 'Fast', 'Get',
                  'Delivery Service', 'Assets/deliveryPageGraphic.png'),
              OnBoardingPagesContainers(true, false, 'Grocery', 'Best Quality',
                  'Door to Door', 'Assets/bestQualityPageGraphic3.png'),
            ],
          ),
        ),
      ),
      //Taking bottomSheet to show the skip button and page indicator
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //Creating a button to skip to home page of the ui app
          TextButton(
              onPressed: () {
                //Here usign pushReplacement to replace the onboarding page with the home page
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                'Skip',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w400),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            //Using SmoothPageIndicator from smooth_page_indicator package to give the effect and customization to the page indicator
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                expansionFactor: 2,
                activeDotColor: appThemeColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }


  //Creating a method to reuse while building contents for each of the onboarding page. Here all the necessary parameters is going to be transfered and it will show those based on that.
  Container OnBoardingPagesContainers(
      bool firstLineCenter,
      bool logoImageGiven,
      String greenText,
      String FirstLine,
      String SecondLine,
      String centerImagePath) {
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 32),
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              (firstLineCenter
                  ? Center(
                      child: Text(
                        FirstLine,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  : Text(
                      FirstLine,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 36,
                          fontWeight: FontWeight.w300),
                    )),
              Row(
                children: [
                  (logoImageGiven
                      ? Image(image: AssetImage(greenText))
                      : Text(
                          greenText,
                          style: TextStyle(
                              color: appThemeTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        )),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    SecondLine,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w300),
                  )
                ],
              )
            ]),
          ),
        ),
        SizedBox(
          height: 94,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Image(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              image: AssetImage(centerImagePath)),
        ),
      ]),
    );
  }
}
