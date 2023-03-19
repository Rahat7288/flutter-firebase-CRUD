import 'package:firebase_crud/models/user_model.dart';
import 'package:firebase_crud/repositories/firestore_helper.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final UserModel user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? _userNameController;
  TextEditingController? _ageController;

  @override
  void initState() {
    _userNameController = TextEditingController(text: widget.user.name);
    _ageController = TextEditingController(text: widget.user.age);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _userNameController!.dispose();
    _ageController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EditPage"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Update Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Update Age",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FireStoreHelper.update(UserModel(
                        id: widget.user.id,
                        name: _userNameController!.text,
                        age: _ageController!.text))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
