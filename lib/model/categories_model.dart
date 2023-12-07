import 'package:flutter/material.dart';

class CategoriesModel with ChangeNotifier {
  int? id;
  String? name;
  String? image;
  // String? creationAt;
  // String? updatedAt;

  CategoriesModel({
    this.id,
    this.name,
    this.image,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    // creationAt = json['creationAt'];
    // updatedAt = json['updatedAt'];
  }
  static List<CategoriesModel> categoriesFromJson(List productSnapshot) {
    return productSnapshot.map((data) {
      // print("data $data");
      return CategoriesModel.fromJson(data);
    }).toList();
  }
}
