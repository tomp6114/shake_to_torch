import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_event.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_state.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/pages/dashboard_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockShakeTorchBloc extends MockBloc<ShakeTorchEvent, ShakeTorchState> implements ShakeTorchBloc {}

void main() {
  late MockShakeTorchBloc mockBloc;

  setUp(() {
    mockBloc = MockShakeTorchBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ShakeTorchBloc>.value(
        value: mockBloc,
        child: const DashboardPage(),
      ),
    );
  }

  testWidgets('displays loading indicator initially', (tester) async {
    when(() => mockBloc.state).thenReturn(ShakeTorchState.initial().copyWith(isLoading: true));
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays main UI and switch when loaded', (tester) async {
    when(() => mockBloc.state).thenReturn(
      ShakeTorchState.initial().copyWith(isLoading: false, isServiceActive: true),
    );
    await tester.pumpWidget(createWidgetUnderTest());
    
    expect(find.text('Shake Detection Active'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text('High'), findsOneWidget);
  });
}
