class UserData {
  String id;
  String name;
  String image;
  String address;
  String birthDay;
  String gender;
  String phone;
  String loginBy;
  String loginAt;


  UserData(
      {
        this.id,
        this.name,
        this.image,
        this.address,
        this.birthDay,
        this.gender,
        this.phone,
        this.loginBy,
        this.loginAt,
      }
      );

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
      birthDay: json['birthDay'],
      gender: json['gender'],
      phone: json['phone'],
      loginBy: json['loginBy'],
      loginAt: json['loginAt'],
    );
  }

  UserData.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    address = data['address'];
    birthDay = data['birthDay'];
    gender = data['gender'];
    phone = data['phone'];
    loginBy = data['loginBy'];
    loginAt = data['loginAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['birthDay'] = this.birthDay;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['loginBy'] = this.loginBy;
    data['loginAt'] = this.loginAt;
    return data;
  }
}