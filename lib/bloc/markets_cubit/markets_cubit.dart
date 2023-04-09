import 'dart:convert';

import 'package:awarake/helpers/constants.dart';
import 'package:awarake/models/market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../helpers/functions.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(MarketsInitial());

  static MarketsCubit get(context) => BlocProvider.of<MarketsCubit>(context);

  List<MarketModel> markets = [];

  Map<int, int> favorites = {};

  bool loadMarkets = false;

  getMarkets({city, catId}) async {
    loadMarkets = true;
    markets = [];

    emit(GetMarketsDataLoad());
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + '/field/get-fields'));

    if (city != null) {
      request.fields.addAll({'City': city, 'CategoryId': catId.toString()});
    } else {
      request.fields.addAll({'CategoryId': catId.toString()});
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      jsonData.forEach((v) {
        markets.add(MarketModel.fromJson(v));
      });

      loadMarkets = false;

      emit(GetMarketsDataSuccess());
    } else {
      print(response.reasonPhrase);
      loadMarkets = false;
      emit(GetMarketsDataError());
    }
  }

  //==============pagination

  ResponseMarkets? marketsPagination;
  List<MarketModel> newList = [];

  getMarketsPagination({city, catId, page}) async {
    loadMarkets = true;
    newList = [];
    emit(GetMarketsDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/field/get-fields-page-user'));

    if (city != null) {
      request.fields.addAll({
        'categoryId': catId.toString(),
        'page': page.toString(),
        'City': city,
        'ItemsPerPage': '10'
      });
    } else {
      request.fields.addAll({
        'categoryId': catId.toString(),
        'page': page.toString(),
        'ItemsPerPage': '10'
      });
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      marketsPagination = ResponseMarkets.fromJson(jsonData);

      newList.addAll(marketsPagination!.items!);

      loadMarkets = false;

      emit(GetMarketsDataSuccess());
    } else {
      print(response.reasonPhrase);
      loadMarkets = false;
      emit(GetMarketsDataError());
    }
  }

  // pagination
  bool loadingPage = false;

  pagination({catId, page,city}) async {

    loadingPage = true;
    emit(PaginationMarketsLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/field/get-fields-page-user'));

    if (city != null) {
      request.fields.addAll({
        'categoryId': catId.toString(),
        'page': page.toString(),
        'City': city,
        'ItemsPerPage': '10'
      });
    } else {
      request.fields.addAll({
        'categoryId': catId.toString(),
        'page': page.toString(),
        'ItemsPerPage': '10'
      });
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      marketsPagination = ResponseMarkets.fromJson(jsonData);

      newList.addAll(marketsPagination!.items!);


      loadingPage = false;

      emit(PaginationMarketsSuccess());
    } else {

      loadingPage = false;

      printFunction("errrrrrrrrrror");
      emit(PaginationMarketsError());
    }


    // getPlacesPagination(
    //     status: 1, page: page, categoryId: catId, itemsPer: 10);
  }



}
