class CategoryData {
  int id;
  String category_name;
  String category_slug;
  String img_url;
  bool isSelected;

  CategoryData(
      {
        this.id,
        this.category_name,
        this.category_slug,
        this.img_url,
        this.isSelected = false
      }
      );

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      category_name: json['category_name'],
      category_slug: json['category_slug'],
      img_url: json['img_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.category_name;
    data['category_slug'] = this.category_slug;
    data['img_url'] = this.img_url;
    return data;
  }

  CategoryData copyWith(
      {int id,
        String category_name,
        String category_slug,
        String img_url,
        bool isSelected,
      }) {
    return CategoryData(
      id: id ?? this.id,
      category_name: category_name ?? this.category_name,
      category_slug: category_slug ?? this.category_slug,
      img_url: img_url ?? this.img_url,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}