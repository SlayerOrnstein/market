part of 'recentorders_cubit.dart';

abstract class RecentordersState extends Equatable {
  const RecentordersState();

  @override
  List<Object> get props => [];
}

class RecentordersInitial extends RecentordersState {}

class RecentOrdersLoading extends RecentordersState {}

class RecentOrdersLoaded extends RecentordersState {
  RecentOrdersLoaded(RecentMarketOrders recentMarketOrders)
      : sellOrders = recentMarketOrders.sellOrders,
        buyOrders = recentMarketOrders.buyOrders;

  final List<RecentOrder> sellOrders;
  final List<RecentOrder> buyOrders;

  @override
  List<Object> get props => [sellOrders, buyOrders];
}
