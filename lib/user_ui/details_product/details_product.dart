import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/product_cubit/product_cubit.dart';
import 'package:awarake/helpers/functions.dart';
import 'package:awarake/user_ui/navigation_screen/navigation_screen.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../products_screen/products_screen.dart';
import '../show_photo_screen/photo_view_screen.dart';

class DetailsProduct extends StatefulWidget {
  final int id;

  DetailsProduct(this.id);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {


  BannerAd? _bannerAd;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getProductDetails(widget.id);
    getAdds(onAddLoaded: (ad) {
      setState(() {
        _bannerAd = ad as BannerAd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return CartCubit.get(context).carts.isNotEmpty
                    ? Badge(
                        position: BadgePosition.topStart(start: 1),
                        badgeContent: Text(
                          '${CartCubit.get(context).carts.length}',
                          style: TextStyle(color: Colors.white),
                        ),
                        child: FloatingActionButton.small(
                          backgroundColor: KYellowColor,
                          onPressed: () {
                            HomeCubit.get(context).changeNav(3, "السلة");
                            pushPage(
                                page: const NavigationScreen(),
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
            ),
            bottomSheet: ProductCubit.get(context).loadProduct
                ? const SizedBox()
                : BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      // TODO: implement listener

                    },
                    builder: (context, state) {
                      return Container(
                        height:_bannerAd != null?120: 80,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomButton3(
                                      text: "أضف الى عربة التسوق",
                                      fontFamily: "pnuB",
                                      onPress: () {
                                        if (CartCubit.get(context)
                                            .cartsFound
                                            .containsValue(ProductCubit.get(context)
                                                .product!
                                                .id)) {
                                          HelperFunction.slt.notifyUser(
                                              context: context,
                                              message: "المنتج موجود داخل السلة",
                                              color: homeColor);
                                        } else {
                                          // CartCubit.get(context).isCart();

                                          Cart cart = Cart(
                                              userId: currentUser.id,
                                              image: ProductCubit.get(context)
                                                  .product!
                                                  .image,
                                              orderId: 1,
                                              price: ProductCubit.get(context)
                                                  .product!
                                                  .price,
                                              nameProduct: ProductCubit.get(context)
                                                  .product!
                                                  .name,
                                              productId: ProductCubit.get(context)
                                                  .product!
                                                  .id,
                                              marketId: ProductCubit.get(context)
                                                  .product!
                                                  .categoryId,
                                              quantity: 1);

                                          if (CartCubit.get(context).marketIdCart !=
                                                  cart.marketId &&
                                              CartCubit.get(context).marketIdCart !=
                                                  0) {
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
                                                          padding:
                                                              EdgeInsets.symmetric(
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
                                                          Navigator.pop(context, 1);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                          "لا",
                                                          style: TextStyle(
                                                              fontFamily: "pnuM"),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context, 0);
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
                                              HomeCubit.get(context).getHomeData();
                                            });

                                            HelperFunction.slt.notifyUser(
                                                context: context,
                                                message: "تمت الاضافة  داخل السلة",
                                                color: homeColor);
                                          }
                                        }
                                      },
                                      width: double.infinity,
                                      redius: 10,
                                      color: CartCubit.get(context)
                                              .cartsFound
                                              .containsValue(
                                                  ProductCubit.get(context)
                                                      .product!
                                                      .id)
                                          ? Colors.grey.withOpacity(.5)
                                          : KYellow2Color,
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      height: 50),
                                ),
                              ],
                            ),
                         SizedBox(height: 10),
                         _bannerAd != null?
                            Container(
                              width: _bannerAd!.size.width.toDouble(),
                              height: _bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd!),
                            ):SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
            backgroundColor: Colors.white,
            body: ProductCubit.get(context).loadProduct
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: homeColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              pushPage(
                                  page: PhotoViewWidget(baseurlImage +
                                      ProductCubit.get(context)
                                          .product!
                                          .image!),
                                  context: context);
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 400,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: baseurlImage +
                                          ProductCubit.get(context)
                                              .product!
                                              .image!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: homeColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 40,
                                    right: 20,
                                    child: CircleButton(
                                      icon: Icons.arrow_back,
                                      onPress: () {
                                        pop(context);
                                      },
                                    ))
                              ],
                            ),
                          ),
                          DetailsProductName(
                              ProductCubit.get(context).product!),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    CustomText(
                                        family: "pnuB",
                                        size: 18,
                                        text: "السعر",
                                        textColor: KYellowColor,
                                        weight: FontWeight.bold,
                                        align: TextAlign.right),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "${ProductCubit.get(context).product!.price!}",
                                        style: const TextStyle(
                                            fontFamily: "pnuB",
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        children: const <TextSpan>[
                                          TextSpan(
                                              text: 'جنية',
                                              style: TextStyle(
                                                  fontFamily: "pnuB",
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    CustomText(
                                        family: "pnuB",
                                        size: 18,
                                        text: "الوصف",
                                        textColor: KYellowColor,
                                        weight: FontWeight.bold,
                                        align: TextAlign.right),
                                  ],
                                ),
                                CustomText(
                                    family: "pnuR",
                                    size: 20,
                                    text: ProductCubit.get(context)
                                        .product!
                                        .detail!,
                                    textColor: Colors.black.withOpacity(.5),
                                    weight: FontWeight.normal,
                                    align: TextAlign.start),
                                Divider()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    family: "pnuR",
                                    size: 18,
                                    text: "التفاصيل",
                                    textColor: KYellowColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        family: "pnuB",
                                        size: 14,
                                        text: ProductCubit.get(context)
                                            .marketModel!
                                            .name!,
                                        textColor: Colors.grey,
                                        weight: FontWeight.bold,
                                        align: TextAlign.right),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            family: "pnuB",
                                            size: 14,
                                            text: "العنوان : " +
                                                ProductCubit.get(context)
                                                    .marketModel!
                                                    .address!,
                                            textColor: Colors.blueAccent,
                                            weight: FontWeight.bold,
                                            align: TextAlign.right),
                                        InkWell(
                                            onTap: () {
                                              HelperFunction.slt
                                                  .openGoogleMapLocation(
                                                  ProductCubit.get(context)
                                                      .marketModel!.lat,
                                                  ProductCubit.get(context)
                                                      .marketModel!.lng);
                                            },
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            family: "pnuB",
                                            size: 14,
                                            text: "للتواصل : " +
                                                ProductCubit.get(context)
                                                    .marketModel!
                                                    .phone!,
                                            textColor: Colors.green,
                                            weight: FontWeight.bold,
                                            align: TextAlign.right),
                                        InkWell(
                                            onTap: () {
                                              launchUrl(
                                                  Uri.parse("tel://${ ProductCubit.get(context)
                                                      .marketModel!.phone}"));
                                            },
                                            child: Icon(
                                              Icons.call,
                                              size: 20,
                                              color: Colors.blue,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}

class DetailsProductName extends StatelessWidget {
  final Product product;

  const DetailsProductName(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  family: "pnuB",
                  size: 15,
                  text: product.name!,
                  textColor: Colors.black,
                  weight: FontWeight.bold,
                  align: TextAlign.center),
              const SizedBox(height: 5),
              // const CustomText(
              //     family: "pnuB",
              //     size: 15,
              //     text: "product product ",
              //     textColor: Colors.black,
              //     weight: FontWeight.bold,
              //     align: TextAlign.center),
              const SizedBox(height: 5),
            ],
          ),
        )),
        SizedBox(
          width: 100,
          child: Column(
            children: [
              product.offerId == 1
                  ? Container(
                      height: 50,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: KYellowColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                                family: "pnuB",
                                size: 13,
                                text: "بدلا من ${product.offerPrice}",
                                textColor: Colors.white,
                                weight: FontWeight.bold,
                                align: TextAlign.center),
                            SizedBox(
                              width: 1,
                            ),
                            Icon(
                              Icons.local_offer_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              const SizedBox(
                height: 20,
              ),

              // CustomText(
              //    family: "pnuB",
              //    size: 20,
              //    text: ,
              //    textColor: Colors.black,
              //    weight: FontWeight.bold,
              //    align: TextAlign.center),
            ],
          ),
        )
      ],
    );
  }
}
