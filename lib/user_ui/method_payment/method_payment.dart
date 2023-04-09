import 'dart:io';

import 'package:awarake/user_ui/my-address_screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/address_cubit/address_cubit.dart';
import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../bloc/order_cubit/order_cubit.dart';
import '../../helpers/add_helper.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/router.dart';
import '../../helpers/styles.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../models/address.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_widget.dart';

class MethodPaymentScreen extends StatefulWidget {
  final double total;

  MethodPaymentScreen({required this.total});

  @override
  State<MethodPaymentScreen> createState() => _MethodPaymentScreenState();
}

class _MethodPaymentScreenState extends State<MethodPaymentScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    MyAddresses(),
    PaymentMethodSetpp(),
    ConfirmOrder()
  ];
  BannerAd? _bannerAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdds(
      onAddLoaded:
            (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            // backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "طريقة الدفع",
              style: TextStyle(color: Colors.white, fontFamily: "pnuR"),
            ),
          ),
          bottomSheet:  _bannerAd != null?
          Container(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ):SizedBox(),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildContainerStepper(),
                Expanded(
                    child: IndexedStack(
                  index: OrderCubit.get(context).currentIndex,
                  children: _screens,
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildContainerStepper() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // OrderCubit.get(context).changeStepperOrder(0);
            },
            child: const CustomStepperContainer(
                text: "بيانات العنوان", isDone: true, number: "1"),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            width: double.infinity,
            color: homeColor,
          )),
          const SizedBox(
            width: 4,
          ),
          InkWell(
              onTap: () {
                // OrderCubit.get(context).changeStepperOrder(1);
              },
              child: CustomStepperContainer(
                  number: "2",
                  text: "طريقة الدفع",
                  isDone: (OrderCubit.get(context).currentIndex == 1 ||
                          OrderCubit.get(context).currentIndex == 2)
                      ? true
                      : false)),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            width: double.infinity,
            color: homeColor,
          )),
          const SizedBox(
            width: 4,
          ),
          InkWell(
              onTap: () {
                // OrderCubit.get(context).changeStepperOrder(2);
              },
              child: CustomStepperContainer(
                  number: "3",
                  text: "التاكيد",
                  isDone: OrderCubit.get(context).currentIndex == 2
                      ? true
                      : false)),
        ],
      ),
    );
  }
}

class ConfirmOrder extends StatefulWidget {
  ConfirmOrder();

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInterstitialAd(context: context);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget3(
                  color: homeColor,
                  fontSize: 20,
                  text: "تأكيد الطلب",
                  fontFamliy: "pnuB",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                OrderCubit.get(context).loadAddOrder
                    ? const SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: homeColor,
                          ),
                        ),
                      )
                    : CustomButton3(
                        text: "تأكيد الطلب",
                        fontFamily: "PNUB",
                        onPress: () {
                          // OrderCubit.get(context).changeStepperOrder(2);
                          printFunction(
                              AddressCubit.get(context).selectedRadio);
                          printFunction(CartCubit.get(context).total);
                          //

                          OrderCubit.get(context)
                              .addOrder(
                                  price: CartCubit.get(context).total,
                                  onSuccess: (orderId) {
                                    HelperFunction.slt.notifyUser(
                                        context: context,
                                        color: homeColor,
                                        message: "تم ارسال طلبك ");
                                    if(interstitialAd!=null){
                                      interstitialAd!.show();
                                    }else{
                                      OrderCubit.get(context)
                                          .changeStepperOrder(0);
                                      CartCubit.get(context).getCarts();
                                      Navigator.pushNamed(context, nav);
                                    }

                                  },
                                  addressId:
                                      AddressCubit.get(context).selectedRadio)
                              .then((value) {});

                          // HelperFunction.slt.notifyUser(context: context,color: homeColor,message: "تم ارسال طلبك ");
                          // pop(context);
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
              ],
            ),
          ),
        );
      },
    );
  }


  InterstitialAd? interstitialAd;
  // TODO: Implement _loadInterstitialAd()
  loadInterstitialAd({context}) {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad){
              OrderCubit.get(context)
                  .changeStepperOrder(0);
              CartCubit.get(context).getCarts();
              Navigator.pushNamed(context, nav);
            },
          );




        },
        onAdFailedToLoad:(error){
          print(error.message+"adds");
        } ,

      ),
    );
  }
}

