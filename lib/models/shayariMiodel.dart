class shayariModel {
  int? shayariId;
  String? shayariText;
  String? shayariCate;
  String? favourite;

  shayariModel({
    this.shayariId,
    this.shayariText,
    this.favourite,
  });

  shayariModel.fromJson(Map<String, dynamic> json) {
    shayariId = json['shayari_id'];
    shayariText = json['shayari_text'];
    shayariCate = json['shayari_cate'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shayari_id'] = this.shayariId;
    data['shayari_text'] = this.shayariText;
    data['shayari_cate'] = this.shayariCate;
    data['favourite'] = this.favourite;
    return data;
  }
}
