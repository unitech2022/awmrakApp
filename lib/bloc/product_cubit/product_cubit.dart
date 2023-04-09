import 'dart:convert';
import 'package:awarake/bloc/markets_cubit/markets_cubit.dart';
import 'package:awarake/models/market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/home_model.dart';
import '../../models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  List<Product> products = [];
  bool load = false;

  getProductsByCategory(int id) async {
    products = [];
    load = true;
    emit(GetProductDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + getProductsByCategoryPoint));
    request.fields.addAll({'categoryId': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        products.add(Product.fromJson(v));
      });
      load = false;
      emit(GetProductDataSuccess());
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetProductDataError());
    }
  }

  List<Product> searchProducts = [];
  bool loadSearch = false;

  List<MarketModel> searchMarkets = [];

  searchProductsData({name, categoryId, city}) async {
    searchProducts = [];
    loadSearch = true;
    emit(SearchProductDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/search-products'));

    if (city != null) {
      request.fields.addAll(
          {'categoryId': categoryId.toString(), 'name': name, 'city': "$city"});
    } else {
      request.fields.addAll({
        'categoryId': categoryId.toString(),
        'name': name,
      });
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        searchProducts.add(Product.fromJson(v));
      });
      loadSearch = false;
      emit(SearchProductDataSuccess());
    } else {
      loadSearch = false;
      printFunction("errrrrrrrrrror");
      emit(SearchProductDataError());
    }
  }

  searchMarketsData({name, categoryId, city}) async {
    searchMarkets = [];
    loadSearch = true;
    emit(SearchProductDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/search-markets'));

    if (city != null) {
      request.fields.addAll(
          {'categoryId': categoryId.toString(), 'name': name, 'city': "$city"});
    } else {
      request.fields.addAll({
        'categoryId': categoryId.toString(),
        'name': name,
      });
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        searchMarkets.add(MarketModel.fromJson(v));
      });
      loadSearch = false;
      emit(SearchProductDataSuccess());
    } else {
      loadSearch = false;
      printFunction("errrrrrrrrrror");
      emit(SearchProductDataError());
    }
  }



  bool loadProduct = false;
  Product? product;
  MarketModel? marketModel;

  Future getProductDetails(int id) async {
    product = null;
    loadProduct = true;

    emit(GetProductDetailsDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/get-product-details'));

    request.fields.addAll({'Id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      product = Product.fromJson(jsonData);

      getMarketById(id: product!.categoryId);
    } else {
      loadProduct = false;
      printFunction("errrrrrrrrrror");
      emit(GetProductDetailsDataError());
    }
  }

  getMarketById({id}) async {
    emit(GetMarketByIdLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/field/get-field-by-id'));
    request.fields.addAll({'id': id.toString()});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString() + "mmmmmmm");
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      marketModel = MarketModel.fromJson(jsonData);

      loadProduct = false;
      emit(GetMarketByIdSuccess());
      printFunction(jsonData);
    } else {
      print(response.statusCode.toString() + "mmmmmmm");
      emit(GetMarketByIdError());
    }
  }

  Category? currentCategory;

  changeCategory(Category? category) {
    currentCategory = category;
    emit(ChangeCategory());
  }

  String? currentSelectTypSearch;

  ChangeSelectTypSearch(String? newValue) {
    currentSelectTypSearch = newValue;
    emit(ChangeSelectTypeSearch());
  }

  //==============pagination

  List<Product> offersProducts = [];

  bool loadOffers = false;

  getOffers() async {
    loadOffers = true;
    offersProducts = [];

    emit(GetProductOfferDataLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/get-offer-products'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        offersProducts.add(Product.fromJson(v));
      });
      loadOffers = false;
      emit(GetProductOfferDataSuccess());
    } else {
      loadOffers = false;
      printFunction("errrrrrrrrrror");
      emit(GetProductOfferDataError());
    }
  }


  ResponseProduct? responseProducts;
  List<Product> newList = [];

  getOffersPagination({page}) async {
    loadOffers = true;
    newList = [];
    emit(GetProductOfferDataLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/get-offer-products-page'));
    request.fields.addAll({

      'page': page.toString(),
      'ItemsPerPage': '10'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      responseProducts = ResponseProduct.fromJson(jsonData);

      newList.addAll(responseProducts!.items!);

      loadOffers = false;

      emit(GetProductOfferDataSuccess());
    } else {
      print(response.reasonPhrase);
      loadOffers = false;
      emit(GetProductOfferDataError());
    }
  }

  // pagination
  bool loadingPage = false;

  pagination({ page, city}) async {
    loadingPage = true;
    emit(GetProductOfferDataLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/product/get-offer-products-page'));

      request.fields.addAll({

        'page': page.toString(),
        'ItemsPerPage': '10'
      });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      responseProducts = ResponseProduct.fromJson(jsonData);

      newList.addAll(responseProducts!.items!);

      loadingPage = false;

      emit(PaginationPaginationSuccess());
    } else {
      loadingPage = false;

      printFunction("errrrrrrrrrror");
      emit(PaginationPaginationError());
    }

    // getPlacesPagination(
    //     status: 1, page: page, categoryId: catId, itemsPer: 10);
  }
}
