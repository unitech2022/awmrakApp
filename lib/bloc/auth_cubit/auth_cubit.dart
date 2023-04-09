import 'dart:convert';

import 'package:awarake/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/user_model.dart';
import '../../user_ui/navigation_screen/navigation_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  bool isCheckedUserName = false;

  checkUserName({phone,context}) async {
    isCheckedUserName = true;
    emit(CheckUserAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + checkUserNamePoint));
    request.fields.addAll({'phone': phone});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      if(jsonData["status"]==1){


        loginUser(userName: phone,code:jsonData["code"],context: context );
      }else{
        isCheckedUserName = false;

      }
      emit(CheckUserAuthStateSuccess(
          phone: phone, code: jsonData["code"], status: jsonData["status"]));

    } else {
      isCheckedUserName = false;
      printFunction("errrrrrrrrrror");
      emit(CheckUserAuthStateError());
    }
  }

  bool isValidate = false;

  validateUser({username, email, fullName}) async {
    emit(ValidateAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + validatePoint));
    request.fields.addAll({'email': email, 'userName': username});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);

      registerUser(email: email, userName: username, fullName: fullName);
    } else if (response.statusCode == 400) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);
      emit(ValidateAuthStateError(jsonsDataString));
    } else {
      printFunction(response.statusCode);
      emit(ValidateAuthStateError("errrrrrrrrrror"));
    }
  }

  bool isRegisterLoad = false;

  registerUser({fullName, email, userName, role}) async {
    isRegisterLoad = true;
    emit(RegisterAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + registerPoint));
    request.fields.addAll({
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'knownName': 'askdkalshkjsa',
      'Role': role,
      'password': 'Abc123@',
      'DeviceFCM': tokenFCM
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      isRegisterLoad = false;
      emit(
          RegisterAuthStateSuccess(code: jsonData["code"], userName: userName));
    } else {
      printFunction(response.reasonPhrase);
      isRegisterLoad = false;
      emit(RegisterAuthStateError());
    }
  }

  UserModel user = UserModel();

  loginUser({code, userName,context}) async {
    // emit(LoginAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + loginPoint));
    request.fields.addAll({'code': code, 'userName': userName});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      UserResponse userResponse = UserResponse.fromJson(jsonData);
      if(userResponse.user!.role=="user"){
        token = "Bearer " + userResponse.token!;
        currentUser = user = userResponse.user!;



        await saveToken();
        printFunction("currentUser${token}");

        printFunction(userResponse.token);
        UpdateDeviceToken(userId: userResponse.user!.id!);
        isCheckedUserName = false;
        emit(LoginAuthStateSuccess(userResponse));
      }else{

        HelperFunction.slt.notifyUser(
          message: "الحساب مسجل كمزود خدمة ",context: context,color: Colors.red
        );
        emit(LoginAuthStateError());
      }


    } else {
      printFunction("errrrrrrrrrror");
      emit(LoginAuthStateError());
    }
  }

  bool isChecked = false;

  changeCheckBox(bool checked) {
    isChecked = checked;
    printFunction(isChecked);
    emit(ChangeCheckBox());
  }

  int currentStatus = 0;

  currentStatusState(int newStatus) {
    currentStatus = newStatus;
    printFunction(currentStatus);
    emit(ChangeCheckBox());
  }

  UpdateDeviceToken({token, userId,context}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + '/auth/update-deviceToken'));
    request.fields.addAll({'UserId': userId, 'Token': tokenFCM});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("updatedToken");

    } else {
      print("ErrorUpdatedToken");
    }
  }
}
