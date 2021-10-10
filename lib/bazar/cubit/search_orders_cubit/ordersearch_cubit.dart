import 'package:bazar_repository/bazar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_client/market_client.dart';

part 'ordersearch_state.dart';

class OrdersearchCubit extends Cubit<OrdersearchState> {
  OrdersearchCubit(BazarRepository repository)
      : _repository = repository,
        super(OrdersearchInitial());

  final BazarRepository _repository;

  Future<void> searchOrders(String itemUrl) async {
    emit(OrdersLoading());

    final results = await _repository.searchOrders(itemUrl);
    emit(OrdersLoaded(results));
  }
}
