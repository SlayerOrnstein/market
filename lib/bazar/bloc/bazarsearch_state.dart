part of 'bazarsearch_bloc.dart';

@immutable
abstract class BazarSearchState extends Equatable {
  const BazarSearchState();
}

class BazarsearchInitial extends BazarSearchState {
  const BazarsearchInitial();

  @override
  List<Object?> get props => [];
}

class LoadingResults extends BazarSearchState {
  const LoadingResults();

  @override
  List<Object?> get props => [];
}

class BazarItemResults extends BazarSearchState {
  const BazarItemResults(this.items);

  final List<MarketItem> items;

  @override
  List<Object?> get props => [items];
}

class BazarItemEmpty extends BazarSearchState {
  const BazarItemEmpty();

  @override
  List<Object?> get props => [];
}
