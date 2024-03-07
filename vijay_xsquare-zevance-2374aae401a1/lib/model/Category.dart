class Category {
  int? id;
  String? categoryName;
  String? categoryImg;
  String? status;
  bool? interrest=false;

  Category({this.id,
        this.categoryName,
        this.categoryImg,
        this.status});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['category_img'] = categoryImg;
    data['status'] = status;
    return data;
  }
}