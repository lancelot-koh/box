
import 'package:box/model/product.dart';

class CartModel {
  int? id;
  String? title;
  int? price;
  int? stock;
  String? thumbnail;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
        this.title,
        this.price,
        this.stock,
        this.thumbnail,
        this.quantity,
        this.isExist,
        this.time,
        this.product
        });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    stock = json['stock'];
    thumbnail = json['thumbnail'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'stock': this.stock,
      'thumbnail': this.thumbnail,
      'quantity': this.quantity,
      'isExist': this.isExist,
      'time': this.time,
      'product': this.product!.toJson(),
    };
  }
}