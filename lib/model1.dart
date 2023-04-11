// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome1> welcomeFromJson(String str) => List<Welcome1>.from(json.decode(str).map((x) => Welcome1.fromJson(x)));

String welcome1ToJson(List<Welcome1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome1 {
  Welcome1({
    required this.recipeId,
    required this.categoryId,
    required this.title,
    required this.photoUrl,
    required this.photosArray,
    required this.time,
    required this.ingredients,
    required this.description,
  });

  int recipeId;
  int categoryId;
  String title;
  String photoUrl;
  List<String> photosArray;
  dynamic time;
  List<List<dynamic>> ingredients;
  String description;

  factory Welcome1.fromJson(Map<String, dynamic> json) => Welcome1(
    recipeId: json["recipeId"],
    categoryId: json["categoryId"],
    title: json["title"],
    photoUrl: json["photo_url"],
    photosArray: List<String>.from(json["photosArray"].map((x) => x)),
    time: json["time"],
    ingredients: List<List<dynamic>>.from(json["ingredients"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "recipeId": recipeId,
    "categoryId": categoryId,
    "title": title,
    "photo_url": photoUrl,
    "photosArray": List<dynamic>.from(photosArray.map((x) => x)),
    "time": time,
    "ingredients": List<dynamic>.from(ingredients.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "description": description,
  };
}
