import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/user_model.dart';
import 'package:firebase_crud/pages/edit_page.dart';
import 'package:firebase_crud/repositories/firestore_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _ageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
          child: Column(
        children: [
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "User Name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Age",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              FireStoreHelper.createDatabase(UserModel(
                  name: _userNameController.text, age: _ageController.text));
            },
            child: Text('update database'),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<List<UserModel>>(
              stream: FireStoreHelper.read(),
              builder: (context, snapshot) {
                // we will check the condition inside tyhe builder function
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some Error"),
                  );
                }
                if (snapshot.hasData) {
                  final userData = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: userData!.length,
                        itemBuilder: (context, index) {
                          final singleUserData = userData[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete'),
                                        content: const Text(
                                            ' are you sure you want to delete this item ?'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              FireStoreHelper.delete(
                                                      // we need to add then becouse it an async function
                                                      singleUserData)
                                                  .then((value) =>
                                                      {Navigator.pop(context)});
                                            },
                                            child: const Text('Delete'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text("${singleUserData.name}"),
                              subtitle: Text("${singleUserData.age}"),
                              trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPage(
                                                  user: UserModel(
                                                      name: singleUserData.name,
                                                      age: singleUserData.age,
                                                      id: singleUserData.id),
                                                )));
                                  },
                                  child: const Icon(Icons.edit)),
                            ),
                          );
                        }),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      )),
    );
  }
}
