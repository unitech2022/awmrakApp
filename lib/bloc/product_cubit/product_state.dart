part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class GetProductDataLoad extends ProductState {}
class GetProductDataSuccess extends ProductState {}
class GetProductDataError extends ProductState {}



class GetMarketByIdLoad extends ProductState {}
class GetMarketByIdSuccess extends ProductState {}
class GetMarketByIdError extends ProductState {}

class SearchProductDataLoad extends ProductState {}
class SearchProductDataSuccess extends ProductState {}
class SearchProductDataError extends ProductState {}



class GetProductOfferDataLoad extends ProductState {}
class GetProductOfferDataSuccess extends ProductState {}
class GetProductOfferDataError extends ProductState {}


class GetProductDetailsDataLoad extends ProductState {}
class GetProductDetailsDataSuccess extends ProductState {

  final Product product;

  GetProductDetailsDataSuccess(this.product);
}
class GetProductDetailsDataError extends ProductState {}
class ChangeCategory extends ProductState {}

class ChangeSelectTypeSearch extends ProductState {}



class PaginationPaginationLoad extends ProductState {}
class PaginationPaginationSuccess extends ProductState {}
class PaginationPaginationError extends ProductState {}