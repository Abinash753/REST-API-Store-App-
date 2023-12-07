import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<CategoriesModel>>(
        future: APIHandler.getAllCategories(target: 'categories'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error checking condition
          else if (snapshot.hasError) {
            Center(
              child: Text("An error occured ${snapshot.error}"),
            );
          }
          //if the  snapshot is empty
          else if (snapshot.data == null) {
            return const Center(
              child: Text("No products has been added yet"),
            );
          }

          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.2),
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const CategoryWidget());
              });
        }),
      ),
    );
  }
}
