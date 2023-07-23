// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors

//This page will show the products of a category
import 'package:flutter/material.dart';
import 'package:api_ui_implementation/Model/ubazarDataModel.dart';

class CategoryPage extends StatefulWidget {
  //Instantiating categoryProducts which will contain details of category and list of product of that category
  late ProductList categoryProduts;
  late List<bool> favProdList = [];
  late List<int> productIds = [];


  //Instantiating favProductDict to keep the track of the favorite products
  late Map<int, bool> favProductDict;
  //Instantiating productCartAdded to keep the track of the products added to cart
  late Map<int, int> productCartAdded;
  CategoryPage(ProductList pd, {super.key}) {
    categoryProduts = pd;//Receiving the category object and keeping it in the variable
    //Here filling favProductDict with false value and productCartAdded with value 0
    if (categoryProduts.products != null) {
      for (var i = 0; i < categoryProduts.products!.length; i++) {
        productIds.add(categoryProduts.products![i].id);
      }
      favProductDict = {for (var item in productIds) item: false};
      productCartAdded = {for (var item in productIds) item: 0};
    }
  }

  //creating a get function to get the favProductDict
  Map<int, bool> getFavProductDict() {
    return favProductDict;
  }

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);

    Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);

    Color textColor = Color.fromRGBO(123, 123, 123, 1);

    //creating sum variable to keep the count of total number of product added to cart
    int sum = widget.productCartAdded.values
        .reduce((value, element) => value + element);

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0, left: 8),
              //Creating a stack consist of total added product number and cart icon
              child: Stack(children: [
                Image(
                    width: 32,
                    image:
                        AssetImage('Assets/appBarIcons/appBarCartWhite.png')),
                Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Center(
                      child: Text(
                        '$sum',
                        style: TextStyle(
                          color: appThemeTextColor,
                        ),
                      ),
                    )),
              ]),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          widget.categoryProduts.categoryName,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: appThemeTextColor,
      ),
      // backgroundColor: Colors.pink,
      body: Column(
        children: [
          Material(
            elevation: 4,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Getting how many products are there in the category
                      widget.categoryProduts.products != null
                          ? Text(
                              '${widget.categoryProduts.products!.length} Products Founds',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400),
                            )
                          : Text(
                              '0 Products Founds',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400),
                            ),
                      Image(
                          image:
                              AssetImage('Assets/appBarIcons/filterIcon.png'))
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              //Creating grids consist of products
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: widget.categoryProduts.products!.length,//Giving how many products are there
                  itemBuilder: (context, index) {
                    final product = widget.categoryProduts.products![index];//Getting individual products
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(color: Colors.green, width: 1.5)),
                      child: Stack(children: [
                        GridTile(
                          child: Column(
                            children: [
                              //Showing product image from product object
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: Container(
                                    height: 105,
                                    child: Image(
                                        width: screenWidth * 0.3,
                                        height: 125,
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                            product.productImage.toString())),
                                  )),
                                  //showing product name
                              Text(product.name),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //showing old price of the product with red lineThrough
                                  Text(
                                    '\$${product.oldPrice}',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 3.5),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  //showing current price of the product
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          footer: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.green, width: 1.5),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  //Checking if a product added to cart or not. if added it will show add and remove button to increase or decrease the quantity.
                                  child: widget.productCartAdded[product.id]! >
                                          0
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                          color: Colors.green,
                                                          width: 1.5),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  //Creating decrement button for a product. By clicking here user can remove item from the cart. and also can decrease the quantiy
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        widget.productCartAdded[
                                                                product.id] =
                                                            widget.productCartAdded[
                                                                    product
                                                                        .id]! -
                                                                1;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7.0),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            appThemeTextColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(
                                                  '${widget.productCartAdded[product.id]}',
                                                  style: TextStyle(
                                                      color: appThemeTextColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        color: Colors.green,
                                                        width: 1.5),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                //Creating increment button so that user can increment the quantity of the product in the cart.
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      widget.productCartAdded[
                                                              product.id] =
                                                          widget.productCartAdded[
                                                                  product.id]! +
                                                              1;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: appThemeTextColor,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : 
                                      //Creating gesture detector to add a product to cart
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              //Adding a product to cart and changing the state
                                              widget.productCartAdded[
                                                      product.id] =
                                                  widget.productCartAdded[
                                                          product.id]! +
                                                      1;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                  color: appThemeTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                ))),
                          ),
                        ),
                        //Here giving the favorite button. By clicking here user can mark a product as favorite. Based on that the color of the favorite icon will change.
                        Positioned(
                            top: 8,
                            left: screenWidth * 0.37,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  //Here the products which is added or removed from favorite will be tracked.
                                  widget.favProductDict[product.id] =
                                      !widget.favProductDict[product.id]!;
                                });
                              },
                              child: (widget.favProductDict[product.id] == true
                                  ? Icon(
                                      Icons.favorite,
                                      color: appThemeColor,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: textColor,
                                    )),
                            ))
                      ]),
                    );
                  }),
            ),
          ),
        ],
      ),
      //Creating the bottom navigation bar
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
      ),
    );
  }
}
