class FavoriteItem {
  String id;
  String name;
  String image;
  String price;
  String discount;
  int quantity;

  FavoriteItem(
      {
        this.id,
        this.name,
        this.image,
        this.price,
        this.discount,
        this.quantity
      }
      );

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      discount: json['discount'],
      quantity: json['quantity'],
    );
  }

  FavoriteItem.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    discount = data['discount'];
    price = data['price'];
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