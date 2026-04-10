import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/di/injection.dart';
import 'core/routing/app_router.dart';

void main() async {
  unawaited(runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await initDI();
    
    final dsn = dotenv.env['SENTRY_DSN'];
    if (dsn != null && dsn.isNotEmpty) {
      await SentryFlutter.init(
        (options) {
          options.dsn = dsn;
          options.tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(const MyApp()),
      );
    } else {
      runApp(const MyApp());
    }
  }, (error, stack) async {
    final log = Logger();
    log.e('Uncaught Zone Error', error: error, stackTrace: stack);
    await Sentry.captureException(error, stackTrace: stack);
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shake to Torch',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
