import 'package:flutter/material.dart';

/// {template price_quantity}
/// Widget that displays both price and quantity of an item.
/// {@endtemplate}
class PriceQuantity extends StatelessWidget {
  /// {@macro price_quantity}
  const PriceQuantity({Key? key, required this.price, required this.quantity})
      : super(key: key);

  /// Item price.
  final int price;

  /// Item quantity.
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BuildColumn(header: 'Quantity', value: quantity),
          Container(
            width: 20,
            height: 2,
            margin: const EdgeInsets.fromLTRB(8, 18, 8, 0),
            color: Theme.of(context).textTheme.bodyText2?.color,
          ),
          _BuildColumn(header: 'Platinum', value: price)
        ],
      ),
    );
  }
}

class _BuildColumn extends StatelessWidget {
  const _BuildColumn({Key? key, required this.header, required this.value})
      : super(key: key);

  final String header;
  final int value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final headerStyle =
        textTheme.caption?.copyWith(fontWeight: FontWeight.w500);
    final valueStyle =
        textTheme.headline5?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(header, style: headerStyle),
        const SizedBox(height: 6),
        Text('$value'.padLeft(2, '0'), style: valueStyle)
      ],
    );
  }
}
