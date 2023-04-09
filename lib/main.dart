import 'package:awarake/bloc/cart_cubite/cart_cubit.dart';
import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/markets_cubit/markets_cubit.dart';
import 'package:awarake/bloc/notification_cubit/notification_cubit.dart';
import 'package:awarake/bloc/order_cubit/order_cubit.dart';
import 'package:awarake/bloc/product_cubit/product_cubit.dart';
import 'package:awarake/helpers/router.dart';
import 'package:awarake/user_ui/navigation_screen/navigation_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'bloc/address_cubit/address_cubit.dart';
import 'bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'helpers/functions.dart';
import 'helpers/styles.dart';
import 'main_ui/login_screen/login_screen.dart';
import 'main_ui/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // NotifyAowsome(notification!.title!,notification.body!);
  // if (notification != null && android != null && !kIsWeb) {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //     id: createUniqueId(),
  //
  //     color: homeColor,
  //     icon: 'resource://drawable/ic_launcher',
  //
  //     channelKey: 'key1',
  //     title:
  //         '${Emojis.money_money_bag + Emojis.plant_cactus}${notification.title}',
  //     body: notification.body,
  //     bigPicture:
  //         "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  //     notificationLayout: NotificationLayout.BigPicture,
  //     // largeIcon: "asset://assets/images/logo_final.png"
  //   ));
  //
  //   print('background message ${message.notification!.body}');
  // }
}

AndroidNotificationChannel? channel =
AndroidNotificationChannel("key1", "chat");

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;
await readToken();


  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'chat',
      channelDescription: "Notification example",
      defaultColor: Colors.transparent,
      ledColor: Colors.blue,
      channelShowBadge: true,
      importance: NotificationImportance.High,
      // playSound: true,
      // enableLights:true,
      // enableVibration: false
    )
  ]);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: Phoenix(child: const MyApp())),
  );
}

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>(debugLabel: "Main Navigator");
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
        BlocProvider<MarketsCubit>(create: (BuildContext context) => MarketsCubit()),
        BlocProvider<ProductCubit>(create: (BuildContext context) => ProductCubit()),
        BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
        BlocProvider<OrderCubit>(create: (BuildContext context) => OrderCubit()),
        BlocProvider<AddressCubit>(create: (BuildContext context) => AddressCubit()),
        BlocProvider<NotificationCubit>(create: (BuildContext context) => NotificationCubit()),
      ],
      child: MaterialApp(
        key: navigatorKey,
        title: 'أوامراك',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primarySwatch: Colors.blue,
          appBarTheme:
          const AppBarTheme(
              backgroundColor: const Color(0xff6A644C),
              systemOverlayStyle: SystemUiOverlayStyle())),
      initialRoute:splash,
      routes: {
        splash: (context) => const SplashScreen(),
   login: (context) =>  LoginScreen(),
        // // "signUp": (context) => SignUpScreen(),
        // HomeScreen.id: (context) => const HomeScreen(),
        nav: (context) => const NavigationScreen(),
        // categ: (context) => CategoryScreen(),
        //
        // cars: (context) => MyCarsScreen(),
        // addCar: (context) => AddCarScreen(),
        // edit: (context) => EditMyProfileScreen(),
        // // details: (context) => DetailsProductScreen(),
        // orderProduct: (context) => OrderingProduct(),
        //
        // myAddress: (context) =>  const MyAddressScreen(),
        // myOrders: (context) =>  const MyOrdersScreen(),
        // fav: (context) =>   MyFavoriteScreen(),
      } ),
    );
  }
}

