import 'dart:convert';

import '../../Model/ApiModel/apiResponseModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const apiUrl = "https://pqstec.com/invoiceapps/Values/GetProductList";//API link
  final api_token = dotenv.env['api_token']; //Accessing the token value from the .env file, so that the value doesn't get disclosed.
  
  //Creating this function to get the json response from the api using http request with token
  Future<Map<String, dynamic>> fetchData() async{
  final response = await http.get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $api_token'});//http request
  Map<String,dynamic> jsonApi = json.decode(response.body);//Decoding the json response
  return jsonApi;
}

//Creating this function to map the json data to object model and returning the list of the objects
Future<List<ProductList>> getProductList() async{
  Map<String, dynamic> jsonData = await fetchData();
  ApiResponse apiResponseData = ApiResponse.fromJson(jsonData);//Getting the ApiResponse object using fromJson() of ApiResponse
  return apiResponseData.productList;
}
