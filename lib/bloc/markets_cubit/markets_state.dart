part of 'markets_cubit.dart';

@immutable
abstract class MarketsState {}

class MarketsInitial extends MarketsState {}


class GetMarketsDataLoad extends MarketsState {}
class GetMarketsDataSuccess extends MarketsState {


  GetMarketsDataSuccess();

}
class GetMarketsDataError extends MarketsState {}


//pagination
class PaginationMarketsLoad extends MarketsState {}
class PaginationMarketsSuccess extends MarketsState {}
class PaginationMarketsError extends MarketsState {}