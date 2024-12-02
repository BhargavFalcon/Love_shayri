class ItemModel {
  String? title;
  String? image;
  int? size;

  ItemModel({this.title, this.image, this.size});

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['size'] = this.size;
    return data;
  }
}
