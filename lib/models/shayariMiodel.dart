class shayariModel {
  int? shayariId;
  String? shayariText;
  String? shayariCate;
  String? favourite;
  String? color;

  shayariModel({
    this.shayariId,
    this.shayariText,
    this.favourite,
    this.shayariCate,
    this.color,
  });

  shayariModel.fromJson(Map<String, dynamic> json) {
    shayariId = json['shayari_id'];
    shayariText = json['shayari_text'];
    shayariCate = json['shayari_cate'];
    favourite = json['favourite'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shayari_id'] = this.shayariId;
    data['shayari_text'] = this.shayariText;
    data['shayari_cate'] = this.shayariCate;
    data['favourite'] = this.favourite;
    data['color'] = this.color;
    return data;
  }
}
