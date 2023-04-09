import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/user_ui/cart_screen/cart_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../helpers/add_helper.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../widgets/draw/my_drawer.dart';
import '../home_screen/home_user_screen.dart';
import '../method_payment/method_payment.dart';
import '../offer_screen/offer_screen.dart';
import '../orders_screen/orders_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Widget> screens = [
    const HomeUserScreen(),
    const OfferScreen(),
    const OrdersScreen(),
    CartScreen(),
    Container(
      color: Colors.brown,
    )
  ];

  @override
  void initState() {
    listenMessageNotification();
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getGovernorates();
    HomeCubit.get(context).getUserDetails();
    CartCubit.get(context).getCarts();
    getLocation();
    print(token);
    getAdds();

  }



  void listenMessageNotification() async {
    await FirebaseMessaging.instance.subscribeToTopic('user');
    // await FirebaseMessaging.instance.subscribeToTopic(currentUser.id.toString());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: createUniqueId(),

          color: homeColor,
          icon: 'resource://drawable/ic_launcher',
          channelKey: 'key1',
          title:
              notification.title,
          body: notification.body, // largeIcon: "asset://assets/images/logo_final.png"
        ));

        // AwesomeNotifications().initialize(
        //     "asset://assets/images/logo_final",
        //     [
        //       NotificationChannel(
        //           channelKey: 'key1',
        //           channelName: 'chat',
        //           channelDescription: "Notification example",
        //           defaultColor: Colors.blue,
        //           ledColor: Colors.blue,
        //           channelShowBadge: true,
        //           playSound: true,
        //           enableLights:true,
        //           enableVibration: false
        //       )
        //     ]
        // );

/*        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            "تم اضافة اعلان في الاعلانات المعلقة",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));*/

        // print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            key: _key,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xff6A644C),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(HomeCubit.get(context).currentTitle,
                      style: const TextStyle(
                          fontFamily: 'pnuB',
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w200)),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Stack(
                      children: const [
                        Positioned(
                          top: 9,
                          right: 0,
                          child: Text(
                            '',
                            style: TextStyle(
                              fontFamily: 'pnuB',
                              fontSize: 12,
                              color: Color(0xffff0000),
                              fontWeight: FontWeight.w700,
                              height: 1.0833333333333333,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Positioned(
                        //   left: 20,
                        //   top: 0,
                        //   bottom: 0,
                        //   child: IconButton(
                        //     icon: const Icon(
                        //       Icons.account_circle,
                        //       size: 30,
                        //       color: Colors.white,
                        //     ),
                        //     onPressed: () {
                        //       // pushPage(context:context,page:Account(KYellowColor));
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            body: Padding(
              padding:  EdgeInsets.only(bottom:20),
              child: IndexedStack(
                index: HomeCubit.get(context).currentIndex,
                children: screens,
              ),
            ),
            floatingActionButton: getFloatButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: buildBottomAppBar(),
            drawer: MyDrawer(),
          ),
        );
      },
    );
  }

  Padding getFloatButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          child: GestureDetector(
            onTap: () {
              HelperFunction.slt.showSheet(context, dailogSelectCall(context));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 5,
                    color: const Color(0xFFF2F4F3),
                  )),
              child: Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 0.2, color: KBluColor)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/logo_husain.jpg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ))),
            ),
          ),
        ),
      ),
    );
  }

  buildBottomAppBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: const Color(0xff6A644C),
          borderRadius: BorderRadius.circular(1)),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 25,
            child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  HomeCubit.get(context).changeNav(0, "الرئيسية");
                },
                child: Icon(
                  Icons.home,
                  color: HomeCubit.get(context).currentIndex == 0
                      ? Colors.white
                      : Colors.white.withOpacity(.5),
                )),
          ),
          SizedBox(
            width: 25,
            child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  HomeCubit.get(context).changeNav(1, "العروض");
                },
                child: Icon(Icons.local_offer,
                    color: HomeCubit.get(context).currentIndex == 1
                        ? Colors.white
                        : Colors.white.withOpacity(.5))),
          ),
          Container(
            width: 40,
          ),
          SizedBox(
            width: 25,
            child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  HomeCubit.get(context).changeNav(2, "الطلبات");
                },
                child: Icon(Icons.comment,
                    color: HomeCubit.get(context).currentIndex == 2
                        ? Colors.white
                        : Colors.white.withOpacity(.5))),
          ),
          SizedBox(
            width: 25,
            child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  HomeCubit.get(context).changeNav(3, "السلة");
                },
                child: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Badge(
                        position: BadgePosition.topStart(start: -2, top: -10),
                        showBadge:CartCubit.get(context).carts.isEmpty?false:true ,
                        badgeContent: CartCubit.get(context).carts.isEmpty
                            ? SizedBox()
                            : Text(
                                '${CartCubit.get(context).carts.length}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                        child: Icon(Icons.shopping_cart,
                            color: HomeCubit.get(context).currentIndex == 3
                                ? Colors.white
                                : Colors.white.withOpacity(.5)));
                  },
                )),
          )
        ],
      ),
    );
  }

  dailogSelectCall(BuildContext context) {
    return Container(
      height: 280,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.5),
                color: const Color(0xFFDCDCDF),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("الاتصال بخدمة العملاء",
                style: const TextStyle(
                    fontFamily: 'pnuB',
                    fontSize: 20,
                    color: homeColor,
                    fontWeight: FontWeight.w200)),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ItemDialog(Icons.call, "اتصال", () {
                  pop(context);

                  launchUrl(Uri.parse("tel://$customerServiceNumber"));
                }),
                SizedBox(
                  width: 4,
                ),
                ItemDialog(Icons.whatsapp, "Whatsapp", () {
                  openWhatsapp(context, 0);
                }),
                SizedBox(
                  width: 4,
                ),
                ItemDialog(Icons.email, "Gmail", () {
                  launchUrl(Uri.parse(
                      "mailto:$emailService?subject=خدمة العملاء&body=مرحبا بك   "));
                })
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _bannerAd!.dispose();
  }
}
