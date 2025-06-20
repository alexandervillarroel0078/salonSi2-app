import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cita_controller.dart';

class CitaScreen extends StatefulWidget {
  final int clienteId;
  const CitaScreen({Key? key, required this.clienteId}) : super(key: key);

  @override
  State<CitaScreen> createState() => _CitaScreenState();
}

class _CitaScreenState extends State<CitaScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CitaController>(
      context,
      listen: false,
    ).cargarCitas(widget.clienteId);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CitaController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Citas')),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : controller.citas.isEmpty
          ? const Center(child: Text('No tienes citas registradas'))
          : ListView.builder(
              itemCount: controller.citas.length,
              itemBuilder: (context, index) {
                final cita = controller.citas[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text('Código: ${cita.codigo}'),
                    subtitle: Text(
                      '${cita.fecha} - ${cita.hora} (${cita.estado})',
                      style: const TextStyle(fontSize: 14),
                    ),
                    children: cita.servicios.map((servicio) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(servicio.imagen),
                        ),
                        title: Text(servicio.nombre),
                        subtitle: Text(
                          'Especialista: ${servicio.personal.nombre}',
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Bs ${servicio.precio.toStringAsFixed(2)}'),
                            Text(
                              '${servicio.duracion} min',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
