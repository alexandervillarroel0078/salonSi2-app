import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'qr_screen.dart';
import '../config.dart'; 

class PagoScreen extends StatelessWidget {
  final int agendaId;

  const PagoScreen({super.key, required this.agendaId});

  Future<void> _pagarConStripe() async {
  final url = Uri.parse('${AppConfig.baseUrl}/pagos/stripe/$agendaId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('No se pudo abrir Stripe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona método de pago')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.credit_card),
              label: const Text('Pagar con Stripe'),
              onPressed: _pagarConStripe,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code),
              label: const Text('Pagar con QR'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrScreen(agendaId: agendaId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
