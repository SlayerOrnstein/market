import 'dart:async';

import 'package:bazar_repository/bazar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'bazarsearch_event.dart';
part 'bazarsearch_state.dart';

class BazarSearchBloc extends Bloc<BazarSearchEvent, BazarSearchState> {
  BazarSearchBloc(BazarRepository repository)
      : _repository = repository,
        super(const BazarsearchInitial()) {
    on<SearchItems>(_searchItems, transformer: _waitForUser());
  }

  final BazarRepository _repository;

  EventTransformer<SearchItems> _waitForUser() {
    return (event, mapper) {
      return event
          .debounceTime(const Duration(milliseconds: 500))
          .distinct()
          .flatMap(mapper);
    };
  }

  Future<void> _searchItems(
      SearchItems event, Emitter<BazarSearchState> emit) async {
    emit(event.itemName.isEmpty
        ? const BazarItemEmpty()
        : const LoadingResults());

    final items = await _repository.getMarketItems();

    if (event.itemName.isEmpty) {
      emit(const BazarItemEmpty());
    } else {
      emit(
        BazarItemResults(items
            .where((e) =>
                e.itemName.toLowerCase().contains(event.itemName.toLowerCase()))
            .toList()),
      );
    }
  }
}
