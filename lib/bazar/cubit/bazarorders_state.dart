part of 'bazarorders_cubit.dart';

@immutable
abstract class BazarOrdersState extends Equatable {
  const BazarOrdersState();
}

class BazarMostRecentsInitial extends BazarOrdersState {
  const BazarMostRecentsInitial();

  @override
  List<Object?> get props => [];
}

class BazarOrdersLoaded extends BazarOrdersState {
  const BazarOrdersLoaded(this.sellOrders, this.buyOrders);

  final List<ItemOrder> sellOrders;
  final List<ItemOrder> buyOrders;

  @override
  List<Object?> get props => [sellOrders, buyOrders];
}
