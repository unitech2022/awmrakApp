part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddAddressDataLoad extends AddressState {}
class AddAddressSuccess extends AddressState {
}
class AddAddressError extends AddressState {}



class GetAddressDataLoad extends AddressState {}
class GetAddressDataSuccess extends AddressState {

  final List<Address> addresses;

  GetAddressDataSuccess(this.addresses);
}
class GetAddressDataError extends AddressState {}



//delete
class DeleteAddressDataLoad extends AddressState {}
class DeleteAddressDataSuccess extends AddressState {

  final String success;

  DeleteAddressDataSuccess(this.success);
}
class DeleteAddressDataError extends AddressState {}

//Update
//delete
class UpdateAddressDataLoad extends AddressState {}
class UpdateAddressDataSuccess extends AddressState {

  final String success;

  UpdateAddressDataSuccess(this.success);
}
class UpdateAddressDataError extends AddressState {}

class ChangeValueRadioState extends AddressState {}





