import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market/bazar/widgets/order_quantity_price.dart';
import 'package:market/bazar/widgets/order_type_label.dart';
import 'package:market/bazar/widgets/user_avatar.dart';
import 'package:market_client/market_client.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RecentOrderCard extends StatelessWidget {
  const RecentOrderCard({Key? key, required this.order}) : super(key: key);

  final ItemOrder order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: _RecentOrderInfo(
                item: order.item,
                orderType: order.orderType,
                quantity: order.quantity,
                price: order.platinum.toInt(),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: _RecentOrderUserInfo(user: order.user),
            )
          ],
        ),
      ),
    );
  }
}

class _RecentOrderInfo extends StatelessWidget {
  const _RecentOrderInfo({
    Key? key,
    required this.item,
    required this.orderType,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final OrderItem item;
  final OrderType orderType;
  final int quantity, price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: CachedNetworkImage(
            imageUrl: item.thumbnailUri.toString(),
            width: getValueForScreenType(
              context: context,
              mobile: 50,
              tablet: 60,
            ),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.en.itemName,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            OrderTypeLabel(orderType: orderType)
          ],
        )),
        OrderQuantityPriceWidget(quantity: quantity, price: price)
      ],
    );
  }
}

class _RecentOrderUserInfo extends StatelessWidget {
  const _RecentOrderUserInfo({Key? key, required this.user}) : super(key: key);

  final MarketUser user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: UserAvatar(
            avatar: user.avatar,
            status: user.status,
            radius: 15,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  user.ingameName,
                  style: textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4, bottom: 2),
                    child: Icon(Icons.tag_faces_outlined, size: 15),
                  ),
                  Text(
                    'Reputation ${user.reputation}',
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
