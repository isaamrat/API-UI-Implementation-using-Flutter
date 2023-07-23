import 'dart:convert';


//Creating this Model class to parse the json data of categories of products along with products
UbazarProductDataModel ubazarProductDataModelFromJson(String str) => UbazarProductDataModel.fromJson(json.decode(str));

String ubazarProductDataModelToJson(UbazarProductDataModel data) => json.encode(data.toJson());

class UbazarProductDataModel {
    List<ProductList> productList;

    UbazarProductDataModel({
        required this.productList,
    });

    factory UbazarProductDataModel.fromJson(Map<String, dynamic> json) => UbazarProductDataModel(
        productList: List<ProductList>.from(json["ProductList"].map((x) => ProductList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ProductList": List<dynamic>.from(productList.map((x) => x.toJson())),
    };
}

class ProductList {
    String categoryName;
    String info;
    String categoryImage;
    List<Product>? products;

    ProductList({
        required this.categoryName,
        required this.info,
        required this.categoryImage,
        this.products,
    });

    factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        categoryName: json["CategoryName"],
        info: json["Info"],
        categoryImage: json["CategoryImage"],
        products: json["Products"] == null ? [] : List<Product>.from(json["Products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CategoryName": categoryName,
        "Info": info,
        "CategoryImage": categoryImage,
        "Products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    String name;
    int id;
    int oldPrice;
    int price;
    String productImage;

    Product({
        required this.name,
        required this.id,
        required this.oldPrice,
        required this.price,
        required this.productImage,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        id: json["pid"],
        oldPrice: json["oldPrice"],
        price: json["price"],
        productImage: json["productImage"]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id":id,
        "oldPrice": oldPrice,
        "price": price,
        "productImage": productImage,
    };
}



