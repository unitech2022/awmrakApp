import 'package:awarake/user_ui/details_product/details_product.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/order_cubit/order_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/cart.dart';
import '../../widgets/text_widget.dart';
import 'orders_screen.dart';


class DetailsOrder extends StatefulWidget {
  final int id;

  const DetailsOrder(this.id);

  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).getOrderDetails(orderId: widget.id);
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
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),

            title: Text(" طلب رقم ${widget.id} ",
                style: const TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 18,
                  color: Colors.white,
                )),
          ),
          body: OrderCubit.get(context).loadOrderDetails
              ? const Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                    strokeWidth: 3,
                  ),
                )
              : ListView.builder(
                  itemCount: OrderCubit.get(context).orderDetail.length,
                  itemBuilder: (_, i) {
                    Cart cart = OrderCubit.get(context).orderDetail[i];
                    return GestureDetector(
                      onTap: (){
                        pushPage(page: DetailsProduct(cart.productId!),context: context);
                      },
                      child: Container(
                        height: 80,
                        padding: paddingSymmetric(hor: 20, ver: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: baseurlImage + cart.image!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget2(
                                        width: 140,
                                        alginText: TextAlign.start,
                                        isCustomColor: true,
                                        text: cart.nameProduct!,
                                        fontFamliy: "pnuB",
                                        fontSize: 12,
                                        color: Colors.black),

                                  ],
                                ),
                                RichTextOrder(
                                  value: cart.quantity.toString(),
                                  lable: "عدد ",
                                ),
                              ],
                            ),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: " ${cart.total} جنية",
                                fontFamliy: "pnuB",
                                fontSize: 20,
                                color: priceColor),
                          ],
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
