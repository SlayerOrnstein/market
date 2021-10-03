import 'package:flutter/material.dart';

class OrderQuantityPriceWidget extends StatelessWidget {
  const OrderQuantityPriceWidget({
    Key? key,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final int quantity, price;

  Widget _buildColumn(TextTheme textTheme, String header, int value) {
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 65,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildColumn(textTheme, 'Quantity', quantity),
          Container(
            width: 20,
            height: 2,
            margin: const EdgeInsets.fromLTRB(8, 18, 8, 0),
            color: Theme.of(context).textTheme.bodyText2?.color,
          ),
          _buildColumn(textTheme, 'Platinum', price)
        ],
      ),
    );
  }
}
