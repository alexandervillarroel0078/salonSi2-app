import 'package:flutter/material.dart';

class MisCitasTab extends StatelessWidget {
  const MisCitasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Mis Citas',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
