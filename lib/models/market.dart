class MarketModel {
  int? id;
  String? name;
  String? image;
  var lat;
  var lng;
  String? address;
  String? details;
  String? userId;
  String? city;
  String? phone;
  int? status;
  String? token;
  int? categoryId;
  MarketModel(
      {this.id,
        this.token,
        this.categoryId,
        this.name,
        this.image,
        this.phone,
        this.lat,
        this.lng,
        this.address,
        this.details,
        this.userId,
        this.city,
        this.status});

  MarketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    phone = json['phone'];
    address = json['address'];
    details = json['details'];
    userId = json['userId'];
    city = json['city'];
    token = json['token'];
    status = json['status'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['lat'] = lat;
    data['lng'] = lng;
    data['phone'] = this.phone;
    data['address'] = address;
    data['details'] = details;
    data['userId'] = userId;
    data['city'] = city;
    data['status'] = status;
    data['token'] = this.token;
    data['categoryId'] = categoryId;
    return data;
  }
}

class ResponseMarkets {
  List<MarketModel>? items;
  int? currentPage;
  int? totalPage;

  ResponseMarkets({this.items, this.currentPage, this.totalPage});

  ResponseMarkets.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(MarketModel.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalPage'] = totalPage;
    return data;
  }
}