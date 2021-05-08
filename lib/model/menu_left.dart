class MenuLeft {
  String id;
  String name;

  MenuLeft();

  MenuLeft.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
}