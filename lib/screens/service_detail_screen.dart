import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/service_detail_controller.dart';
import '../models/service_detail.dart';

class ServiceDetailScreen extends StatefulWidget {
  final int serviceId;
  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceDetailController>(
      context,
      listen: false,
    ).cargarDetalle(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ServiceDetailController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Servicio')),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : controller.detalle == null
          ? const Center(child: Text('No se pudo cargar la información'))
          : _detalleView(controller.detalle!),
    );
  }

  Widget _detalleView(ServiceDetail detalle) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(detalle.servicioImagen, height: 180),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            detalle.servicioNombre,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Especialistas disponibles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...detalle.personalCalificado.map(
            (p) => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  p.photoUrl ?? 'https://via.placeholder.com/150',
                ),
              ),

              title: Text(p.name),
            ),
          ),
        ],
      ),
    );
  }
}
