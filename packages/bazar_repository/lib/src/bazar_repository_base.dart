import 'package:bazar_repository/src/bazar_cache.dart';
import 'package:bazar_repository/src/market_client_request.dart';
import 'package:flutter/foundation.dart';
import 'package:market_client/market_client.dart';

class BazarRepository {
  BazarRepository({required BazarCache cache}) : _cache = cache;

  final BazarCache _cache;

  Future<List<MarketItem>> getMarketItems() async {
    final now = DateTime.now();
    final cTimestamp = _cache.getItemTimestamp();

    if (cTimestamp == null ||
        cTimestamp.difference(now) < const Duration(days: 7)) {
      const req = MarketClientRequest(
        platform: MarketPlatform.pc,
        language: 'en',
      );

      final items = await compute(_getItems, req);

      _cache.cacheItems(items);

      return items;
    }

    return _cache.getItems()!;
  }

  Future<MarketOrders> searchOrders(String urlName) async {
    final req = MarketClientRequest(
      item: urlName,
      platform: MarketPlatform.pc,
      language: 'en',
    );

    return compute(_searchOrders, req);
  }

  Future<RecentMarketOrders> mostRecentOrders() async {
    const req = MarketClientRequest(
      platform: MarketPlatform.pc,
      language: 'en',
    );

    return compute(_mostRecentorders, req);
  }

  static Future<MarketOrders> _searchOrders(MarketClientRequest req) async {
    final api = createClient(req.platform, req.language);

    return api.searchOrders(req.item!);
  }

  static Future<RecentMarketOrders> _mostRecentorders(
      MarketClientRequest req) async {
    final api = createClient(req.platform, req.language);

    return api.mostRecentOrders();
  }

  static Future<List<MarketItem>> _getItems(MarketClientRequest req) async {
    final api = createClient(req.platform, req.language);

    return api.getMarketItems();
  }

  static MarketClient createClient(MarketPlatform platform, String? language) {
    final client =
        MarketHttpClient(platform: platform, language: language ?? 'en');

    return MarketClient(client: client);
  }
}
