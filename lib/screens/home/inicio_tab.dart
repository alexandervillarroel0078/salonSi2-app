// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../service_screen.dart';
import '../personal_screen.dart'; // Asegúrate que la ruta es correcta

class InicioTab extends StatelessWidget {
  const InicioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 203, 249),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _customButton(
              context,
              icon: Icons.design_services_rounded,
              label: 'Ver Servicios',
              destination: const ServiceScreen(),
            ),
            const SizedBox(height: 20),
            _customButton(
              context,
              icon: Icons.people_alt_rounded,
              label: 'Ver Especialistas',
              destination: const PersonalScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget destination,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.indigoAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigoAccent, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.indigoAccent),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.indigoAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
