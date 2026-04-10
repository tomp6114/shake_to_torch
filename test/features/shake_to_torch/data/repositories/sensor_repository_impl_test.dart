import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shake_to_torch/core/error/exceptions.dart';
import 'package:shake_to_torch/features/shake_to_torch/data/repositories/sensor_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late SensorRepositoryImpl repository;
  const channel = MethodChannel('com.tompvarghese.shake_to_torch/torch');
  bool failNextCall = false;

  setUp(() {
    repository = SensorRepositoryImpl();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (failNextCall) {
        throw PlatformException(code: 'ERROR', message: 'Simulated failure');
      }
      return null;
    });
    failNextCall = false;
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('startListening', () {
    test('should succeed normally', () async {
      expect(() async => await repository.startListening(), returnsNormally);
    });

    test('should throw NativeSensorException on failure', () async {
      failNextCall = true;
      expect(() async => await repository.startListening(), throwsA(isA<NativeSensorException>()));
    });
  });
}
