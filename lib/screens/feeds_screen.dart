import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductsModel> productsList = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 5,
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : GridView.builder(

              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 0.6),
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: productsList[index], child: const FeedWidget());
              }),
    );
  }
}
