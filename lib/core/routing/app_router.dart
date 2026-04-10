import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/shake_to_torch/presentation/pages/dashboard_page.dart';
import '../../features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';
import '../di/injection.dart';

class AppRouter {
  static const String dashboard = '/';

  static final router = GoRouter(
    initialLocation: dashboard,
    routes: [
      GoRoute(
        path: dashboard,
        builder: (context, state) => BlocProvider<ShakeTorchBloc>(
          create: (_) => getIt<ShakeTorchBloc>(),
          child: const DashboardPage(),
        ),
      ),
    ],
  );
}
