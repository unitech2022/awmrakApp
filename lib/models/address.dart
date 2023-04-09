class Address {
  int? id;
  String? userId;
  String? lable;
  double? lat;
  double? lng;
  String? createdAt;

  Address(
      {this.id, this.userId, this.lable, this.lat, this.lng, this.createdAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    lable = json['lable'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['lable'] = this.lable;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
