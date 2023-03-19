import 'package:cloud_firestore/cloud_firestore.dart';
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
              _createDatabase();
            },
            child: Text('update database'),
          ),
        ],
      )),
    );
  }

  //  this function will create the data base and the documents.
  Future<void> _createDatabase() async {
    // connecting the database / creating the database if there arre no data.
    final userCollection = FirebaseFirestore.instance.collection("users");
    final docRef = userCollection.doc();

    await docRef.set({
      "username": _userNameController.text,
      "age": _ageController.text,
    });
  }
}
