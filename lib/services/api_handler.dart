import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/consts/api_consts.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/model/user_model.dart';

class APIHandler {
  static Future<List<dynamic>> getData({
    required String target,
  }) async {
    try {
      var uri = Uri.https(
        BASE_URL,
        "api/v1/$target",
      );

      var response = await http.get(uri);
      //print("response :---- ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      //response error message
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }
      return tempList;
    } catch (e) {
      print("Exception occured: $e");
      throw e.toString();
      // return [];
    }
  }

  //for product
  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getData(
      target: "products",
    );
    return ProductsModel.productsFromJson(temp);
  }

  //for categories
  static Future<List<CategoriesModel>> getAllCategories(
      {required String target}) async {
    List temp = await getData(target: "categories");
    return CategoriesModel.categoriesFromJson(temp);
  }

  //for users
  static Future<List<UserModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    return UserModel.usersFromJson(temp);
  }

  //getting product details
  static Future<Object> getProductById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri);
      //print("response :---- ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      return ProductsModel.fromJson(data);
    } catch (e) {
      print("An error occured while getting product info $e");
      throw e.toString();
    }
  }
}
