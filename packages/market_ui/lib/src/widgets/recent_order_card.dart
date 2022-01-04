import 'dart:io';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_client/market_client.dart';
import 'package:market_ui/src/widgets/order_type_label.dart';
import 'package:market_ui/src/widgets/price_quantity.dart';
import 'package:market_ui/src/widgets/user_avatar.dart';

/// {@template recent_order_card}
// ignore: comment_references
/// Like [OrderCard] but with a different layout to display the item as the
/// center of focus and the seller/buyer at the bottom.
/// {@endtemplate}
class RecentOrderCard extends StatelessWidget {
  /// {@macro recent_order_card}
  const RecentOrderCard({Key? key, required this.order}) : super(key: key);

  /// The order itself.
  final RecentOrder order;

  @override
  Widget build(BuildContext context) {
    final price = order.platinum.toInt();
    final orderType = order.orderType;

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
                orderType: orderType,
                quantity: order.quantity,
                price: price,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: _RecentOrderUserInfo(
                user: order.user,
                item: order.item.en.itemName,
                price: price,
                orderType: orderType,
              ),
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
            width: 50,
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
          ),
        ),
        PriceQuantity(quantity: quantity, price: price)
      ],
    );
  }
}

class _RecentOrderUserInfo extends StatelessWidget {
  const _RecentOrderUserInfo({
    Key? key,
    required this.user,
    required this.item,
    required this.price,
    required this.orderType,
  }) : super(key: key);

  final MarketUser user;
  final String item;
  final int price;
  final OrderType orderType;

  Future<void> _copyMessage(BuildContext context) async {
    final theme = Theme.of(context);
    final snackBarText =
        theme.textTheme.subtitle1?.copyWith(color: Colors.white);
    final requestType = OrderType.buy == orderType ? 'buy' : 'sell';

    if (Platform.isWindows) {
      await Clipboard.setData(
        ClipboardData(
          text:
              '/w ${user.ingameName} I want to $requestType: $item for $price '
              'platinum. (warframe.market)',
        ),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Copied to clipboard',
            style: snackBarText,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final windowsType = getWindowType(context);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  user.ingameName,
                  style: textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
        if (windowsType == AdaptiveWindowType.medium ||
            windowsType == AdaptiveWindowType.large ||
            windowsType == AdaptiveWindowType.xlarge)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Not yet Implmented.'),
                    backgroundColor: Colors.white,
                  ),
                );
              },
              child: const Text('Message'),
            ),
          ),
        ElevatedButton(
          onPressed: () => _copyMessage(context),
          child: Text(OrderType.buy == orderType ? 'BUY' : 'SELL'),
        )
      ],
    );
  }
}
