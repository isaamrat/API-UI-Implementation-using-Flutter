// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:api_ui_implementation/Controller/ubazarController.dart';
import 'package:api_ui_implementation/Model/ubazarDataModel.dart';
import 'package:api_ui_implementation/Pages/categoryPage.dart';

//This will show the Home Page of teh UBazar app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);

  Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);

  Color textColor = Color.fromRGBO(123, 123, 123, 1);


  late Future<List<ProductList>> productFuture;//Declaring list of Categories of products. Here I am using late so that I can assign value later.

  @override
  void initState() {
    super.initState();
    //Here I am overriding the initState() to assign the value to the productFuture variable to use in the widget building.
    productFuture = getProductList(context);//Here called the getProductList() function to get the list of the categories of the products along with products.
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
                width: 32,
                image: AssetImage('Assets/appBarIcons/menuWhiteBar.png')),
          ),
          actions: [
            Icon(
              Icons.search,
              size: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 22.0, left: 8),
              child: Image(
                  width: 32,
                  image: AssetImage('Assets/appBarIcons/appBarCartWhite.png')),
            )
          ],
          centerTitle: true,
          title: Container(
              height: 28,
              child:
                  Image(image: AssetImage('Assets/appBarIcons/logoWhite.png'))),
          backgroundColor: appThemeTextColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              //Creating a sized box to accomodate the image slider of the top
              child: SizedBox(
                height: 140,
                width: double.infinity,
                //Here I am using AnotherCarousel() widget from another_carousel_pro package.
                child: AnotherCarousel(
                    radius: const Radius.circular(10),
                    dotBgColor: Colors.transparent,
                    dotSize: 6,
                    dotColor: textColor,
                    dotIncreaseSize: 1.2,
                    dotVerticalPadding: 9,
                    dotSpacing: 10,
                    dotIncreasedColor: Colors.white,
                    indicatorBgPadding: 0,
                    autoplay: false,
                    boxFit: BoxFit.fitWidth,
                    images: [
                      AssetImage('Assets/homePagePics/featurePic.png'),
                      AssetImage('Assets/homePagePics/featurePic.png'),
                      AssetImage('Assets/homePagePics/featurePic.png'),
                      AssetImage('Assets/homePagePics/featurePic.png'),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              //Here I am creating rows cosist of the four categories of the UBazar app.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Here I have created a method named featureCategoryCards. This will help me to create identical cards of categories with different values in it by transfering the parameters.
                  featureCategoryCards('Assets/featureCategory/All.png', 'All',
                      appThemeColor, Colors.transparent),
                  featureCategoryCards('Assets/featureCategory/fruits.png',
                      'Fruits', textColor, Colors.transparent),
                  featureCategoryCards('Assets/featureCategory/vegetables.png',
                      'Vegetables', textColor, Colors.blue),
                  featureCategoryCards('Assets/featureCategory/fish.png',
                      'Fish', textColor, Colors.transparent),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //This section will consist the list of the categories of the app. By taping on any category user can see the products of that category.
            Expanded(
              child: FutureBuilder(
                  future: productFuture, //Here productFuture was stored in the initState
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      //Here if the json data does not consist any data then it will show a circular progress indicator
                      return Center(child: CircularProgressIndicator());
                    } else {
                      //By gettig the data it will build list of categories.
                      return ListView.builder(
                          itemCount: snapshot.data!.length, //Giving the length of the categories
                          itemBuilder: (context, index) {
                            ProductList product = snapshot.data![index]; //Taking individual categries in the product variable
                            return Column(
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                //Here I am taking GestureDetector() widget to detect any tap of the user.
                                //After taping on any of the category tile it will take the user to the category page, where user will be able to see the products of that category.
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoryPage(
                                      product//Transfering the selected category object to Category Page
                                    )));
                                  },
                                  //This container consist of the image, name and details of a category.
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                4), 
                                          ),
                                        ]
                                        ),
                                    child: ListTile(
                                      subtitle: Text(product.info),
                                      leading: Image(
                                          height: 72,
                                          width: 72,
                                          fit: BoxFit.fitWidth,
                                          image:
                                              AssetImage(product.categoryImage)),
                                      title: Text(product.categoryName),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: appThemeTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                )
                              ],
                            );
                          });
                    }
                  }),
            )
          ],
        ),
        //I am creating Bottom Navigation Bar
        bottomNavigationBar: Material(
          elevation: 28,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: appThemeColor,
            items: [
              BottomNavigationBarItem(
                  icon: Image(
                      image: AssetImage('Assets/bottomBarIcons/bottomHome.png')),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image(
                      image: AssetImage('Assets/bottomBarIcons/bottomCart.png')),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Image(
                      image: AssetImage('Assets/bottomBarIcons/bottomFav.png')),
                  label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Image(
                      image:
                          AssetImage('Assets/bottomBarIcons/bottomProfile.png')),
                  label: 'Me')
            ],
          ),
        )
        
        );
  }

  //Reusable widget function
  Column featureCategoryCards(String imagePath, String categoryName,
      Color categoryNameColor, Color borderColor) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(-1, 4),
                  blurRadius: 12,
                  spreadRadius: 0.5),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(1, -4),
                  blurRadius: 12,
                  spreadRadius: 0.5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage(imagePath)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          categoryName,
          style: TextStyle(color: categoryNameColor),
        )
      ],
    );
  }
}
