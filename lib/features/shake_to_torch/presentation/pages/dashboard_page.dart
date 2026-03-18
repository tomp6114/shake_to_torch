import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/shake_torch_bloc.dart';
import '../bloc/shake_torch_event.dart';
import '../bloc/shake_torch_state.dart';
import '../../domain/entities/shake_sensitivity.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    context.read<ShakeTorchBloc>().add(LoadSettingsEvent());
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      if (Platform.isAndroid) Permission.notification, // for foreground service
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shake to Torch'),
        centerTitle: true,
      ),
      body: BlocBuilder<ShakeTorchBloc, ShakeTorchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}', 
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  state.isTorchOn ? Icons.flashlight_on : Icons.flashlight_off,
                  size: 100,
                  color: state.isTorchOn ? Colors.amber : Colors.grey,
                ),
                const SizedBox(height: 40),
                Text(
                  state.isServiceActive ? "Shake Detection Active" : "Service Inactive",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text('Enable Background Sensor'),
                  subtitle: const Text('Keep running while minimized'),
                  value: state.isServiceActive,
                  onChanged: (val) {
                    context.read<ShakeTorchBloc>().add(ToggleServiceEvent(val));
                  },
                ),
                const Divider(),
                const Text('Shake Sensitivity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SegmentedButton<ShakeSensitivity>(
                  segments: const [
                    ButtonSegment(value: ShakeSensitivity.high, label: Text('High')),
                    ButtonSegment(value: ShakeSensitivity.medium, label: Text('Medium')),
                    ButtonSegment(value: ShakeSensitivity.low, label: Text('Low')),
                  ],
                  selected: {state.sensitivity},
                  onSelectionChanged: (Set<ShakeSensitivity> newSelection) {
                    context.read<ShakeTorchBloc>().add(SensitivityChangedEvent(newSelection.first));
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Shake the device back-and-forth dynamically to toggle!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
