import 'package:awarake/helpers/helper_function.dart';
import 'package:awarake/main_ui/splash_screen/componts/body_splash.dart';
import 'package:awarake/models/market.dart';
import 'package:awarake/user_ui/details_product/details_product.dart';
import 'package:awarake/user_ui/show_photo_screen/photo_view_screen.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../widgets/Texts.dart';
import '../../widgets/draw/clipper_path.dart';
import '../navigation_screen/navigation_screen.dart';

class ProductsScreen extends StatefulWidget {
  final MarketModel model;

  ProductsScreen(this.model);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getProductsByCategory(widget.model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            body: ProductCubit.get(context).load
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: homeColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            pushPage(
                                page:
                                PhotoViewWidget(baseurlImage +  widget.model.image!),
                                context: context);
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.only(
                              //   bottomLeft: Radius.circular(55),
                              //   bottomRight: Radius.circular(55),
                              // ),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  // borderRadius: const BorderRadius.only(
                                  //   bottomLeft: Radius.circular(55),
                                  //   bottomRight: Radius.circular(55),
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: baseurlImage + widget.model.image!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Center(
                                      child: Container(
                                          width: 25,
                                          height: 25,
                                          child: const CircularProgressIndicator(
                                            color: Colors.green,
                                          )),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                        height: 100,
                                        child: const Center(
                                            child: Icon(
                                          Icons.error,
                                          size: 25,
                                        ))),
                                  ),
                                ),

