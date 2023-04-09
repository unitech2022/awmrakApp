

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/address_cubit/address_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/address.dart';
import '../../widgets/Texts.dart';
import 'map_screen.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final key = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressCubit.get(context).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff6A644C),
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),

            title: const Text("عناوين التوصيل",
                style: TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 18,
                  color: Colors.white,
                )),
          ),
          bottomSheet: Container(
            height: 100,
            color:  const Color(0xff6A644C),
            child: InkWell(
              onTap: () async {
               await pushPage(context: context, page:  MapScreen(
                   lable: "",
                   latitude: "",
                   longitude: "",
                   addressId:1,
                   status: 0,
                   detailsAddress: "",
                   address:Address()));

                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Texts(
                    title: 'إضافة عنوان جديد',
                    fSize: 22,
                    familay: "pnuB",
                    weight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: AddressCubit
              .get(context)
              .loadGetAddresses
              ? const Center(
            child: CircularProgressIndicator(
              color: homeColor,
              strokeWidth: 3,
            ),
          )
              : AnimatedList(
              key: key,
              padding: const EdgeInsets.only(
                  left: 18, top: 19, right: 18, bottom: 150),
              initialItemCount: AddressCubit
                  .get(context)
                  .addresses
                  .length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i, animation) {
                Address address = AddressCubit
                    .get(context)
                    .addresses[i];
                return ScaleTransition(
                  scale: animation,

                  child: InkWell(
                    onTap: () {
                      // HelperFunctions.slt.openGoogleMapLocation(address.lat, address.lng);
                    },
                    child: Container(
                      height: 210,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 0.2, color: Colors.green)),
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${address
                                    .lat.toString()},${address.lng
                                    .toString()}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4',
                                height: 105,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
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
                                      title: address.lable,
                                      fSize: 18,
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!,
                                      weight: FontWeight.w300,
                                    ),
                                  ],
                                ),

                                // if(AddressProvider.getInItRead(context).addresses.length>1)

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // showDialogDeleteCar(address.id!,address.lable!);
                                        Address address =
                                        AddressCubit
                                            .get(context)
                                            .addresses
                                            .removeAt(i);

                                        key.currentState!.removeItem(i,
                                                (context, animation) {
                                              return buildItemAddress(
                                                  animation, address, i);
                                            });
                                        AddressCubit.get(context)
                                            .deleteAddress(address.id!);
                                      },
                                      child: const Text(
                                        "حذف العنوان",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          decoration:
                                          TextDecoration.underline,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await pushPage(context: context,
                                            page: MapScreen(
                                                lable: address.lable!,
                                                latitude: address.lat,
                                                longitude: address.lng,
                                                addressId: address.id!,
                                                status: 1,
                                                detailsAddress: "",
                                                address:address));
                                        // if(result!=null){
                                        //   HelperFunction.slt.notifyUser(
                                        //       context: context,
                                        //       message: "تم تحديث العنوان بنجاح",
                                        //       color: Colors.black45);
                                        // }
                                      },
                                      child: const Text(
                                        "تعديل العنوان",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration:
                                          TextDecoration.underline,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  ScaleTransition buildItemAddress(Animation<double> animation, Address address,
      int i) {
    return ScaleTransition(
      scale: animation,
      child: InkWell(
        onTap: () {
          // HelperFunctions.slt.openGoogleMapLocation(address.lat, address.lng);
        },
        child: Container(
          height: 210,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.green)),
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    'https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${address
                        .lat.toString()},${address.lng
                        .toString()}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4',
                    height: 105,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          title: address.lable,
                          fSize: 18,
                          color: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .color!,
                          weight: FontWeight.w300,
                        ),
                      ],
                    ),

                    // if(AddressProvider.getInItRead(context).addresses.length>1)

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // showDialogDeleteCar(address.id!,address.lable!);
                          },
                          child: const Text(
                            "حذف العنوان",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // var result =  await   pushPage(context: context,page: UpdateAddressScreen(lable: address.lable,
                            //   latitude: address.lat,longitude: address.lng,addressId: address.id,));
                            // if(result!=null){
                            //   HelperFunction.slt.notifyUser(
                            //       context: context,
                            //       message: "تم تحديث العنوان بنجاح",
                            //       color: Colors.black45);
                            // }
                          },
                          child: const Text(
                            "تعديل العنوان",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDialogDeleteCar(int i, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Texts(
              fSize: 14,
              color: homeColor,
              title: name,
              weight: FontWeight.bold),
          content: Texts(
              fSize: 12,
              color: Colors.black,
              title: "هل أنت متأكد من أنك تريد حذف هذه العنوان",
              weight: FontWeight.bold),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("حذف", style: TextStyle(color: Colors.black)),
              onPressed: () {
                // AddressProvider.getInItRead(context).deleteAddress(context,i.toString());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("الغاء"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
