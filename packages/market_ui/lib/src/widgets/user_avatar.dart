import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.avatar,
    required this.status,
    this.radius,
    this.minRadius,
    this.maxRadius,
  }) : super(key: key);

  final String? avatar;
  final UserStatus status;
  final double? radius, minRadius, maxRadius;

  static const _defaultAvater = 'user/default-avatar.png';

  // The default max if only the min is specified.
  //
  // borrowed this from flutter
  static const double _defaultMaxRadius = double.infinity;

  // The default radius if nothing is specified.
  static const double _defaultRadius = 20;

  // The default min if only the max is specified.
  static const double _defaultMinRadius = 0;

  double get _minDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return 2.0 * (radius ?? minRadius ?? _defaultMinRadius);
  }

  double get _maxDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return 2.0 * (radius ?? maxRadius ?? _defaultMaxRadius);
  }

  @override
  Widget build(BuildContext context) {
    final url =
        'https://warframe.market/static/assets/${avatar ?? _defaultAvater}';

    return Container(
      constraints: BoxConstraints(
        minHeight: _minDiameter,
        minWidth: _minDiameter,
        maxWidth: _maxDiameter,
        maxHeight: _maxDiameter,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: () {
            switch (status) {
              case UserStatus.online:
                return Colors.green;
              case UserStatus.ingame:
                return Colors.purple;
              case UserStatus.offline:
                return Colors.grey[600]!;
            }
          }(),
        ),
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
