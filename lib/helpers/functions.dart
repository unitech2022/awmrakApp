

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';

import '../main_ui/login_screen/login_screen.dart';
import 'constants.dart';

printFunction(message) {
  // ignore: avoid_print
  print(message);
}
pop(context) {
  Navigator.of(context).pop();
}

pushPage({context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}


// getDataUser(){
//   ShardEditor editor=ShardEditor();
//   editor.getUser().then((value) {
//
//     currentUser = value;
//     token=value.token!;
//     printFunction("cerrentUser${currentUser.token}");
//   });
// }

// bool isLogin(){
//
//   return token != "";
// }
//
//
readToken() async {
  // await getBaseUrl();
  const storage =  FlutterSecureStorage();
  try {

    token = (await storage.read(key: "token"))!;
    currentUser.id=( await storage.read(key: "id"));
    currentUser.role=( await storage.read(key: "role"));
    currentUser.fullName=( await storage.read(key: "name"));
    currentUser.imageUrl=( await storage.read(key: "image"));
    printFunction("token : ${currentUser.id!}");
  } catch (e) {}
}
//
isRegistered() {
  return (token != "" );
}
//
saveToken() {
  const storage =  FlutterSecureStorage();
  storage.write(key: 'token', value: token);
  storage.write(key: 'id', value: currentUser.id);
  storage.write(key: 'role', value: currentUser.role);
  storage.write(key: 'image', value: currentUser.imageUrl);
  storage.write(key: 'name', value: currentUser.fullName);
}


late String currentLocal;
LocationData locData = LocationData.fromMap({});
getLocation() async {
  Location location =  Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }
  printFunction(message) {
    // ignore: avoid_print
    print(message);
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locData = await location.getLocation();
  print(locData.latitude.toString() + " lat:");
}

Future signOut({ctx}) async {
  await FirebaseMessaging.instance.deleteToken();
  final storage = FlutterSecureStorage();

  token = "";
  await storage.delete(key: "token");
  // await storage.delete(key: "id");
  replacePage(context: ctx, page:  LoginScreen());
}
