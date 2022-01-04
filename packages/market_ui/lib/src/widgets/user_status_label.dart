import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';

/// {@template user_status_label}
/// Displays the [UserStatus] in a solid color container.
/// {@endtemplate}
class UserStatusLabel extends StatelessWidget {
  /// {@macro user_status_label}
  const UserStatusLabel({Key? key, required this.status}) : super(key: key);

  /// The user status.
  final UserStatus status;

  @override
  Widget build(BuildContext context) {
    return Text(
      () {
        switch (status) {
          case UserStatus.online:
            return 'ONLINE';
          case UserStatus.ingame:
            return 'ONLINE IN GAME';
          case UserStatus.offline:
            return 'OFFLINE';
        }
      }(),
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
        color: () {
          switch (status) {
            case UserStatus.online:
              return Colors.green;
            case UserStatus.ingame:
              return Colors.purple;
            case UserStatus.offline:
              return Colors.grey[600];
          }
        }(),
      ),
    );
  }
}
