import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shake_to_torch/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end load test validating Dashboard wiring', (tester) async {
    app.main();
    
    // Wait until loading indicator finishes fetching settings
    await tester.pumpAndSettle();

    expect(find.text('Shake to Torch'), findsOneWidget);

    expect(find.text('Service Inactive'), findsOneWidget);

    await tester.tap(find.text('Enable Background Sensor'));
    await tester.pumpAndSettle();

    expect(find.text('Shake Detection Active'), findsOneWidget);

    await tester.tap(find.text('High'));
    await tester.pumpAndSettle();
  });
}
