import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/screens/feeds_screen.dart';
import 'package:store_app/screens/product_details.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    //initiliaze the provider sftate management
    final ProductsModel productsModelProvider =
        Provider.of<ProductsModel>(context);

    //for defining the size of the device
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        borderRadius: BorderRadius.circular(9),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const FeedsScreen(), type: PageTransitionType.fade));
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetails(
                  id: productsModelProvider.id.toString(),
                );
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                              text: "\$",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 54, 244, 70)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${productsModelProvider.price}",
                                    style: TextStyle(
                                        color: lightTextColor,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ),
                      //icon
                      const Icon(IconlyBold.heart)
                    ],
                  ),
                ),

                //picture of the product
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: FancyShimmerImage(
                    height: size.height * 0.2,
                    width: double.infinity,
                    //if image doesnot display
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 20,
                    ),
                    imageUrl: productsModelProvider.images![0],
                    boxFit: BoxFit.cover,
                  ),
                ),
                //
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    productsModelProvider.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
