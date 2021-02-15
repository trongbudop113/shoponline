class UserData {
  String id;
  String name;
  String image;
  String address;
  String gender;
  String phone;
  String loginBy;


  UserData(
      {
        this.id,
        this.name,
        this.image,
        this.address,
        this.gender,
        this.phone,
        this.loginBy,
      }
      );

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
      gender: json['gender'],
      phone: json['phone'],
      loginBy: json['loginBy'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['loginBy'] = this.loginBy;
    return data;
  }
}