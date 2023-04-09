import 'dart:convert';
import 'dart:io';

import 'package:awarake/helpers/constants.dart';
import 'package:awarake/helpers/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../helpers/add_helper.dart';
import '../../helpers/functions.dart';
import '../../models/home_model.dart';
import 'package:http/http.dart' as http;


import '../../models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  int currentIndex = 0;
  String currentTitle = "الرئيسية";

  changeNav(int index, String title) {
    currentIndex = index;
    currentTitle = title;
    emit(ChangeNav());
  }




  HomeModel homeModel = HomeModel();

  Map<int, int> favorites = {};

  bool load = false;

  getHomeData() async {
    load = true;
    emit(HomeGetDataLoad());
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + '/dashboard-home'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      homeModel = HomeModel.fromJson(jsonData);

      if(homeModel.sittings!.isNotEmpty){
        customerServiceNumber=homeModel.sittings![0].value!;
        customerServiceNumberWhats=homeModel.sittings![1].value!;
        emailService=homeModel.sittings![2].value!;
      }
      load = false;
      emit(HomeLoadDataSuccess(homeModel));
    } else {
      load = false;
      printFunction("errrrrrrrrrror");
      emit(HomeLoadDataError());
    }
  }

  List<Governorate> governorates = [];

  getGovernorates() {
    governorates = [];
    governoratesDataJson.forEach((element) {
      governorates.add(Governorate.fromJson(element));
    });

    print(governorates[0].governorateNameAr);
    emit(GetGovernorates());
  }
  List<CityModel> cities = [];
  getCities(String id) {
    cities = [];
    citesJson.forEach((element) {

      if(element["governorate_id"]==id)  cities.add(CityModel.fromJson(element));
    });

    print(cities[2].cityNameAr);
    emit(GetCities());
  }

Governorate? governorate;
  changeGover(Governorate newGover) {
    governorate = newGover;

    emit(ChangeGoverState());
  }


  CityModel? currentCity;
  changeCity(CityModel newCity) {
    currentCity = newCity;

    emit(ChangeCityState());
  }



  UserModel userModel = UserModel();
  bool loadUserDetails = false;

  Future getUserDetails() async {
    loadUserDetails = true;
    emit(GetUserDetails());
    var headers = {'Authorization': token};
    var request =
    http.Request('POST', Uri.parse(baseUrl + getUserDetailsPoint));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      Map<String, dynamic> json = {
        "id": jsonData["user"]['id'],
        "userName": jsonData["user"]['userName'],
        "fullName": jsonData["user"]['fullName'],
        "imageUrl": jsonData["user"]['imageUrl'],
        "status": jsonData["user"]['status'],
        "role": jsonData["user"]['role'],
      };
      userModel = UserModel.fromJson(json);

      printFunction("userModel.id${userModel.status}");
      loadUserDetails = false;
      emit(GetUserDetails());

      print(jsonData);
    } else {
      print(response.reasonPhrase);
    }
  }

  bool loadImage = false;

  Future<dynamic> uploadImage(file) async {
    loadImage = true;
    emit(UploadImageLoad());
    const url = baseUrl + uploadImagePoint;
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var multipartFile = await http.MultipartFile.fromPath(
      "file",
      file.path,
    );
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    var postBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {

      emit(UploadImageSuccess(postBody.body.toString()));


      //update profile



    } else {
      return "a.jpg";
    }
  }

  Future getImage(context, imageProvider) async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(
      source: imageProvider,
      imageQuality: 5,
    );
    if (pickedFile != null) {
      File? imagePath = File(pickedFile.path);
      emit(PickedImage(imagePath));
      imagePath = null;
    } else {
      print('No image selected.');
    }
  }



  bool loadUpdate =false;
  Future updateProfile({name,phone,image})async{
    loadUpdate=true;
    emit(UpdateProfileLoad());
    var headers = {
      'Authorization': token
    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+updateUserDetailsPoint));
    request.fields.addAll({
      'FullName': name,
      'Email': 'add@gmail.com',
      'Phone': phone,
      'ImageUrl': image
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadUpdate=false;
      emit(UpdateProfileSuccess("تم التعديل بنجاح"));
    }
    else {
      loadUpdate=false;
      print(response.reasonPhrase);
      emit(UpdateProfileError("فشلت العملية"));
    }

  }
int indexSlide=0;
  void changIndex(int index) {
    indexSlide=index;
    emit(ChangeIndex());
  }


  BannerAd? bannerAd;

  void getAdds(newBannerAd) {
    // TODO: Load a banner ad

    if(newBannerAd !=null){
      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {

            newBannerAd = ad as BannerAd;
            emit(ChangeIndex());
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.code}');
            ad.dispose();
          },
        ),
      ).load();
    }

  }



}