class PaymentMethodSetpp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton3(
                        text: "اكمال الطلب ",
                        fontFamily: "PNUB",
                        onPress: () {
                          OrderCubit.get(context).changeStepperOrder(2);
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton3(
                        text: "الاتصال بخدمة العملاء",
                        fontFamily: "PNUB",
                        onPress: () {
                          HelperFunction.slt
                              .showSheet(context, dailogSelectCall(context));

                          // OrderCubit.get(context)
                          //     .addOrder(
                          //     price: CartCubit.get(context).total,
                          //     onSuccess: (orderId){
                          //
                          //
                          //       // HelperFunction.slt.notifyUser(
                          //       //     context: context,
                          //       //     color: homeColor,
                          //       //     message: "تم ارسال طلبك ");
                          //       // OrderCubit.get(context).changeStepperOrder(0);
                          //       CartCubit.get(context).getCarts();
                          //       // Navigator.pushNamed(context, nav);
                          //       openWhatsapp(context,orderId).then((value){
                          //         OrderCubit.get(context).changeStepperOrder(0);
                          //         Navigator.pushNamed(context, nav);
                          //       });
                          //     },
                          //     addressId:
                          //     AddressCubit.get(context).selectedRadio)
                          //     .then((value) {
                          //
                          // });
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyAddresses extends StatefulWidget {
  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  int selectedRadio = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressCubit.get(context).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return AddressCubit.get(context).loadGetAddresses
            ? const Center(
                child: CircularProgressIndicator(
                  color: homeColor,
                  strokeWidth: 3,
                ),
              )
            : AddressCubit.get(context).addresses.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton3(
                          text: "أضف عنوان جديد",
                          fontFamily: "PNUB",
                          onPress: () {
                            pushPage(
                                context: context,
                                page: MapScreen(
                                    lable: "",
                                    latitude: "",
                                    longitude: "",
                                    addressId: 1,
                                    status: 0,
                                    detailsAddress: "",
                                    address: Address()));
                          },
                          redius: 10,
                          color: homeColor,
                          textColor: Colors.white,
                          fontSize: 18,
                          height: 50),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Stack(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 95),
                              child: ListView.builder(
                                  itemCount: AddressCubit.get(context)
                                      .addresses
                                      .length,
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.2, color: Colors.green)),
                                      margin: const EdgeInsets.all(20),
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/pin.png',
                                                height: 30,
                                                fit: BoxFit.fill,
                                              ),
                                              const SizedBox(
                                                width: 13,
                                              ),
                                              Texts(
                                                title: AddressCubit.get(ctx)
                                                    .addresses[index]
                                                    .lable,
                                                fSize: 18,
                                                color: Colors.black,
                                                weight: FontWeight.w300,
                                              ),
                                              Expanded(child: Container()),
                                              Radio<int>(
                                                activeColor: homeColor,
                                                value: AddressCubit.get(context)
                                                    .addresses[index]
                                                    .id!,
                                                groupValue:
                                                    AddressCubit.get(context)
                                                        .selectedRadio,
                                                onChanged: (int? value) {
                                                  AddressCubit.get(context)
                                                      .changeValue(value!);
                                                  print(value);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          ),

                                          // if(AddressProvider.getInItRead(context).addresses.length>1)
                                        ],
                                      ),
                                    );
                                  })),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 9),
                                    child: TextButton(
                                      onPressed: () {
                                        pushPage(
                                            context: context,
                                            page: MapScreen(
                                                lable: "",
                                                latitude: "",
                                                longitude: "",
                                                addressId: 1,
                                                status: 0,
                                                detailsAddress: "",
                                                address: Address()));
                                      },
                                      child: Text(
                                          "اضافة عنوان جديد",
                                        style: TextStyle(
                                          fontFamily: "PNUB",
                                          color: homeColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ),

                                  CustomButton3(
                                      text: "التالى",
                                      fontFamily: "PNUB",
                                      onPress: () {
                                        if (AddressCubit.get(context)
                                                .selectedRadio ==
                                            0) {
                                          HelperFunction.slt.notifyUser(
                                              color: homeColor,
                                              context: context,
                                              message:
                                                  "من فضلك اختار عنوان توصيل ");
                                        } else {
                                          OrderCubit.get(context)
                                              .changeStepperOrder(1);
                                        }
                                      },
                                      redius: 10,
                                      color: homeColor,
                                      textColor: Colors.white,
                                      fontSize: 18,
                                      height: 50),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}

class CustomStepperContainer extends StatelessWidget {
  final String text, number;
  final bool isDone;

  const CustomStepperContainer(
      {required this.text, required this.isDone, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: isDone ? homeColor : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: homeColor, width: 1)),
          child: Center(
            child: isDone
                ? const Icon(
                    Icons.done,
                    color: Colors.white,
                  )
                : Text(
                    number,
                    style: const TextStyle(
                      color: homeColor,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            family: "pnuB",
            size: 12,
            text: text,
            textColor: homeColor,
            weight: FontWeight.w300,
            align: TextAlign.center)
      ],
    );
  }
}

