class BodyRight {
  String id;
  String name;
  String image;
  String price;
  String discount;
  bool isSelected;

  BodyRight(
      {
        this.id,
        this.name,
        this.image,
        this.price,
        this.discount,
        this.isSelected = false
      }
      );

  factory BodyRight.fromJson(Map<String, dynamic> json) {
    return BodyRight(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    return data;
  }
}