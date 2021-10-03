import 'package:market_client/market_client.dart';

// We can't pass the client itself from isolate to isolate, but we can pass the
// the params and create the clients in the isolates.
class MarketClientRequest {
  const MarketClientRequest({this.item, required this.platform, this.language});

  final String? item;
  final MarketPlatform platform;
  final String? language;
}
