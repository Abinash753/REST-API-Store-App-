import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/services/api_handler.dart';

import '../consts/global_colors.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  const ProductDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  //function to fetch the product info according to their id
  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo() async {
    try {
      productsModel =
          (await APIHandler.getProductById(id: widget.id)) as ProductsModel?;
    } catch (e) {
      isError = true;
      errorStr = e.toString();
      print("error : $e");
    }
    setState(() {});
  }

  //
  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isError == true
              ? Center(
                  child: Text(
                    "An Error Occured:$errorStr",
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              : productsModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        const BackButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productsModel!.category!.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productsModel!.title.toString(),
                                      textAlign: TextAlign.start,
                                      style: titleStyle,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: '\$',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: productsModel!.price
                                                    .toString(),
                                                style: TextStyle(
                                                    color: lightTextColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return FancyShimmerImage(
                                width: double.infinity,
                                imageUrl:
                                    productsModel!.images![index].toString(),
                                boxFit: BoxFit.fill,
                              );
                            },

                            autoplay: true,
                            itemCount: 2,
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.red,
                              ),
                            ),
                            // control: const SwiperControl(),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description:", style: titleStyle),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                productsModel!.description.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
