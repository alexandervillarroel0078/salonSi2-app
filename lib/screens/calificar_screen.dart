// ignore_for_file: use_super_parameters, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/calificacion_api.dart';

class CalificarCitaScreen extends StatefulWidget {
  final Cita cita;

  const CalificarCitaScreen({Key? key, required this.cita}) : super(key: key);

  @override
  State<CalificarCitaScreen> createState() => _CalificarCitaScreenState();
}

class _CalificarCitaScreenState extends State<CalificarCitaScreen> {
  final Map<int, int> valoraciones = {};
  final Map<int, String> comentarios = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _enviando = false;

  Future<void> _confirmar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _enviando = true);
    final exito = await CalificacionApi.enviarCalificacion(
      widget.cita.id,
      valoraciones,
      comentarios,
    );

    setState(() => _enviando = false);
    if (exito) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar la calificación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar y calificar')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final servicio in widget.cita.servicios)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(servicio.imagen),
                          radius: 24,
                        ),
                        title: Text(
                          servicio.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          'Especialista: ${servicio.personal.nombre}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText: 'Calificación',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: valoraciones[servicio.id],
                        onChanged: (valor) => setState(
                          () => valoraciones[servicio.id] = valor ?? 0,
                        ),
                        validator: (val) =>
                            val == null ? 'Selecciona una calificación' : null,
                        items: List.generate(5, (i) => i + 1).map((i) {
                          return DropdownMenuItem(
                            value: i,
                            child: Text('$i ⭐'),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Comentario',
                          hintText: 'Escribe tu opinión sobre el servicio...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxLines: 2,
                        onChanged: (texto) => comentarios[servicio.id] = texto,
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),
            _enviando
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                    onPressed: _confirmar,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirmar y finalizar cita'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
