import 'package:fcfreshfoods/constants/static.dart';

class Category {
  late int id;
  late String categoryName;
  late String categoryImg;
  late String slogan;

  Category({ required this.id, required this.categoryName, required this.categoryImg, required this.slogan});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    slogan = json['category_slogan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_img'] = Constants.host+this.categoryImg;
    data['category_slogan'] = this.slogan;
    return data;
  }


  String getname(){
    return this.categoryName;

  }
  String getimg(){
    return this.categoryImg;
  }

  String getslogan() {
    return this.slogan;
  }

  getid() {
    return this.id;
  }
}