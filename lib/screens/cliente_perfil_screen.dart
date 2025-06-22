// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cliente_controller.dart';

class ClientePerfilScreen extends StatefulWidget {
  final int clienteId;

  const ClientePerfilScreen({Key? key, required this.clienteId})
    : super(key: key);

  @override
  State<ClientePerfilScreen> createState() => _ClientePerfilScreenState();
}

class _ClientePerfilScreenState extends State<ClientePerfilScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClienteController>(
      context,
      listen: false,
    ).cargarPerfil(widget.clienteId);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClienteController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : controller.perfil == null
          ? const Center(child: Text('No se pudo cargar el perfil.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.perfil!.photoUrl != null
                        ? NetworkImage(controller.perfil!.photoUrl!)
                        : null,
                    child: controller.perfil!.photoUrl == null
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.perfil!.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.perfil!.email ?? 'Sin correo',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.perfil!.phone ?? 'Sin teléfono',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.perfil!.status ? 'Activo' : 'Inactivo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: controller.perfil!.status
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const Divider(height: 40),
                  const ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Editar Perfil'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                  const ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text('Cambiar Contraseña'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                  const ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Método de Pago'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  ),

                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Ajustes de Cuenta'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                  const ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('Acerca de la App'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                  const ListTile(
                    leading: Icon(Icons.logout, color: Colors.redAccent),
                    title: Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
