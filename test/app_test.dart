// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:bazar_repository/bazar_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:market/app/app.dart';
import 'package:market/bazar/view/bazar_page.dart';

void main() {
  late BazarCache cache;
  late BazarRepository repository;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Hive.init(Directory.systemTemp.path);

    cache = BazarCache(temp: await Hive.openBox<dynamic>('bazar_cache'));
    repository = BazarRepository(cache: cache);
  });

  group('App', () {
    testWidgets('renders BazarPage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: repository,
          child: const App(),
        ),
      );
      expect(find.byType(BazarPage), findsOneWidget);
    });
  });
}
