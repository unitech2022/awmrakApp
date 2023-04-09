import 'package:awarake/helpers/styles.dart';
import 'package:awarake/user_ui/category_screen/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_cubit/home_cubit.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../models/product.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../products_screen/products_screen.dart';

List<String> listSearch = ["بحث عن منتج", "بحث عن محل"];

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controllerPhone = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).currentCategory = null;
    ProductCubit.get(context).searchProducts = [];
    HomeCubit.get(context).governorate = null;
    ProductCubit.get(context).currentSelectTypSearch = null;
    HomeCubit.get(context).currentCity = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
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
            title: Container(
              width: 150,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomDropDownWidget2(
                  listWidget: listSearch
                      .map((item) => DropdownMenuItem<dynamic>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: "pnuB",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )))
                      .toList(),
                  currentValue:
                      ProductCubit.get(context).currentSelectTypSearch,
                  selectCar: false,
                  textColor: Colors.white,
                  hintColor: Colors.white,
                  isTwoIcons: false,
                  iconColor: Colors.white,
                  backroundColor: Colors.black,
                  list: listSearch,
                  onSelect: (dynamic value) {
                    ProductCubit.get(context).ChangeSelectTypSearch(value);
                  },
                  hint: "بحث عن ...؟"),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("القسم",
                        style: TextStyle(
                          fontFamily: 'pnuB',
                          fontSize: 18,
                          color: homeColor,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomDropDownWidget2(
                            listWidget: HomeCubit.get(context)
                                .homeModel
                                .categories!
                                .map((item) => DropdownMenuItem<dynamic>(
                                    value: item,
                                    child: Text(
                                      item.name!,
                                      style: const TextStyle(
                                        fontFamily: "pnuB",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            currentValue:
                                ProductCubit.get(context).currentCategory,
                            selectCar: false,
                            textColor: Colors.black26,
                            isTwoIcons: false,
                            iconColor: const Color(0xff515151),
                            list: HomeCubit.get(context).homeModel.categories!,
                            onSelect: (dynamic value) {
                              ProductCubit.get(context).changeCategory(value);
                            },
                            hint: "اختار القسم"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                        HomeCubit.get(context).currentCity =
                                            null;
                                        HomeCubit.get(context)
                                            .changeGover(value);
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
                                      HomeCubit.get(context).changeCity(value);
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomFormField(
                          headingText: "Password",
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          hintText: "بتدور علي ايه",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: _controllerPhone,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isValidate(context)) {
                          if (ProductCubit.get(context)
                                  .currentSelectTypSearch ==
                              listSearch[0]) {
                            if (HomeCubit.get(context).currentCity == null) {
                              ProductCubit.get(context).searchProductsData(
                                  categoryId: ProductCubit.get(context)
                                      .currentCategory!
                                      .id,
                                  name: _controllerPhone.text.trim());
                              ProductCubit.get(context)
                                      .currentSelectTypSearch ==
                                  null;
                            } else {
                              ProductCubit.get(context).searchProductsData(
                                  categoryId: ProductCubit.get(context)
                                      .currentCategory!
                                      .id,
                                  name: _controllerPhone.text.trim(),
                                  city: HomeCubit.get(context)
                                      .currentCity!
                                      .cityNameAr);
                              HomeCubit.get(context).currentCity == null;
                              ProductCubit.get(context)
                                      .currentSelectTypSearch ==
                                  null;
                            }
                          } else {
                            if (HomeCubit.get(context).currentCity == null) {
                              ProductCubit.get(context).searchMarketsData(
                                  categoryId: ProductCubit.get(context)
                                      .currentCategory!
                                      .id,
                                  name: _controllerPhone.text.trim());
                              ProductCubit.get(context)
                                      .currentSelectTypSearch ==
                                  null;
                            } else {
                              ProductCubit.get(context).searchMarketsData(
                                  categoryId: ProductCubit.get(context)
                                      .currentCategory!
                                      .id,
                                  name: _controllerPhone.text.trim(),
                                  city: HomeCubit.get(context)
                                      .currentCity!
                                      .cityNameAr);
                              HomeCubit.get(context).currentCity == null;
                              ProductCubit.get(context)
                                      .currentSelectTypSearch ==
                                  null;
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.search,
                            color: homeColor,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: ProductCubit.get(context).loadSearch
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: homeColor,
                            ),
                          )
                        : ProductCubit.get(context).currentSelectTypSearch ==
                                listSearch[0]
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: ProductCubit.get(context)
                                      .searchProducts
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Product category = ProductCubit.get(context)
                                        .searchProducts[index];
                                    return ItemProduct(category: category);
                                  },
                                ),
                              )
                            : ListMarkets(
                                controller: _controller,
                                list: ProductCubit.get(context).searchMarkets))
              ],
            ),
          ),
        );
      },
    );
  }

  bool isValidate(BuildContext context) {
    if (ProductCubit.get(context).currentSelectTypSearch == null) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.grey,
          message: "هل تبحث عن منتج او محل ؟");
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل كلمة البحث");
      return false;
    } else if (ProductCubit.get(context).currentCategory == null) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "اختار القسم");
      return false;
    } else {
      return true;
    }
  }
}
