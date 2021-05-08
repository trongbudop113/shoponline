import 'package:cloud_firestore/cloud_firestore.dart';

class BodyRight {
  String id;
  String name;
  String category;
  String image;
  String discount;
  String description;
  String price;
  List colors = [];
  Timestamp createdAt;
  Timestamp updatedAt;

  BodyRight();

  BodyRight.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    discount = data['discount'];
    description = data['description'];
    price = data['price'];
    colors = data['colors'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'discount': discount,
      'description': description,
      'price': price,
      'colors': colors,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}