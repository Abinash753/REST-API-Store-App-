import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/widgets/feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({super.key, required this.productList});
  final List<ProductsModel> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
            value: productList[index], child: const FeedWidget());
      },
    );
  }
}
