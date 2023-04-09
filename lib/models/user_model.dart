class UserModel {
  String? id;
  String? userName;
  String? fullName;
  String? imageUrl;
  String? status;
  String? role;
  String? deviceToken;

  UserModel(
      {this.id,
        this.userName,
        this.fullName,
        this.imageUrl,
        this.status,
        this.deviceToken,
        this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    deviceToken = json['deviceToken'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['fullName'] = fullName;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['deviceToken'] = deviceToken;
    data['role'] = role;
    return data;
  }
}


class UserResponse {
  String? token;
  UserModel? user;
  var driver;
  List<String>? userRoles;
  String? expiration;

  UserResponse(
      {this.token, this.user, this.driver, this.userRoles, this.expiration});

  UserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    driver = json['driver'];
    userRoles = json['userRoles'].cast<String>();
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['driver'] = driver;
    data['userRoles'] = userRoles;
    data['expiration'] = expiration;
    return data;
  }
}






