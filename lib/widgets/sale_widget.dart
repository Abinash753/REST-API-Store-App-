import 'package:flutter/material.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 54, 86, 244),
              Color.fromARGB(255, 247, 0, 148),
            ],
            begin: FractionalOffset(
              0.0,
              0.0,
            ),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 221, 221),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get the special OFFER ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        //50% off text
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "40% \nOFF",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          //image in sales widget
          Flexible(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(13),
                child: Image.network(
                  width: double.infinity,
                  "https://i.ibb.co/vwB46Yq/shoes.png",
                  fit: BoxFit.contain,
                )),
          ),
        ],
      ),
    );
  }
}
