import 'dart:convert';

import 'package:awarake/helpers/constants.dart';
import 'package:awarake/models/notification_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../helpers/functions.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of<NotificationCubit>(context);
  List<NotificationModel> notifications = [];
  bool getNotyLoad = false;

  getNotifications({userId}) async {
    notifications = [];
    getNotyLoad = true;
    emit(GetNotificationsLoad());
    var request = http.MultipartRequest('POST',
        Uri.parse(baseUrl + '/api/notification/get-notifications-user'));
    request.fields.addAll({'userId': userId});

    http.StreamedResponse response = await request.send();
    printFunction(response.statusCode.toString() + " >>>>>>>>>>noty");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        notifications.add(NotificationModel.fromJson(v));
      });

      getNotyLoad = false;
      emit(GetNotificationsSuccess());
    } else {
      getNotyLoad = false;
      emit(GetNotificationsError());
    }
  }
}
