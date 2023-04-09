import 'package:awarake/bloc/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/styles.dart';
import '../../models/product.dart';
import '../products_screen/products_screen.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {

  final ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getOffersPagination(page: 1);

    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        if (page >= ProductCubit.get(context).responseProducts!.totalPage!) {
          return;
        } else {
          page++;

          ProductCubit.get(context).pagination(

              page: page);
        }



      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        body: ProductCubit.get(context).loadOffers
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: homeColor,
                ),
              )
            : Stack(
              children: [
                ListView.builder(
                controller: _controller,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  // shrinkWrap: true,
                  // physics: const BouncingScrollPhysics(),
                  itemCount: ProductCubit.get(context).newList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product category =
                    ProductCubit.get(context).newList[index];
                    return ItemProduct(category: category);
                  },
                ),

                ProductCubit.get(context).loadingPage
                    ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),
                        color: Colors.black.withOpacity(.5),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )):SizedBox()
              ],
            ),
      );
    });
  }
}
