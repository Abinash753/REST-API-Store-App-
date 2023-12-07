import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/screens/categories_screen.dart';
import 'package:store_app/screens/feeds_screen.dart';
import 'package:store_app/screens/users_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/appbar_icons.dart';
import 'package:store_app/widgets/feeds_grid.dart';
import 'package:store_app/widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for search  widget
  late TextEditingController _textEditingController;
  //for listing the  data  in the variable
  // List<ProductsModel> productList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  //dispose the  method to clean the code
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  //
  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          //elevation: 5,
          title: const Text("Home"),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const CategoryScreen()),
              );
            },
            icon: IconlyBold.category,
          ),
          actions: [
            //user icon
            AppBarIcons(
                function: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const UsersScreen(),
                          type: PageTransitionType.fade));
                },
                icon: IconlyBold.user3),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              //textfield for search
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Theme.of(context).cardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconsColor,
                    )),
              ),
              //
              const SizedBox(
                height: 4,
              ),
              //

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //
                      const SizedBox(
                        height: 10,
                      ),
                      //sale widget
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 4,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor:
                                      Color.fromARGB(255, 39, 248, 7))),
                          // control: SwiperControl(),
                          itemBuilder: (context, int index) {
                            return const SaleWidget();
                          },
                          autoplay: true,
                          //layout: SwiperLayout.STACK,
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Text(
                              "Latest Products",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            //
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const FeedsScreen(),
                                          type: PageTransitionType.fade));
                                },
                                icon: IconlyBold.arrowRight2),
                          ],
                        ),
                      ),
                      //gridview of latest products
                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProducts(),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            //error checking condition
                            else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            }
                            //if the  snapshot is empty
                            else if (snapshot.data == null) {
                              return const Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            //ensure snapshot.data is not null before using it
                            if (snapshot.data != null) {
                              return FeedsGridWidget(
                                  productList: snapshot.data!);
                            } else {
                              return const Center(
                                child: Text("Upexpected error occured"),
                              );
                            }
                          }))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
