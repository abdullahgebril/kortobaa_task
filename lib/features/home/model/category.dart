import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Category> categories;

  CategoryModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        categories: List<Category>.from(
            json["results"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  String imageLink;

  Category({
    required this.id,
    required this.name,
    required this.imageLink,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
