import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/order_cubit/order_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/order.dart';
import 'details_order.dart';




class Status {

  int id;
  String name;

  Status(this.id, this.name);

}


List<Status> listStatus = [
  Status(0, "جارى التنفيذ"),
  Status(1, "جارى التوصيل"),
  Status(2, "تم الاستلام"),
  Status(3, "تم الانتهاء"),


];
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}


class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: AppBar(
            //   // leading: IconButton(
            //   //   onPressed: () {
            //   //     pop(context);
            //   //   },
            //   //   icon: const Icon(
            //   //     Icons.arrow_back,
            //   //     color: homeColor,
            //   //   ),
            //   // ),
            //   backgroundColor: Colors.white,
            //   title: const Text("طلباتى",
            //       style: TextStyle(
            //         fontFamily: 'pnuB',
            //         fontSize: 18,
            //         color: Colors.white,
            //       )),
            // ),
            body: OrderCubit.get(context).loadOrders
                ? const Center(
              child: CircularProgressIndicator(
                color: homeColor,
                strokeWidth: 3,
              ),
            )
                : RefreshIndicator(

                  onRefresh: () async{

                    OrderCubit.get(context).getOrders();
                  },
                  child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  itemCount: OrderCubit.get(context).newOrders.length,
                  itemBuilder: (_, i) {
                    Order order = OrderCubit.get(context).newOrders[i];

                    DateTime now = DateTime.parse(order.createdAt.toString());
                    String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichTextOrder(
                                value: "${order.id}",
                                lable: "رقم الطلب : ",
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichTextOrder(
                                value: order.price.toString(),
                                lable: "المبلغ الكلي  : ",
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichTextOrder(
                                value: listStatus[order.status!].name,
                                lable: "حالة الطلب : ",
                                color:order.status==0? Colors.green
                                  :order.status==1?Colors.red:Colors.brown,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichTextOrder(
                                value: formattedDate,
                                lable: "تاريح الطلب : ",
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                          TextButton(onPressed: () {
                            pushPage(
                                context: context,page: DetailsOrder(order.id!)
                            );

                          }, child: const Text(
                            "تفاصيل الطلب",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontFamily: "pnuB"
                                ,
                                fontWeight: FontWeight.bold
                            ),
                          ))
                        ],
                      ),
                    );
                  }),
                ));
      },
    );
  }
}

class RichTextOrder extends StatelessWidget {
  final String lable, value;
   Color color;

  RichTextOrder({required this.lable, required this.value, this.color=Colors.black});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: lable,
        style: TextStyle(
            fontSize: 14,
            fontFamily: "pnuR",
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(.5)),
        children: [
          TextSpan(
              text: value,
              style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "pnuR",
                  color: color,
                  fontSize: 14)),
        ],
      ),
    );
  }
}
