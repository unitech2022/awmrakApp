import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  List<Cart> carts = [];
  List<int> quantities = [];
  List<double> prices = [];
  Map<int, int> cartsFound = {};
  double total = 0.0;

  int marketIdCart = 0;
  grtTotal() {
    total = 0.0;
    carts.forEach((element) {
      total += element.total;
    });
    emit(ChangeCartCartSuccess());
  }

  getCarts() async {
    emit(GetCartGetDataLoad());

    var headers = {
      "Authorization": token,
      'Content-Type': 'application/json',

      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      // If needed
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      // If needed
      'Access-Control-Allow-Credentials': true
      // If  needed
    };

    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: headers, responseType: ResponseType.plain));
    final response = await dio.get(getCartsPoint);

    if (response.statusCode == 200) {
      printFunction(response.statusCode);
      var decode = jsonDecode(response.data.toString());
      printFunction(decode);
      carts = [];
      decode.forEach((v) {
        carts.add(Cart.fromJson(v));
      });
      if(carts.isNotEmpty){
        marketIdCart=carts[0].marketId!;
      }else{
        marketIdCart=0;


      }
      cartsFound = {};
      quantities = [];
      prices = [];
      total = 0.0;
      carts.forEach((element) {
        quantities.add(element.quantity!);
        prices.add(double.parse("${element.total}"));
        cartsFound.addAll({element.productId!: element.productId!});
        total += element.total;
      });
      printFunction("cart=${quantities.length}");
      emit(GetCartLoadDataSuccess(carts));
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetCartLoadDataError());
    }
  }

  bool isFound = false;

  Future addCart(Cart cart) async {
    cartsFound.containsValue(cart.productId)
        ? cartsFound.remove(cart.productId)
        : cartsFound.addAll({cart.productId!: cart.productId!});
    emit(AddCartGetDataLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + addCartPoint));
    request.fields.addAll({
      "orderId": "0",
      "ProductId": cart.productId.toString(),
      "UserId": cart.userId.toString(),
      "quantity": "1",
      "image": cart.image.toString(),
      "nameProduct": cart.nameProduct.toString(),
      'market_id': cart.marketId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      printFunction(jsonData);
      marketIdCart = cart.marketId!;
      emit(AddCartLoadDataSuccess());
      getCarts();
    } else {
      cartsFound.containsValue(cart.productId)
          ? cartsFound.remove(cart.productId)
          : cartsFound.addAll({cart.productId!: cart.productId!});

      emit(AddCartLoadDataError());
    }
  }

  Future deleteCart(int id) async {
    // emit(DeleteCartGetDataLoad());
    final headers = {
      "Authorization": token,

      // If  needed
    };

    final params = {
      "id": "$id",
    };

    http.StreamedResponse response =
        await httpPost(id, params, deleteCartPoint);

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;

      // get Carts

      final dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: headers,
          responseType: ResponseType.plain));
      final responseCarts = await dio.get(getCartsPoint);

      if (responseCarts.statusCode == 200) {
        carts = [];
        printFunction(responseCarts.statusCode);
        var decode = jsonDecode(responseCarts.data.toString());
        printFunction(decode);

        decode.forEach((v) {
          carts.add(Cart.fromJson(v));
        });
        cartsFound = {};
        quantities = [];
        prices = [];
        total = 0.0;
        carts.forEach((element) {
          quantities.add(element.quantity!);
          prices.add(double.parse("${element.price}"));
          cartsFound.addAll({element.productId!: element.productId!});
          carts.forEach((element) {
            total += element.total;
          });
        });
        if(carts.isNotEmpty){
          marketIdCart=carts[0].marketId!;
        }else{
          marketIdCart=0;


        }
        emit(DeleteCartLoadDataSuccess(jsonData));
      }

      //
    } else {
      printFunction("errrrrrrrrrror");
      emit(DeleteCartLoadDataError());
    }
  }

  updateCart(Cart cart) async {
    // emit(UpdateCartGetDataLoad());
    var headers = {
      "Authorization": token,
    };

    final params = {
      "id": "${cart.id}",
      "orderId": "${cart.orderId}",
      "ProductId": cart.productId.toString(),
      "UserId": currentUser.id!,
      "quantity": cart.quantity.toString(),
      "image": cart.image.toString(),
      "nameProduct": cart.nameProduct.toString(),
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + updateCartPoint));
    request.fields.addAll(params);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      // String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      grtTotal();
      printFunction("updated");
      // print(homeModel.categories!.length);
      // emit(UpdateCartLoadDataSuccess(decode));
    } else {
      printFunction(response.statusCode);
      emit(UpdateCartLoadDataError());
    }
  }

  int quantity = 0;

  plusQuantity(int value) {
    value++;

    printFunction(value);
  }

  minusQuantity(int value) {
    if (value > 1) {
      value--;
    }

    emit(ChangeQuntitySuccess(value));
  }

















  Future<http.StreamedResponse> httpPost(
      int id, Map<String, String> params, endPoint) async {
    final headers = {
      "Authorization": token,

      // If  needed
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + deleteCartPoint));
    request.fields.addAll({'id': "$id"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
