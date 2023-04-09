
import 'package:shared_preferences/shared_preferences.dart';

class ShardEditor {
  Future<void> setDataToShared(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

//get value from shared preferences
//
//   Future<void> setData(UserResponse userResponse) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(tokenKey, userResponse.token!);
//     prefs.setString(nameUserKey, userResponse.user!.fullName!);
//     prefs.setString(phoneUserKey, userResponse.user!.userName!);
//     prefs.setString(userIdKey, userResponse.user!.id!);
//     // prefs.setString(userImageKey, userResponse.user!.imageUrl!+"");
//   }

  Future<String> getGetDataSingle(key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(key) ?? "";
  }

  Future<void> setDataSingle(key, value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  //
  // Future<UserResponse> getUser() async {
  //   UserResponse userModel = UserResponse();
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   userModel.token=pref.getString(token) ?? "";
  //   userModel.user!.id = pref.getString(userIdKey) ?? "";
  //   userModel.user!.fullName = pref.getString(nameUserKey) ?? "";
  //   userModel.user!.userName = pref.getString(phoneUserKey) ?? "";
  //   userModel.user!.imageUrl = pref.getString(userImageKey) ?? "";
  //
  //   return userModel;
  // }

// //=======================================
// //get value from shared preferences
// Future<String> getUserName(String key) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String authToken = pref.getString(UserName) ?? "";
//   return authToken;
// }
//
// Future<void> setName(String value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(UserName, value);
// }
//
// //get value from shared preferences
// Future<String> getUserPhone() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String authToken = pref.getString(UserPhone) ?? "";
//   return authToken;
// }
//
// Future<void> setPhone(String value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(UserPhone, value);
// }
//
// //get value from shared preferences
// Future<bool> getUserIsLogin() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   bool authToken = pref.getBool(UserLogin) ?? false;
//   return authToken;
// }
//
// Future<void> setIsLogin(bool value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool(UserLogin, value);
// }
//
// Future<void> remove(String key) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove(key);
// }
//
// Future<void> setUserId(String value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(UserId, value);
// }
//
// Future<String> getUserId() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String authToken = pref.getString(UserId) ?? "";
//   return authToken;
// }
//
// //get value from shared preferences
// Future<String> getUserRole() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String authToken = pref.getString(UserRole) ?? "";
//   return authToken;
// }
//
// Future<void> setUserRole(String value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(UserRole, value);
// }
//
// //get value from shared preferences
// Future<String> getMarket(String keyShared) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String authToken = pref.getString(keyShared) ?? "";
//
//   return authToken;
// }
//
// Future<void> setMarket(Market value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(MarketId, value.id.toString());
//   prefs.setString(MarketTitle, value.title);
//   prefs.setString(MarketUserId, value.userId.toString());
//   prefs.setString(MarketImage, value.image);
//   prefs.setString(MarketBannarImage, value.bannarImage);
//   prefs.setString(MarketLat, value.lat.toString());
//   prefs.setString(MarketLng, value.lng.toString());
//   prefs.setString(MarketIsClosed, value.isClosed.toString());
//   prefs.setString(MarketPhone, value.phone);
//   prefs.setString(MarketStatus, value.status.toString());
//   prefs.setString(MarketSummary, value.summary);
//   prefs.setString(MarketRate, value.rate.toString());
//   prefs.setString(MarketOrderCount, value.rate.toString());
// }
}
