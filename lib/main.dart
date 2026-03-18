import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/shake_to_torch/data/repositories/sensor_repository_impl.dart';
import 'features/shake_to_torch/data/repositories/settings_repository_impl.dart';
import 'features/shake_to_torch/data/repositories/torch_repository_impl.dart';
import 'features/shake_to_torch/domain/usecases/get_sensitivity.dart';
import 'features/shake_to_torch/domain/usecases/listen_to_shake.dart';
import 'features/shake_to_torch/domain/usecases/toggle_torch.dart';
import 'features/shake_to_torch/domain/usecases/update_sensitivity.dart';
import 'features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';
import 'features/shake_to_torch/presentation/pages/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final settingsRepository = SettingsRepositoryImpl(prefs);
  final sensorRepository = SensorRepositoryImpl();
  final torchRepository = TorchRepositoryImpl();

  runApp(MyApp(
    settingsRepository: settingsRepository,
    sensorRepository: sensorRepository,
    torchRepository: torchRepository,
  ));
}

class MyApp extends StatelessWidget {
  final SettingsRepositoryImpl settingsRepository;
  final SensorRepositoryImpl sensorRepository;
  final TorchRepositoryImpl torchRepository;

  const MyApp({
    super.key,
    required this.settingsRepository,
    required this.sensorRepository,
    required this.torchRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shake to Torch',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
      ),
      home: BlocProvider(
        create: (_) => ShakeTorchBloc(
          getSensitivity: GetSensitivityUseCase(settingsRepository),
          updateSensitivity: UpdateSensitivityUseCase(settingsRepository, sensorRepository),
          listenToShake: ListenToShakeUseCase(sensorRepository),
          toggleTorch: ToggleTorchUseCase(torchRepository),
          torchRepository: torchRepository,
        ),
        child: const DashboardPage(),
      ),
    );
  }
}
