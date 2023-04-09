part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}




class AddCartGetDataLoad extends CartState {}
class AddCartLoadDataSuccess extends CartState {
}
class AddCartLoadDataError extends CartState {}



class GetCartGetDataLoad extends CartState {}
class GetCartLoadDataSuccess extends CartState {

  final List<Cart> carts;

  GetCartLoadDataSuccess(this.carts);
}
class GetCartLoadDataError extends CartState {}



//delete
class DeleteCartGetDataLoad extends CartState {}
class DeleteCartLoadDataSuccess extends CartState {

final String success;

  DeleteCartLoadDataSuccess(this.success);
}
class DeleteCartLoadDataError extends CartState {}

//Update
//delete
class UpdateCartGetDataLoad extends CartState {}
class UpdateCartLoadDataSuccess extends CartState {

  final String success;

  UpdateCartLoadDataSuccess(this.success);
}
class UpdateCartLoadDataError extends CartState {}

class AddCartSuccess extends CartState {}

class ChangeQuntitySuccess extends CartState {
  final int qun;

  ChangeQuntitySuccess(this.qun);
}

class ChangeCartCartSuccess extends CartState {}