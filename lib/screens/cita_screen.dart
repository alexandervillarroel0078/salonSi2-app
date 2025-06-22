// ignore_for_file: use_super_parameters, unused_import, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cita_controller.dart';
import '../screens/calificar_screen.dart';
import '../models/cita.dart';
import '../screens/pago_screen.dart';

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
      appBar: AppBar(
        title: const Text('Mis Citas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : controller.citas.isEmpty
          ? const Center(child: Text('No tienes citas registradas'))
          : ListView.builder(
              itemCount: controller.citas.length,
              itemBuilder: (context, index) {
                final cita = controller.citas[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      'Código: ${cita.codigo}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${cita.fecha} - ${cita.hora}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        Chip(
                          label: Text(
                            cita.estado.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: _colorEstado(cita.estado),
                        ),
                      ],
                    ),
                    children: [
                      ...cita.servicios.map((servicio) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(servicio.imagen),
                          ),
                          title: Text(servicio.nombre),
                          subtitle: Text(
                            'Especialista: ${servicio.personal.nombre}',
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Bs ${servicio.precio.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${servicio.duracion} min',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      const Divider(),

                      // Total
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Bs ${cita.precioTotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // BOTÓN PARA PAGAR
                      if (cita.estado.toLowerCase() == 'pendiente')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.qr_code),
                            label: const Text('Pagar ahora'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              minimumSize: const Size.fromHeight(40),
                            ),
                            onPressed: () async {
                              final pagado = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PagoScreen(agendaId: cita.id),
                                ),
                              );
                              if (pagado == true) {
                                controller.cargarCitas(widget.clienteId);
                              }
                            },
                          ),
                        ),

                      const SizedBox(height: 8),

                      // BOTÓN PARA CONFIRMAR Y CALIFICAR
                      if (cita.estado.toLowerCase() == 'por confirmar')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.star),
                            label: const Text('Confirmar y calificar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[800],
                              minimumSize: const Size.fromHeight(40),
                            ),
                            onPressed: () async {
                              final confirmado = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CalificarCitaScreen(cita: cita),
                                ),
                              );
                              if (confirmado == true) {
                                controller.cargarCitas(widget.clienteId);
                              }
                            },
                          ),
                        ),

                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
            ),
    );
  }

  //colres
  Color _colorEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'en_curso':
        return Colors.blue;
      case 'por confirmar':
        return Colors.deepPurple;
      case 'finalizada':
        return Colors.green;
      case 'cancelada':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
