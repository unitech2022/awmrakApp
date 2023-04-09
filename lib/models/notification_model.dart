class NotificationModel {
  int? id;
  String? name;
  String? image;
  int? status;
  String? userId;
  String? body;
  String? createdAt;

  NotificationModel(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.userId,
        this.body,
        this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    userId = json['userId'];
    body = json['body'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['body'] = this.body;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