                                Positioned(
                                    top: 40,
                                    right: 20,
                                    child:

                                CircleButton(
                                  icon: Icons.arrow_back,onPress: (){
                                    pop(context);
                                },
                                ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(widget.model.name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'pnuB',
                                fontSize: 20,
                                height: 1.2,
                                color: homeColor,

                                fontWeight: FontWeight.w200)),
                        SizedBox(height: 15,),
                        Text(widget.model.details!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'pnuB',
                                fontSize: 14,
                                height: 1.2,
                                color: homeColor.withOpacity(.5),
                                fontWeight: FontWeight.w200)),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Text("تفاصيل المحل",
                                      style: TextStyle(
                                          fontFamily: 'pnuB',
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ConatinerDetailsMarket(
                                title: "العنوان : ",
                                onPress: () {
                                  HelperFunction.slt.openGoogleMapLocation(
                                      widget.model.lat, widget.model.lng);
                                },
                                value: widget.model.address!,
                                icon: Icons.location_on_outlined,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ConatinerDetailsMarket(
                                title: "رقم الهاتف : ",
                                onPress: () {
                                  launchUrl(
                                      Uri.parse("tel://${widget.model.phone}"));
                                },
                                value: widget.model.phone!,
                                icon: Icons.call,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("المنتجات",
                                  style: TextStyle(
                                      fontFamily: 'pnuB',
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200)),
                              BlocConsumer<CartCubit, CartState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  return CartCubit.get(context).carts.isNotEmpty
                                      ? Badge(
                                          position:
                                              BadgePosition.topStart(start: 1),
                                          badgeContent: Text(
                                            '${CartCubit.get(context).carts.length}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          child: FloatingActionButton.small(
                                            backgroundColor: KYellowColor,
                                            onPressed: () {
                                              HomeCubit.get(context)
                                                  .changeNav(3, "السلة");
                                              pushPage(
                                                  page:
                                                      const NavigationScreen(),
                                                  context: context);
                                            },
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : SizedBox();
                                },
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ProductCubit.get(context).products.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product category =
                                ProductCubit.get(context).products[index];
                            return ItemProduct(category: category);
                          },
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}

class CircleButton extends StatelessWidget {
final void Function() onPress;
final IconData icon;


CircleButton({required this.onPress, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(.5)
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ConatinerDetailsMarket extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final void Function() onPress;

  ConatinerDetailsMarket(
      {required this.title,
      required this.value,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: const TextStyle(
                fontFamily: 'pnuB',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w200)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w200)),
        ),
        InkWell(
            onTap: onPress,
            child: Icon(
              icon,
              size: 20,
              color: Colors.blue,
            ))
      ],
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Product category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // pushPage(context:context,page:CategoryScreen(category));
        pushPage(page: DetailsProduct(category.id!), context: context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 120,
        width: double.infinity,
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(1.0),
          child: Stack(
            children: [
              category.offerId == 1
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        color: Colors.red,
                        height: 45,
                        width: 30,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                category.offerPrice.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "pnuB",
                                  fontSize: 15,
                                  height: 1.2,
                                  decorationColor: Colors.black,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        pushPage(
                            page:
                                PhotoViewWidget(baseurlImage + category.image!),
                            context: context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: baseurlImage + category.image!,
                          height: double.infinity,
                          width: 100,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                            child: Container(
                                width: 25,
                                height: 25,
                                child: const CircularProgressIndicator(
                                  color: Colors.green,
                                )),
                          ),
                          errorWidget: (context, url, error) => Container(
                              height: 100,
                              child: const Center(
                                  child: Icon(
                                Icons.error,
                                size: 25,
                              ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name!,
                            maxLines: 1,
                            style: const TextStyle(
                                height: 1.20,
                                fontFamily: "pnuB",
                                color: Colors.black),
                          ),
                          Text(
                            category.detail!,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "pnuR",
                                height: 1.20,
                                color: Colors.black.withOpacity(.6)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.price!.toString() + "  جنية ",
                                maxLines: 2,
                                style: const TextStyle(
                                    fontFamily: "pnuB",
                                    height: 1.20,
                                    color: Colors.red),
                              ),
                              BlocConsumer<CartCubit, CartState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  return IconButton(
                                      onPressed: () {
                                        Cart cart = Cart(
                                            userId: currentUser.id,
                                            image: category.image,
                                            orderId: 1,
                                            price: category.price,
                                            nameProduct: category.name,
                                            productId: category.id,
                                            marketId: category.categoryId,
                                            quantity: 1);

                                        if (CartCubit.get(context)
                                                .marketIdCart !=
                                            category.categoryId &&CartCubit.get(context).marketIdCart !=0) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              // return object of type Dialog
                                              return Container(
                                                width: 250,
                                                child: AlertDialog(
                                                  title: Texts(
                                                      fSize: 16,
                                                      color: Colors.red,
                                                      familay: "pnuB",
                                                      title:
                                                          "لايمكن ارسال الطلب لاكثر من محل ",
                                                      weight: FontWeight.bold),
                                                  content: Texts(
                                                      fSize: 14,
                                                      familay: "pnuR",
                                                      color: Colors.black,
                                                      title:
                                                          "هل تريد حذف السلة واضافة هذا المنتج ؟",
                                                      weight: FontWeight.bold),
                                                  actions: <Widget>[
                                                    // usually buttons at the bottom of the dialog
                                                    MaterialButton(
                                                      minWidth: 50,
                                                      color: Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 2),
                                                        child: Text("نعم",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "pnuM",
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 1);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        "لا",
                                                        style: TextStyle(
                                                            fontFamily: "pnuM"),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 0);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).then((value) {
                                            print(value);
                                            if (value == null) {
                                              return;
                                            } else if (value == 1) {
                                              CartCubit.get(context)
                                                  .addCart(cart)
                                                  .then((value) {
                                                HomeCubit.get(context)
                                                    .getHomeData();
                                              });

                                              HelperFunction.slt.notifyUser(
                                                  context: context,
                                                  message:
                                                      "تمت الاضافة  داخل السلة",
                                                  color: homeColor);
                                            }
                                          });
                                        } else {
                                          CartCubit.get(context)
                                              .addCart(cart)
                                              .then((value) {
                                            HomeCubit.get(context)
                                                .getHomeData();
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        CartCubit.get(context)
                                                .cartsFound
                                                .containsValue(category.id)
                                            ? Icons.shopping_cart
                                            : Icons.shopping_cart_outlined,
                                        color: homeColor,
                                      ));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*
*
*
*  child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: baseurlImage + category.image!,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          Center(
                                            child: Container(
                                                width: 25,
                                                height: 25,
                                                child: const CircularProgressIndicator(
                                                  color: Colors.green,
                                                )),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              height: 100,
                                              child: const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    size: 25,
                                                  ))),
                                    ),
                                    // Container(
                                    //   // decoration: BoxDecoration(
                                    //   //
                                    //   //   // gradient: LinearGradient(
                                    //   //   //   colors: [
                                    //   //   //     Colors.transparent,
                                    //   //   //     Colors.black.withOpacity(0.2),
                                    //   //   //     Colors.black.withOpacity(0.4),
                                    //   //   //   ],
                                    //   //   //   begin: Alignment.topCenter,
                                    //   //   //   end: Alignment.bottomCenter,
                                    //   //   // ),
                                    //   // ),
                                    // ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          color: Colors.black.withOpacity(.5),
                                          width: 180,
                                          height: 60,
                                          child:,
                                        ))
                                  ],
                                ),*/
