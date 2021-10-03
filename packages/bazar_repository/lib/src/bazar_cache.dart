import 'package:hive/hive.dart';
import 'package:market_client/market_client.dart';

class BazarCache {
  BazarCache({required Box temp}) : _temp = temp;

  final Box _temp;

  static const _itemsTimestamp = 'marketItemTimestampe';
  static const _marketItems = 'marketItems';

  void cacheItems(List<MarketItem> items) {
    _temp
      ..put(_itemsTimestamp, DateTime.now())
      ..put(_marketItems, items.map((e) => e.toJson()).toList());
  }

  DateTime? getItemTimestamp() {
    return _temp.get(_itemsTimestamp) as DateTime?;
  }

  List<MarketItem>? getItems() {
    final cache = _temp.get(_marketItems) as List<Map<String, dynamic>>?;

    if (cache != null) {
      return cache.map((e) => MarketItem.fromJson(e)).toList();
    }

    return null;
  }
}
