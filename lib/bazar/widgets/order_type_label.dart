import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';

class OrderTypeLabel extends StatelessWidget {
  const OrderTypeLabel({Key? key, required this.orderType}) : super(key: key);

  final OrderType orderType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        () {
          switch (orderType) {
            case OrderType.sell:
              return 'WTS';
            case OrderType.buy:
              return 'WTB';
          }
        }(),
        style: theme.textTheme.caption
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
