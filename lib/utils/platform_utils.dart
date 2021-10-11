import 'dart:io';

bool get isDesktop {
  return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
}
