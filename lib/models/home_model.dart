import 'package:awarake/models/product.dart';
import 'package:awarake/models/sititing_model.dart';

class HomeModel {
  List<Product>? sliders;
  List<Category>? categories;
  List<Care>? cares;
  List<SittingModel>? sittings;

  HomeModel({this.sliders, this.categories, this.cares, this.sittings});



  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((v) {
        sliders!.add( Product.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['cares'] != null) {
      cares = [];
      json['cares'].forEach((v) {
        cares!.add(Care.fromJson(v));
      });
    }

    if (json['sittings'] != null) {
      sittings = [];
      json['sittings'].forEach((v) {
        sittings!.add(SittingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Care {
  int? id;
  String? name;
  String? image;
  String? desc;
  Care({this.id, this.name, this.image});

  Care.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['desc']=desc;
    return data;
  }
}
