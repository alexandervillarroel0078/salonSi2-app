import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/login_controller.dart';
import 'controllers/service_controller.dart';
import 'controllers/service_detail_controller.dart';
import 'controllers/cita_controller.dart';

import 'controllers/cliente_controller.dart';
import 'controllers/personal_controller.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final clienteId = prefs.getInt('cliente_id');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ServiceController()),

        ChangeNotifierProvider(create: (_) => ClienteController()),
        ChangeNotifierProvider(create: (_) => PersonalController()),

        ChangeNotifierProvider(create: (_) => ServiceDetailController()),

        ChangeNotifierProvider(create: (_) => CitaController()),
      ],
      child: MyApp(isLoggedIn: clienteId != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salón App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: isLoggedIn ? '/main' : '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/main': (_) => const HomeScreen(),
      },
    );
  }
}
