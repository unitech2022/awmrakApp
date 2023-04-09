class Order {
  int? id;
  String? userId;
  var price;
  int? status ,addressId;
  int? sellerId;
  String? fcmToken;
  String? createdAt;

  Order(
      {this.id,
        this.userId,
        this.fcmToken,
        this.price,
        this.status,
        this.sellerId,
        this.addressId,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    price = json['price'];
    fcmToken = json['fcmToken'];
    status = json['status'];
    addressId = json['addressId'];
    sellerId = json['sellerId'];
    createdAt = json['createdAt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['price'] = this.price;
    data['addressId']= addressId ;
    data['status'] = this.status;
    data['fcmToken'] = this.fcmToken;
    data['sellerId'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}