import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bazar/bazar.dart';

class BazarResultsPage extends StatelessWidget {
  const BazarResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersearchCubit, OrdersearchState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return OrderCard(order: state.sellOrders[index]);
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
