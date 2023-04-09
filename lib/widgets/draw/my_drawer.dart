import 'dart:io';
import 'package:awarake/user_ui/about_us/about_us.dart';
import 'package:awarake/user_ui/notifications/notifications_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:awarake/user_ui/edite_my_profile_screen/edite_my_profile_screen.dart';
import 'package:awarake/user_ui/my-address_screen/my-address_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import 'item_draw.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.black
              .withOpacity(.7) //This will change the drawer background to blue.
          //other styles
          ),
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(

              //image: DecorationImage(image: NetworkImage('https://www.viajejet.com/wp-content/viajes/Lago-Moraine-Parque-Nacional-Banff-Alberta-Canada-1440x810.jpg'))
              ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 60,
              ),
              // RichTextTitle(Colors.white),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Column(
                       children: [
                         Container(
                           height: 91,
                           width: 91,
                           padding: EdgeInsets.all(1.5),
                           decoration:  BoxDecoration(
                               border: Border.all(color: Colors.white,width: 1),
                               shape: BoxShape.circle
                           ),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(50),
                             child: CachedNetworkImage(
                               imageUrl: HomeCubit.get(context).userModel.imageUrl != null? baseurlImage +
                                   HomeCubit.get(context).userModel.imageUrl!:"notFound",
                               height: 90,
                               fit: BoxFit.cover,
                               width: 90,
                               placeholder: (context, url) =>
                               const Padding(
                                 padding: EdgeInsets.all(10.0),
                                 child: CircularProgressIndicator(
                                   color: homeColor,
                                 ),
                               ),
                               errorWidget: (context, url, error) =>
                               const Icon(Icons.person,color: Colors.white,size: 70,),
                             ),
                           ),
                         ),

                         const SizedBox(height: 15,),
                         Text(
                           HomeCubit.get(context).userModel.fullName!,
                           style: const TextStyle(
                             fontFamily: 'pnuM',
                             fontSize: 18,
                             color: Colors.white,
                             fontWeight: FontWeight.w300,
                             height: 2.5,
                           ),
                           textHeightBehavior:
                           const TextHeightBehavior(applyHeightToFirstAscent: false),
                           textAlign: TextAlign.start,
                         ),


                       ],
                     ),
                   ],
                 ),
                  const Divider(
                    color: Colors.green,

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ItemDraw(
                      icon: Icons.home,
                      text: "الرئيسية",
                      press: () {
                        // replacePage(context: context,page: NavigationPage(currentIndex: 0,));
                      },
                      colorIcon: KYellow2Color,
                      color: Colors.white),

                  // ItemDraw(
                  //     icon: Icons.category,
                  //     text: "الفئات".tr(),
                  //     press: () {
                  //       // replacePage(context: context,page: NavigationPage(currentIndex: 1,));
                  //     },
                  //     colorIcon: KYellow2Color,
                  //     color: Colors.white),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ItemDraw(
                  //      icon: Icons.notifications_active_outlined,
                  //     text: "الاشعارات",
                  //     press: () {},
                  //     colorIcon: KYellow2Color,
                  //     color: Colors.white),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // ItemDraw(
                  //     icon: "Notification_draw.svg",
                  //     text: "التنبيهات".tr(),
                  //     press: () {
                  //       pop(context);
                  //       showBottomSheetNotifications(context);
                  //     },
                  //     color: Colors.white),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // ItemDraw(
                  //     icon: "Wallet.svg",
                  //     text: "محفظتي",
                  //     press: () {},
                  //     color: Colors.white),
                  const SizedBox(
                    height: 10,
                  ),
 /*                 ItemDraw(
                      icon: Icons.reorder,
                      text: "الطلبات".tr(),
                      press: () {
                        // replacePage(context: context,page: NavigationPage(currentIndex: 2,));
                      },
                      colorIcon: KYellow2Color,
                      color: Colors.white),
                  const SizedBox(
                    height: 10,
                  ),

                  ItemDraw(
                      icon: Icons.shopping_cart,
                      text: "السلة",
                      press: () {
                        // pushPage(context: context,page: UserAdresses());
                      },
                      colorIcon: KYellow2Color,
                      color: Colors.white),*/
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  ItemDraw(
                      icon: Icons.location_on_outlined,
                      text: "عناويني",
                      press: () {
                      pushPage(context: context,page: const MyAddressScreen());
                      },
                      colorIcon: KYellow2Color,
                      color: Colors.white),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemDraw(
                    icon: Icons.person,
                    text: "بيانات الحساب",
                    press: () {
                       pushPage(context: context,page: EditMyProfileScreen());
                    },
                    colorIcon: KYellow2Color,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ItemDraw(
                    icon: Icons.notifications,
                    text: "الاشعارات",
                    press: () {
                      pushPage(context: context,page: NotificationsScreen());
                    },
                    colorIcon: KYellow2Color,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  InkWell(
                    onTap: () async{
                      var whatsappURl_android = "whatsapp://send?phone=+20$customerServiceNumber&text=مرحبا بك";
                      var whatappURL_ios ="https://wa.me/$customerServiceNumber?text=${Uri.parse("مرحبا بك")}";
                      if(Platform.isIOS){
                        // for iOS phone only
                        if( await canLaunch(whatappURL_ios)){
                          await launch(whatappURL_ios, forceSafariVC: false);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: new Text("whatsapp no installed")));

                        }

                      }else{
                        // android , web
                        if( await canLaunch(whatsappURl_android)){
                          await launch(whatsappURl_android);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: new Text("whatsapp no installed")));

                        }


                      }
                    },
                    child: pageRow(Icons.email_outlined, "تواصل معنا", ""),
                  ),

                  InkWell(
                    onTap: () {
                   Share.share('https://play.google.com/store/apps/details?id=com.awarake.awarake');
                    },
                    child: pageRow(Icons.share, "شارك التطبيق", ""),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ItemDraw(
                  icon: Icons.help,
                  text: "من نحن ؟",
                  press: () {
                  pushPage(context: context,page: AboutUsScreen());
                  },
                  colorIcon: KYellow2Color,
                  color: Colors.white),
              const SizedBox(
                height: 10,
              ),
              ItemDraw(
                icon: Icons.logout,
                colorIcon: Colors.red,
                text: "تسجيل الخروج",
                press: () {
                  pop(context);
                  showMyDialog(context,onConfirm: (){

                  });



                },
                color: Colors.red,
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }

  pageRow(icon, key, value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 25,
                  color: KYellow2Color,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: "pnuR"
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "pnuM",
                color: KHomeColor,
              ),
            ),
          ],
        ),
      );
}


showMyDialog(context,{onConfirm}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(' تسجيل الخروج'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[

              Text('هل انت متأكد انك تريد تسجيل الخروج؟'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('خروج'),
            onPressed:(){

              signOut(ctx: context).then((value){
                pop(context);
              });

            },
          ),

          TextButton(
            child: const Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}