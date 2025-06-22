// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart'; // Asegúrate de importar bien

class LoginController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _clienteId;
  int? get clienteId => _clienteId;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setLoading(true);

    final response = await ApiService.login(
      emailController.text,
      passwordController.text,
    );

    if (response.containsKey('token') && response.containsKey('user')) {
      final user = response['user'];
      final token = response['token'];

      _clienteId = user['cliente_id'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cliente_id', _clienteId!);
      await prefs.setString('token', token);

      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? 'Error al iniciar sesión'),
        ),
      );
    }

    setLoading(false);
  }
}
