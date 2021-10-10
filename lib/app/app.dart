// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bazar_repository/bazar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:market/bazar/view/bazar_page.dart';
import 'package:market/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF344955),
        primaryColorDark: const Color(0xFF0a212b),
        primaryColorLight: const Color(0xFF5e7380),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF344955),
          primaryVariant: Color(0xFF0a212b),
          secondary: Color(0xFFfaab1a),
          secondaryVariant: Color(0xFFc27c00),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: BazarPage(
        repository: RepositoryProvider.of<BazarRepository>(context),
      ),
    );
  }
}
