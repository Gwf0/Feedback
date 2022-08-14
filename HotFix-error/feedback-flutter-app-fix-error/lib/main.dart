// @dart=2.9

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:feedback24_app/app/app.dart';
import 'package:feedback24_app/shared/bootstrap.dart';
import 'package:feedback24_app/shared/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  await registerSingletonLocators();
  bootstrap(() => const App());
}
