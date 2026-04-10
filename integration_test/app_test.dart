import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shake_to_torch/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end load test validating Dashboard wiring', (tester) async {
    // Start the app natively and wait for runApp to finish
    app.main();
    
    // Wait until loading indicator finishes fetching settings
    await tester.pumpAndSettle();

    expect(find.text('Shake to Torch'), findsOneWidget);

    // Initial default layout check
    expect(find.text('Service Inactive'), findsOneWidget);

    // Emulate tapping the Switch button to initialize the service
    await tester.tap(find.text('Enable Background Sensor'));
    await tester.pumpAndSettle();

    // Verify it activated successfully
    expect(find.text('Shake Detection Active'), findsOneWidget);

    // Swap sensitivity correctly to High
    await tester.tap(find.text('High'));
    await tester.pumpAndSettle();
  });
}
