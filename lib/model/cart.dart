class CartItem {
  String id;
  String name;
  String image;
  String price;
  String discount;
  int quantity;

  CartItem(
      {
        this.id,
        this.name,
        this.image,
        this.price,
        this.discount,
        this.quantity
      }
      );

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toString(),
      discount: json['discount'],
      quantity: json['quantity'],
    );
  }

  CartItem.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    discount = data['discount'];
    price = data['price'].toString();
    quantity = data['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class CartTotalItem {
  String id;
  List<CartItem> cartItems;
  String code;
  String total;
  double totalFinal;
  String discount;
  String status;

  CartTotalItem(
      {
        this.id,
        this.cartItems,
        this.code,
        this.total,
        this.totalFinal,
        this.discount,
        this.status
      }
      );

  factory CartTotalItem.fromJson(Map<String, dynamic> json) {
    return CartTotalItem(
      id: json['id'],
      cartItems: json['cartItems'],
      code: json['code'],
      total: json['total'],
      totalFinal: json['totalFinal'],
      discount: json['discount'],
      status: json['status'],
    );
  }

  CartTotalItem.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    cartItems = data['cartItems'];
    code = data['code'];
    discount = data['discount'];
    totalFinal = data['totalFinal'];
    total = data['total'];
    status = data['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartItems'] = this.cartItems.toSet();
    data['code'] = this.code;
    data['total'] = this.total;
    data['totalFinal'] = this.totalFinal;
    data['discount'] = this.discount;
    data['status'] = this.status;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartItems': cartItems,
      'code': code,
      'total': total,
      'totalFinal': totalFinal,
      'discount': discount,
      'status': status,
    };
  }
}

class CartTotalItemPost {
  String id;
  var cartItems;
  String code;
  String total;
  double totalFinal;
  String discount;
  String status;

  CartTotalItemPost(
      {
        this.id,
        this.cartItems,
        this.code,
        this.total,
        this.totalFinal,
        this.discount,
        this.status
      }
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartItems'] = this.cartItems;
    data['code'] = this.code;
    data['total'] = this.total;
    data['totalFinal'] = this.totalFinal;
    data['discount'] = this.discount;
    data['status'] = this.status;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartItems': cartItems,
      'code': code,
      'total': total,
      'totalFinal': totalFinal,
      'discount': discount,
      'status': status,
    };
  }
}