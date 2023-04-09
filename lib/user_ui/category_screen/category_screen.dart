import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/markets_cubit/markets_cubit.dart';
import 'package:awarake/models/home_model.dart';

import 'package:awarake/models/market.dart';
import 'package:awarake/user_ui/products_screen/products_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen(this.category);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketsCubit.get(context)
        .getMarketsPagination(catId: widget.category.id, page: 1);
    HomeCubit.get(context).governorate = null;
    HomeCubit.get(context).currentCity = null;
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        if (page >= MarketsCubit.get(context).marketsPagination!.totalPage!) {
          return;
        } else {
          page++;
        }

        if (HomeCubit.get(context).currentCity == null) {
          MarketsCubit.get(context)
              .pagination(catId: widget.category.id, page: page);
        } else {
          MarketsCubit.get(context).pagination(
              catId: widget.category.id,
              page: page,
              city: HomeCubit.get(context).currentCity);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketsCubit, MarketsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            MarketsCubit.get(context)
                .getMarketsPagination(catId: widget.category.id, page: 1);
            page=1;
          },
          child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: const Color(0xff6A644C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(widget.category.name!,
                        style: TextStyle(
                            fontFamily: 'pnuB',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),

                  ],
                ),
              ),
              body: Column(
                children: [
                  BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CustomDropDownWidget(
                                      currentValue:
                                          HomeCubit.get(context).governorate,
                                      selectCar: false,
                                      textColor: Colors.black26,
                                      isTwoIcons: false,
                                      iconColor: const Color(0xff515151),
                                      list: HomeCubit.get(context).governorates,
                                      onSelect: (dynamic value) {
                                        if (value.id == "0") {
                                          MarketsCubit.get(context)
                                              .getMarketsPagination(
                                                  catId: widget.category.id,
                                                  page: 1);
                                          HomeCubit.get(context).currentCity =
                                              null;
                                          HomeCubit.get(context)
                                              .changeGover(value);
                                          page=1;
                                        } else {
                                          HomeCubit.get(context).currentCity =
                                              null;
                                          HomeCubit.get(context)
                                              .changeGover(value);

                                          HomeCubit.get(context)
                                              .getCities(value.id!);
                                        }
                                      },
                                      hint: "اختار المحافظة"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CustomDropDownCity(
                                      currentValue:
                                          HomeCubit.get(context).currentCity,
                                      selectCar: false,
                                      textColor: Colors.black26,
                                      isTwoIcons: false,
                                      iconColor: const Color(0xff515151),
                                      list: HomeCubit.get(context).cities,
                                      onSelect: (dynamic value) {
                                        HomeCubit.get(context)
                                            .changeCity(value);
                                        MarketsCubit.get(context)
                                            .getMarketsPagination(
                                                city: value.cityNameAr,
                                                catId: widget.category.id,
                                                page: 1);
                                        page=1;
                                      },
                                      hint: "اختار الدينة"),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: MarketsCubit.get(context).loadMarkets
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            ),
                          )
                        : Stack(
                            children: [
                              ListMarkets(
                                  controller: _controller,
                                  list: MarketsCubit.get(context).newList),
                              MarketsCubit.get(context).loadingPage
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
                                      ))
                                  : const SizedBox(),
                            ],
                          ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class ListMarkets extends StatelessWidget {
  final List<MarketModel> list;
  final ScrollController controller;

  ListMarkets({required this.controller, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: list.length,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (ctx, index) {
          MarketModel product = list[index];

          return InkWell(
              onTap: () {
                pushPage(context: context, page: ProductsScreen(product));
              },
              child: Container(
                height: 120,
                width: double.infinity,
                color: Colors.white,
                margin: paddingOnly(top: 0, bottom: 10, left: 0, right: 0),
                padding: paddingSymmetric(hor: 10, ver: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: baseurlImage + product.image!,
                      height: 90,
                      width: 90,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          color: homeColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: product.name!,
                              fontFamliy: "pnuB",
                              fontSize: 18,
                              lines: 1,
                              color: Colors.black),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: product.details!,
                              fontFamliy: "pnuR",
                              fontSize: 14,
                              lines: 2,
                              color: priceColor),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: product.address!,
                              fontFamliy: "pnuR",
                              fontSize: 12,
                              lines: 1,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
