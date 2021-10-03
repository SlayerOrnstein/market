part of 'bazarsearch_bloc.dart';

@immutable
abstract class BazarSearchEvent extends Equatable {}

class SearchItems extends BazarSearchEvent {
  SearchItems(this.itemName);

  final String itemName;

  @override
  List<Object?> get props => [itemName];
}
