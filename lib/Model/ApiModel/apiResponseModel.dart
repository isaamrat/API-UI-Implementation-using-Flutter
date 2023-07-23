import 'dart:convert';


//Creating this Model Class to parse the response json data to object data
ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
    int success;
    bool error;
    List<ProductList> productList;
    PageInfo pageInfo;

    ApiResponse({
        required this.success,
        required this.error,
        required this.productList,
        required this.pageInfo,
    });

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["Success"],
        error: json["error"],
        productList: List<ProductList>.from(json["ProductList"].map((x) => ProductList.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["PageInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "Success": success,
        "error": error,
        "ProductList": List<dynamic>.from(productList.map((x) => x.toJson())),
        "PageInfo": pageInfo.toJson(),
    };
}

class PageInfo {
    int pageNo;
    int pageSize;
    int pageCount;
    int totalRecordCount;

    PageInfo({
        required this.pageNo,
        required this.pageSize,
        required this.pageCount,
        required this.totalRecordCount,
    });

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        pageNo: json["PageNo"],
        pageSize: json["PageSize"],
        pageCount: json["PageCount"],
        totalRecordCount: json["TotalRecordCount"],
    );

    Map<String, dynamic> toJson() => {
        "PageNo": pageNo,
        "PageSize": pageSize,
        "PageCount": pageCount,
        "TotalRecordCount": totalRecordCount,
    };
}

class ProductList {
    int id;
    dynamic type;
    dynamic parentCode;
    String name;
    String code;
    double price;
    double costPrice;
    String unitName;
    CategoryName categoryName;
    String brandName;
    String modelName;
    String variantName;
    String sizeName;
    String colorName;
    double oldPrice;
    String? imagePath;
    String productBarcode;
    String description;
    List<dynamic> childList;
    List<BatchSerial> batchSerial;
    List<dynamic> warehouseList;
    double currentStock;
    String createDate;
    String updateDate;

    ProductList({
        required this.id,
        this.type,
        this.parentCode,
        required this.name,
        required this.code,
        required this.price,
        required this.costPrice,
        required this.unitName,
        required this.categoryName,
        required this.brandName,
        required this.modelName,
        required this.variantName,
        required this.sizeName,
        required this.colorName,
        required this.oldPrice,
        this.imagePath,
        required this.productBarcode,
        required this.description,
        required this.childList,
        required this.batchSerial,
        required this.warehouseList,
        required this.currentStock,
        required this.createDate,
        required this.updateDate,
    });

    factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["Id"],
        type: json["Type"],
        parentCode: json["ParentCode"],
        name: json["Name"],
        code: json["Code"],
        price: json["Price"],
        costPrice: json["CostPrice"],
        unitName: json["UnitName"]!,
        categoryName: categoryNameValues.map[json["CategoryName"]]!,
        brandName: json["BrandName"]!,
        modelName: json["ModelName"],
        variantName: json["VariantName"],
        sizeName: json["SizeName"],
        colorName: json["ColorName"],
        oldPrice: json["OldPrice"],
        imagePath: json["ImagePath"],
        productBarcode: json["ProductBarcode"],
        description: json["Description"],
        childList: List<dynamic>.from(json["ChildList"].map((x) => x)),
        batchSerial: List<BatchSerial>.from(json["BatchSerial"].map((x) => BatchSerial.fromJson(x))),
        warehouseList: List<dynamic>.from(json["WarehouseList"].map((x) => x)),
        currentStock: json["CurrentStock"],
        createDate: json["CreateDate"],
        updateDate: json["UpdateDate"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type,
        "ParentCode": parentCode,
        "Name": name,
        "Code": code,
        "Price": price,
        "CostPrice": costPrice,
        "UnitName": unitName,
        "CategoryName": categoryNameValues.reverse[categoryName],
        "BrandName": brandName,
        "ModelName": modelName,
        "VariantName": variantName,
        "SizeName": sizeName,
        "ColorName": colorName,
        "OldPrice": oldPrice,
        "ImagePath": imagePath,
        "ProductBarcode": productBarcode,
        "Description": description,
        "ChildList": List<dynamic>.from(childList.map((x) => x)),
        "BatchSerial": List<dynamic>.from(batchSerial.map((x) => x.toJson())),
        "WarehouseList": List<dynamic>.from(warehouseList.map((x) => x)),
        "CurrentStock": currentStock,
        "CreateDate": createDate,
        "UpdateDate": updateDate,
    };
}

class BatchSerial {
    String batchSerialNo;
    int batchQty;
    double amount;
    String purchaseDate;
    SupplierName supplierName;

    BatchSerial({
        required this.batchSerialNo,
        required this.batchQty,
        required this.amount,
        required this.purchaseDate,
        required this.supplierName,
    });

    factory BatchSerial.fromJson(Map<String, dynamic> json) => BatchSerial(
        batchSerialNo: json["BatchSerialNo"],
        batchQty: json["BatchQty"],
        amount: json["Amount"],
        purchaseDate: json["PurchaseDate"],
        supplierName: supplierNameValues.map[json["SupplierName"]]!,
    );

    Map<String, dynamic> toJson() => {
        "BatchSerialNo": batchSerialNo,
        "BatchQty": batchQty,
        "Amount": amount,
        "PurchaseDate": purchaseDate,
        "SupplierName": supplierNameValues.reverse[supplierName],
    };
}

enum SupplierName { CASH_SUPPLIER, CASH_SUPPLIER_RUBAYET_FAHAD, CASH_SUPPLIER_WALK_IN_CUSTOMER_RUBAYET }

final supplierNameValues = EnumValues({
    "Cash Supplier": SupplierName.CASH_SUPPLIER,
    "Cash Supplier - Rubayet Fahad": SupplierName.CASH_SUPPLIER_RUBAYET_FAHAD,
    "Cash Supplier - Walk in Customer - Rubayet": SupplierName.CASH_SUPPLIER_WALK_IN_CUSTOMER_RUBAYET
});



enum CategoryName { N_A, ELECTRONICS, CEMENT }

final categoryNameValues = EnumValues({
    "Cement": CategoryName.CEMENT,
    "Electronics": CategoryName.ELECTRONICS,
    "=N/A=": CategoryName.N_A
});


class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
