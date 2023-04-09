class Cart {
  int? id;
  int? orderId;
  String? image;
  String? nameProduct;
  int? productId;
  var price;
  var total;
  int? marketId;
  String? userId;
  int? quantity;

  Cart(
      {this.id,
        this.orderId,
        this.image,
        this.nameProduct,
        this.productId,
        this.userId,
        this.price,
        this.marketId,
        this.total,
        this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    image = json['image'];
    nameProduct = json['nameProduct'];
    productId = json['productId'];
    userId = json['userId'];
    price = json['price'];
    total = json['total'];
    marketId = json['market_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    data['image'] = image;
    data['nameProduct'] = nameProduct;
    data['productId'] = productId;
    data['userId'] = userId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['total'] = total;
    data['market_id'] = marketId;
    return data;
  }
}