Future openWhatsapp(BuildContext context, int number) async {
  var whatsapp = "+20$customerServiceNumberWhats";
  var whatsappURl_android = number==0?
  "whatsapp://send?phone=" +
      whatsapp +
      "&text=مرحبا بك"

      :
  "whatsapp://send?phone=" +
      whatsapp +
      "&text=مرحبا بك احدثك بخصوص طلب رقم $number";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}

dailogSelectCall(BuildContext context){
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
            height: 30,
          ),
          const SizedBox(height: 10),
          Row(

            children: [
            ItemDialog(Icons.call, "اتصال", () {
              pop(context);

           OrderCubit.get(context)
                  .addOrder(
                  price: CartCubit.get(context).total,
                  onSuccess: (orderId){

                    pop(context);
                    // HelperFunction.slt.notifyUser(
                    //     context: context,
                    //     color: homeColor,
                    //     message: "تم ارسال طلبك ");
                    // OrderCubit.get(context).changeStepperOrder(0);
                    CartCubit.get(context).getCarts();
                    // Navigator.pushNamed(context, nav);
                    launchUrl(Uri.parse("tel://0 112 128 8341")).then((value){
                      OrderCubit.get(context).changeStepperOrder(0);
                      Navigator.pushNamed(context, nav);
                    });
                  },
                  addressId:
                  AddressCubit.get(context).selectedRadio)
                  .then((value) {

              });

            }),
              SizedBox(width: 4,),
              ItemDialog(Icons.whatsapp, "Whatsapp", () {


                OrderCubit.get(context)
                    .addOrder(
                    price: CartCubit.get(context).total,
                    onSuccess: (orderId){

                      pop(context);
                      // HelperFunction.slt.notifyUser(
                      //     context: context,
                      //     color: homeColor,
                      //     message: "تم ارسال طلبك ");
                      // OrderCubit.get(context).changeStepperOrder(0);
                      CartCubit.get(context).getCarts();
                      // Navigator.pushNamed(context, nav);
                      openWhatsapp(context,orderId).then((value){
                        OrderCubit.get(context).changeStepperOrder(0);
                        Navigator.pushNamed(context, nav);
                      });
                    },
                    addressId:
                    AddressCubit.get(context).selectedRadio)
                    .then((value) {

                });


              }),
              SizedBox(width: 4,),
              ItemDialog(Icons.email, "Gmail", () {


                OrderCubit.get(context)
                    .addOrder(
                    price: CartCubit.get(context).total,
                    onSuccess: (orderId){

                      pop(context);
                      // HelperFunction.slt.notifyUser(
                      //     context: context,
                      //     color: homeColor,
                      //     message: "تم ارسال طلبك ");
                      // OrderCubit.get(context).changeStepperOrder(0);
                      CartCubit.get(context).getCarts();
                      // Navigator.pushNamed(context, nav);
                      launchUrl(Uri.parse("mailto:awamrakawamrak@gmail.com?subject=خدمة العملاء&body=مرحبا بك أحدثك بخصوص طلب رقم $orderId")).then((value){
                        OrderCubit.get(context).changeStepperOrder(0);
                        Navigator.pushNamed(context, nav);
                      });
                    },
                    addressId:
                    AddressCubit.get(context).selectedRadio)
                    .then((value) {

                });



              })
            ],
          )
        ],
      ),
    ),
  );

}

class ItemDialog extends StatelessWidget {
final IconData iconData;
final String title;
final void Function() onPress;


ItemDialog(this.iconData, this.title, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        elevation: 0,
        height: 170,


        onPressed: onPress,
          color: const Color(0xFFF6F2F2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

        ),



        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                iconData,
                size: 30,
                color: homeColor,
              ),
              const SizedBox(height: 10),
              TextWidget3(
                  alginText: TextAlign.start,
                  isCustomColor: true,
                  text: title,
                  fontFamliy: "pnuL",
                  fontSize: 18,
                  color: textColor.withOpacity(.5))
            ],
          ),
        ),
      ),
    );
  }
}

