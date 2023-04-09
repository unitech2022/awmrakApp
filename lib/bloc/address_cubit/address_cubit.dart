
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import 'package:http/http.dart' as http;

import '../../models/address.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());


  static AddressCubit get(context) => BlocProvider.of<AddressCubit>(context);




  List<Address> addresses = [];

  bool loadGetAddresses=false;
  getAddresses() async {

    loadGetAddresses=true;
    emit(GetAddressDataLoad());

    var headers = {
      "Authorization": token,

      // If  needed
    };

    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: headers, responseType: ResponseType.plain));
    final response = await dio.get(getAddressesPoint);

    if (response.statusCode == 200) {
      printFunction(response.statusCode);
      var decode = jsonDecode(response.data.toString());
      printFunction(decode);
      addresses = [];
      decode.forEach((v) {
        addresses.add(Address.fromJson(v));
      });
      loadGetAddresses=false;
      printFunction("cart=${addresses.length}");
      emit(GetAddressDataSuccess(addresses));
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetAddressDataError());
    }
  }


  Future deleteAddress(int id) async {
    // emit(DeleteCartGetDataLoad());
    final headers = {
      "Authorization": token,

      // If  needed
    };

    final params = {
      "id": "$id",
    };

    http.StreamedResponse response =
    await httpPost(id, params, deleteAddressPoint);

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;

      // get Carts

      final dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: headers,
          responseType: ResponseType.plain));
      final responseCarts = await dio.get(getAddressesPoint);

      if (responseCarts.statusCode == 200) {
        addresses = [];
        printFunction(responseCarts.statusCode);
        var decode = jsonDecode(responseCarts.data.toString());
        printFunction(decode);

        decode.forEach((v) {
          addresses.add(Address.fromJson(v));
        });

        emit(DeleteAddressDataSuccess(jsonData));

      }

      //
    } else {
      printFunction("errrrrrrrrrror");
      emit(DeleteAddressDataError());
    }
  }



  bool loadChangAddress=false;

Future updateAddress(Address address) async {
    loadChangAddress=true;
    emit(UpdateAddressDataLoad());
    var headers = {
      "Authorization": token,


    };

    final params = {
      "id": "${address.id}",
      "UserId": "${address.userId}",
      "Lable": address.lable.toString(),
      "Lat": address.lat.toString(),
      "Lng": address.lng.toString(),

    };

    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + updateAddressPoint));
    request.fields.addAll(params);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      loadChangAddress=false;
      printFunction(jsonData);
      // print(homeModel.categories!.length);
     emit(UpdateAddressDataSuccess("decode"));
    } else {
      loadChangAddress=false;
      printFunction(response.statusCode);
      emit(UpdateAddressDataError());
    }
  }


  Future  addAddress(Address address) async {
    loadChangAddress=true;
    emit(AddAddressDataLoad());



    var headers = {
      'Authorization': token
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + addAddressPoint));
    request.fields.addAll({

      "UserId": "${address.userId}",
      "Lable": address.lable.toString(),
      "Lat": address.lat.toString(),
      "Lng": address.lng.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      loadChangAddress=false;
      printFunction(jsonData);
      emit(AddAddressSuccess());

    } else {

      loadChangAddress=false;
      emit(AddAddressError());
    }
  }


  Future<http.StreamedResponse> httpPost(
      int id, Map<String, String> params, endPoint) async {
    final headers = {
      "Authorization": token,

      // If  needed
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({'id': "$id"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
int selectedRadio=0;
  changeValue(int val) {

      selectedRadio = val;
   emit(ChangeValueRadioState());
  }

}
