import 'package:awarake/models/notification_model.dart';
import 'package:awarake/user_ui/navigation_screen/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/functions.dart';

class DetailsNotification extends StatefulWidget {
  final NotificationModel notificationModel;

  DetailsNotification(this.notificationModel);


  @override
  State<DetailsNotification> createState() => _DetailsNotificationState();
}

class _DetailsNotificationState extends State<DetailsNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,

          leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
               pushPage(context: context,page: NavigationScreen());
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: const Color(0xff6A644C),
          title: const Text("الاشعارات",
              style: TextStyle(
                fontFamily: 'pnuB',
                fontSize: 18,
                color: Colors.white,
              )),
        ),
        body:Padding(
    padding: EdgeInsets.all(20),
    child: SingleChildScrollView(
    child: Column(

      children: [
         Text(widget.notificationModel.name!,
            style: TextStyle(
              fontFamily: 'pnuB',
              fontSize: 20,
              color: Colors.black,
            )),
        SizedBox(height: 10,)
        ,Divider(),
        SizedBox(height: 10,),
        Text(widget.notificationModel.body!,
            style: TextStyle(
              fontFamily: 'pnuB',
              fontSize: 18,
              color: Colors.grey,
            )),
      ],

    ),
    )));

  }
}
