import 'package:bazar_repository/bazar_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:market/app/app.dart';
import 'package:path_provider/path_provider.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final tempPath = await getTemporaryDirectory();

    Hive.init(tempPath.path);
  }

  final cache = BazarCache(temp: await Hive.openBox<dynamic>('bazar_cache'));
  final repository = BazarRepository(cache: cache);

  runApp(
    RepositoryProvider.value(
      value: repository,
      child: const App(),
    ),
  );
}
