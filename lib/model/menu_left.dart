class MenuLeft {
  int id;
  String category_name;
  String img_url;
  bool isSelected;

  MenuLeft(
      {
        this.id,
        this.category_name,
        this.img_url,
        this.isSelected = false
      }
      );

  factory MenuLeft.fromJson(Map<String, dynamic> json) {
    return MenuLeft(
      id: json['id'],
      category_name: json['category_name'],
      img_url: json['img_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.category_name;
    data['img_url'] = this.img_url;
    return data;
  }

  MenuLeft copyWith(
      {int id,
        String category_name,
        String category_slug,
        String img_url,
        bool isSelected,
      }) {
    return MenuLeft(
      id: id ?? this.id,
      category_name: category_name ?? this.category_name,
      img_url: img_url ?? this.img_url,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  List<MenuLeft> getListData(){
    List<MenuLeft> list = new List();
    var a = MenuLeft();
    a.id = 0;
    a.category_name = 'Home';
    a.img_url = '';
    a.isSelected = false;

    var b = MenuLeft();
    b.id = 1;
    b.category_name = 'New In';
    b.img_url = '';
    b.isSelected = false;

    var c = MenuLeft();
    c.id = 2;
    c.category_name = 'Coats';
    c.img_url = '';
    c.isSelected = false;

    var d = MenuLeft();
    d.id = 3;
    d.category_name = 'KnitWear';
    d.img_url = '';
    d.isSelected = false;

    var e = MenuLeft();
    e.id = 4;
    e.category_name = 'Tops';
    e.img_url = '';
    e.isSelected = false;

    list.add(a);
    list.add(b);
    list.add(c);
    list.add(d);
    list.add(e);

    return list;
  }
}