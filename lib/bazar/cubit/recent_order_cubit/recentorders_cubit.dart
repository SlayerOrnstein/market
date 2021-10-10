import 'package:bazar_repository/bazar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_client/market_client.dart';

part 'recentorders_state.dart';

class RecentordersCubit extends Cubit<RecentordersState> {
  RecentordersCubit(BazarRepository repository)
      : _repository = repository,
        super(RecentordersInitial()) {
    loadRecentOrders();
  }

  final BazarRepository _repository;

  Future<void> loadRecentOrders() async {
    emit(RecentOrdersLoading());

    final orders = await _repository.mostRecentOrders();
    emit(RecentOrdersLoaded(orders));
  }
}
