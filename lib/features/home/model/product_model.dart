import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class ProductModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Product> products;

  ProductModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        products:
            List<Product>.from(json["results"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  int id;
  String name;
  String imageLink;
  String price;
  String description;
  String rate;
  Categoryitem category;
  bool isFavourite;
  // Cart values
  int cartRequestedQuantity = 1;
  bool isAddedToCart;

  Product(
      {required this.id,
      required this.name,
      required this.imageLink,
      required this.price,
      required this.description,
      required this.rate,
      required this.category,
      this.isFavourite = false,
      this.isAddedToCart = false});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        price: json["price"],
        description: json["description"],
        rate: json["rate"],
        category: Categoryitem.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "price": price,
        "description": description,
        "rate": rate,
        "category": category.toJson(),
      };
}

class Categoryitem {
  int id;
  String name;
  String imageLink;

  Categoryitem({
    required this.id,
    required this.name,
    required this.imageLink,
  });

  factory Categoryitem.fromJson(Map<String, dynamic> json) => Categoryitem(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
      };
}
