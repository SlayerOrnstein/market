import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';

class UserStatusLabel extends StatelessWidget {
  const UserStatusLabel({Key? key, required this.status}) : super(key: key);

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
