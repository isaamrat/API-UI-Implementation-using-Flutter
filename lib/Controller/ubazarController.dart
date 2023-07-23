import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:api_ui_implementation/Model/ubazarDataModel.dart';

//This function will return the list of the categories of products along with products list store in the json
Future<List<ProductList>> getProductList(BuildContext context) async {
  final assetBundle = DefaultAssetBundle.of(context);
  String jsonString = await assetBundle.loadString('Assets/data/productData.json');//loading the json data to the jsonString variable
 
  UbazarProductDataModel ubazarData = UbazarProductDataModel.fromJson(jsonDecode(jsonString)); //Parsing the json data to category of product model using the UbazarProductDataModel
  return ubazarData.productList;
}