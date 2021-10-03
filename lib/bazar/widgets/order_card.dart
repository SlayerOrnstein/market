import 'package:flutter/material.dart';
import 'package:market/bazar/widgets/order_quantity_price.dart';
import 'package:market/bazar/widgets/order_type_label.dart';
import 'package:market/bazar/widgets/user_avatar.dart';
import 'package:market_client/market_client.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);

  final ItemOrder order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: _OrderCardLeading(
                avatar: order.user.avatar,
                orderType: order.orderType,
                status: order.user.status,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: _OrderCardBody(
                  username: order.user.ingameName,
                  reputation: order.user.reputation,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16),
              child: OrderQuantityPriceWidget(
                quantity: order.quantity,
                price: order.platinum.toInt(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderCardLeading extends StatelessWidget {
  const _OrderCardLeading({
    Key? key,
    this.avatar,
    required this.orderType,
    required this.status,
  }) : super(key: key);

  final String? avatar;
  final OrderType orderType;
  final UserStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAvatar(avatar: avatar, status: status),
        OrderTypeLabel(orderType: orderType)
      ],
    );
  }
}

class _OrderCardBody extends StatelessWidget {
  const _OrderCardBody({
    Key? key,
    required this.username,
    required this.reputation,
  }) : super(key: key);

  final String username;
  final int reputation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 2, bottom: 2),
                child: Icon(Icons.tag_faces, size: 15),
              ),
              Text(
                'Reputation $reputation',
                style: textTheme.caption,
              )
            ],
          ),
        )
      ],
    );
  }
}
