import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final authBloc = getIt<AuthBloc>();
  authBloc.add(AppStarted());

  runApp(BlocProvider<AuthBloc>.value(value: authBloc, child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<GoRouter>();

    return MaterialApp.router(
      title: 'LYQX Test',
      debugShowCheckedModeBanner: false,

      routerConfig: router,

      theme: ThemeData.light(),
    );
  }
}
