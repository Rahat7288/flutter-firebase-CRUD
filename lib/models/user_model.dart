// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? age;
  UserModel({this.name, this.age, this.id});

  factory UserModel.fromSnapshot(DocumentSnapshot sanp) {
    var snapshot = sanp.data() as Map<String, dynamic>;
    return UserModel(
      //snapshot parameter should be the same name as the model
      name: snapshot['name'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        // name should be as dicleard
        "name": name,
        "age": age,
        "id": id,
      };
}
