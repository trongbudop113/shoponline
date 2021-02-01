class UserData {
  String id;
  String fistName;
  String lastName;
  String image;
  String address;


  UserData(
      {
        this.id,
        this.fistName,
        this.lastName,
        this.image,
        this.address,
      }
      );

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fistName: json['fistName'],
      lastName: json['lastName'],
      image: json['image'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fistName'] = this.fistName;
    data['lastName'] = this.lastName;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}