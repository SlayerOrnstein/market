part of 'ordersearch_cubit.dart';

abstract class OrdersearchState extends Equatable {
  const OrdersearchState();

  @override
  List<Object> get props => [];
}

class OrdersearchInitial extends OrdersearchState {}

class OrdersLoading extends OrdersearchState {}

class OrdersLoaded extends OrdersearchState {
  OrdersLoaded(MarketOrders orders)
      : sellOrders = orders.sellOrders,
        buyOrders = orders.buyOrders;

  final List<ItemOrder> sellOrders;
  final List<ItemOrder> buyOrders;

  @override
  List<Object> get props => [sellOrders, buyOrders];
}
