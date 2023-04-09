part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangeNav extends HomeState {}



class HomeGetDataLoad extends HomeState {}
class HomeLoadDataSuccess extends HomeState {

  final HomeModel homeModel;

  HomeLoadDataSuccess(this.homeModel);

}
class HomeLoadDataError extends HomeState {}


class GetGovernorates extends HomeState {}

class GetCities extends HomeState {}


class ChangeGoverState extends HomeState {}
class ChangeCityState extends HomeState {}





// user
class GetUserDetails extends HomeState{}
class UpdateUserProfile extends HomeState{}

//image
class UploadImageLoad extends HomeState{


}
class UploadImageSuccess extends HomeState{
  final String imageUpload;

  UploadImageSuccess(this.imageUpload);
}

class PickedImage extends HomeState{
  final File imagePath;

  PickedImage(this.imagePath);
}


//update User
class UpdateProfileLoad extends HomeState{


}
class UpdateProfileSuccess extends HomeState{
  final String meassge;

  UpdateProfileSuccess(this.meassge);
}
class UpdateProfileError extends HomeState{
  final String meassge;

  UpdateProfileError(this.meassge);

}


// sliders
class SliderProductLoadStat extends HomeState {}

class SliderProductSuccessStat extends HomeState {

}
class SliderProductErrorStat extends HomeState {
}
class ChangeIndex extends HomeState{
}