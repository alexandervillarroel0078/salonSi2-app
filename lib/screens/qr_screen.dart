// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart'; 

class QrScreen extends StatelessWidget {
  final int agendaId;

  const QrScreen({super.key, required this.agendaId});

  Future<void> _confirmarPago(BuildContext context) async {
  final url = Uri.parse('${AppConfig.baseUrl}/pagos/qr/confirmar/$agendaId');
 
    final respuesta = await http.post(url);

    if (respuesta.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pago confirmado ✅')));
      Navigator.pop(context, true); // Vuelve y recarga citas si deseas
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al confirmar pago ❌')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  final urlQr = '${AppConfig.baseUrl}/pagos/qr/$agendaId';

    return Scaffold(
      appBar: AppBar(title: const Text('Escanea y paga con QR')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  urlQr,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('No se pudo cargar el QR'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Confirmar Pago'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => _confirmarPago(context),
            ),
          ],
        ),
      ),
    );
  }
}
