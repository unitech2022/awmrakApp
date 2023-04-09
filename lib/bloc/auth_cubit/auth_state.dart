part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


//validate
class ValidateAuthStateLoad extends AuthState {}
class ValidateAuthStateSuccess extends AuthState {}
class ValidateAuthStateError extends AuthState {
  final String error;

  ValidateAuthStateError(this.error);
}


//Login
class LoginAuthStateLoad extends AuthState {}
class LoginAuthStateSuccess extends AuthState {
  final UserResponse userResponse;

  LoginAuthStateSuccess(this.userResponse);
}
class LoginAuthStateError extends AuthState {}



//Register
class RegisterAuthStateLoad extends AuthState {}
class RegisterAuthStateSuccess extends AuthState {

  final String code,userName;

  RegisterAuthStateSuccess({required this.code, required this.userName});
}
class RegisterAuthStateError extends AuthState {}

//checkUser
class CheckUserAuthStateLoad extends AuthState {}
class CheckUserAuthStateSuccess extends AuthState {
  final String phone,code;
  final int status;

  CheckUserAuthStateSuccess({required this.phone, required this.code, required this.status});
}
class CheckUserAuthStateError extends AuthState {}

class ChangeCheckBox extends AuthState {}