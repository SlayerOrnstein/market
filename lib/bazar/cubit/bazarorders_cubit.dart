import 'package:bazar_repository/bazar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_client/market_client.dart';
import 'package:meta/meta.dart';

part 'bazarorders_state.dart';

class BazarOrdersCubit extends Cubit<BazarOrdersState> {
  BazarOrdersCubit(BazarRepository repository)
      : _repository = repository,
        super(const BazarMostRecentsInitial()) {
    loadMostRecentOrders();
  }

  final BazarRepository _repository;

  Future<void> loadMostRecentOrders() async {
    final orders = await _repository.mostRecentOrders();
    emit(BazarOrdersLoaded(orders.sellOrders, orders.buyOrders));
  }

  Future<void> searchForOrders(String item) async {
    final orders = await _repository.searchOrders(item);
    emit(BazarOrdersLoaded(orders.sellOrders, orders.buyOrders));
  }
}
