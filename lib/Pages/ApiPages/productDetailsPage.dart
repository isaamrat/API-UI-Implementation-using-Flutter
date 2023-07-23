import 'package:api_ui_implementation/Model/ApiModel/apiResponseModel.dart';
import 'package:flutter/material.dart';

//This page will show the details of the individual products which was get from the api

class ProductDetails extends StatelessWidget {
  late ProductList productDetails;
  ProductDetails(ProductList product, {super.key}) {
    productDetails = product; //Storing the product object in the productDetails variable
  }

  @override
  Widget build(BuildContext context) {
    Color appThemeColor = Color.fromRGBO(68, 181, 80, 1);

    Color appThemeTextColor = Color.fromRGBO(0, 143, 26, 1);

    Color textColor = Color.fromRGBO(123, 123, 123, 1);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appThemeTextColor,
        title: Text('Product Details'),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: appThemeTextColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          //Showing image of the product and if there is no image than it will show a dummy image from the internet
                            fit: BoxFit.contain,
                            image: productDetails.imagePath == null
                                ? NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg')
                                : NetworkImage(
                                    'https://pqstec.com/invoiceapps/${productDetails.imagePath}')),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Details',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: appThemeTextColor),
                  ),
                ),
                //Creating a table consist of the details of a product
                Table(
                  border: TableBorder.all(color: appThemeTextColor, width: 1.5),
                  children: [
                    //Passing the details of the product using product object to the reusable function named tableRowProduct(), it will return a TableRow with the passed parameter
                    tableRowProduct('Id', '${productDetails.id}'),
                    tableRowProduct('Name', '${productDetails.name}'),
                    tableRowProduct(
                        'Description', '${productDetails.description}'),
                    tableRowProduct('Code', '${productDetails.code}'),
                    tableRowProduct(
                        'Cost Price', '${productDetails.costPrice}'),
                    tableRowProduct('Old Price', '${productDetails.oldPrice}'),
                    tableRowProduct('Unit Name', '${productDetails.unitName}'),
                    tableRowProduct(
                        'Brand Name', '${productDetails.brandName}'),
                    tableRowProduct(
                        'Model Name', '${productDetails.modelName}'),
                    tableRowProduct(
                        'Color Name', '${productDetails.colorName}'),
                    tableRowProduct(
                        'Product Bar Code', '${productDetails.productBarcode}'),
                    tableRowProduct(
                        'Current Stock', '${productDetails.currentStock}'),
                    tableRowProduct(
                        'Create Date', '${productDetails.createDate}'),
                    tableRowProduct(
                        'Update Date', '${productDetails.updateDate}'),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  //Creating method to reuse so that I don't need to write this code again and again
  TableRow tableRowProduct(String title, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ]);
  }
}
