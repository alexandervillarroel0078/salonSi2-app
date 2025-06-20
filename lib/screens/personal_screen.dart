import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/personal_controller.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalListScreenState();
}

class _PersonalListScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PersonalController>(context, listen: false).cargarPersonal();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PersonalController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Especialistas')),
      body: controller.cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: controller.listaPersonal.length,
              itemBuilder: (context, index) {
                final personal = controller.listaPersonal[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          (personal.photoUrl != null &&
                              personal.photoUrl!.isNotEmpty)
                          ? NetworkImage(personal.photoUrl!)
                          : null,
                      child:
                          (personal.photoUrl == null ||
                              personal.photoUrl!.isEmpty)
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(personal.name),
                    subtitle: Text(personal.descripcion ?? 'Sin descripción'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Aquí puedes redirigir al detalle en el futuro
                      },
                      child: const Text('Ver detalles'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
