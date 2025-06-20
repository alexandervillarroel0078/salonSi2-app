import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/service_controller.dart';
import '../models/service.dart';
import 'service_detail_screen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceController>(context, listen: false).cargarServicios();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ServiceController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Servicios Disponibles')),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.servicios.length,
              itemBuilder: (context, index) {
                final Service servicio = controller.servicios[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(servicio.imagePath),
                      radius: 25,
                    ),
                    title: Text(servicio.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(servicio.description),
                        Text('Precio: Bs ${servicio.price.toStringAsFixed(2)}'),
                        if (servicio.hasDiscount)
                          Text(
                            'Descuento: Bs ${servicio.discountPrice.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        Text('Duración: ${servicio.durationMinutes} minutos'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ServiceDetailScreen(serviceId: servicio.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
