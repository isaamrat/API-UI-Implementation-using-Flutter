// ignore_for_file: camel_case_types, prefer_const_constructors, sort_child_properties_last

import 'package:api_ui_implementation/Pages/ApiPages/productDetailsPage.dart';
import 'package:api_ui_implementation/Controller/ApiController/services.dart';
import 'package:flutter/material.dart';

class myApiHomePage extends StatefulWidget {
  const myApiHomePage({super.key});

  @override
  State<myApiHomePage> createState() => _myApiHomePageState();
}

class _myApiHomePageState extends State<myApiHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);

    Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);

    Color textColor = Color.fromRGBO(123, 123, 123, 1);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appThemeTextColor,
        title: Text('Products From Api'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder(
          future:
              getProductList(), //This is returning the list of the products which were parsed from the json response in the services.dart file
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: snapshot
                        .data!.length, //Length of the list of the Products
                    itemBuilder: (context, index) {
                      final product = snapshot.data![
                          index]; //Saving each of the product object details in product variable
                      return GestureDetector(
                        onTap: () {
                          //This will take to the details page and sending the product object to that page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(product)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side:
                                  BorderSide(color: appThemeColor, width: 1.5)),
                          child: GridTile(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: Container(
                                      width: screenWidth * 0.3,
                                      height: 105,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          //If there is no image in the response data than it will show a dummy image
                                          image: (product.imagePath == null
                                              ? NetworkImage(
                                                  'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg')
                                              : NetworkImage(
                                                  'https://pqstec.com/invoiceapps/${product.imagePath}'))),
                                    )),
                                Text(product.name),//Accesing the product name
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${product.oldPrice}',//Accessing the product oldPrice
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          decorationThickness: 3.5),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '\$${product.price}',//Accessing the product price
                                      style: TextStyle(
                                          color: appThemeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                            //Footer of the cards of each Grid tile
                            footer: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: appThemeColor, width: 1.5),
                                    ),
                                    // color: Color.fromARGB(246, 89, 212, 96),
                                    color: Colors.white,
                                    // borderRadius: BorderRadius.vertical(
                                    //     bottom: Radius.circular(4))
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: appThemeColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ))),
                            ),
                          ),
                        ),
                      );
                    }),
              ));
            } else {
              //If the response doesn't provide any data then it will show circular progress indicator
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
