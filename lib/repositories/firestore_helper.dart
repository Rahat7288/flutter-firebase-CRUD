import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/user_model.dart';

class FireStoreHelper {
  // fetching the data from the firestore
  static Stream<List<UserModel>> read() {
    final userCollections = FirebaseFirestore.instance.collection('users');
    return userCollections.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  //  this function will create the data base and the documents.
  static Future<void> createDatabase(UserModel user) async {
    // connecting the database / creating the database if there arre no data.
    final userCollection = FirebaseFirestore.instance.collection("users");

    // creating the uniqe id for the user model
    final uid = userCollection.doc().id;
    // docRef got the uniqe id that have been created
    final docRef = userCollection.doc(uid);
    // creating the new user by accesing the userModel
    final newUser = UserModel(
      id: uid,
      name: user.name,
      age: user.age,
    ).toJson();

    try {
      await docRef.set(newUser);
    } catch (e) {
      print("some error occour $e");
    }
  }

// function for update the field
  static Future update(UserModel user) async {
    final userControler = FirebaseFirestore.instance.collection("users");
    final docRef = userControler.doc(user.id);

    // creating the update field
    final newUser = UserModel(
      id: user.id,
      name: user.name,
      age: user.age,
    ).toJson();

    try {
      await docRef.update(newUser);
    } catch (e) {
      print("some error oddour $e");
    }
  }

  // function for deleting item form the list

  static Future delete(UserModel user) async {
    final userController = FirebaseFirestore.instance.collection("users");
    final docRef = userController.doc(user.id).delete();
  }
}
