import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/user_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/user_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: APIHandler.getAllUsers(),
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

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const UsersWidget(),
                );
              });
        }),
      ),
    );
  }
}
