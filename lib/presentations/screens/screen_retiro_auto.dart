import 'package:app_de_estacionamiento/presentations/widgets/dialog_box_retiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RetirarAuto extends StatefulWidget {
  static const String name = 'RetirarAuto';
  const RetirarAuto({super.key});

  @override
  State<RetirarAuto> createState() => _RetirarAutoState();
}

class _RetirarAutoState extends State<RetirarAuto> {
  // Alerta => Info de la busqueda
  void showBox() {
    showDialog(
        context: context,
        builder: (context) {
          return BoxDialogRetiro(onCancel: onCancel);
        });
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    TextEditingController _patenteController = TextEditingController();

    Future<void> retirarAuto(String patenteBuscado) async {
      QuerySnapshot querySnap = await db
          .collection('Vehiculos')
          .where('patente', isEqualTo: patenteBuscado)
          .limit(1)
          .get();

      if (querySnap.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnap.docs.first;

        QuerySnapshot querySnap2 = await FirebaseFirestore.instance
            .collection('UsuariosVehiculos')
            .where('idVehiculo', isEqualTo: userDoc.id)
            .limit(1)
            .get();

        DocumentSnapshot userVehiculoDoc2 = querySnap2.docs.first;
        userDoc.reference.delete();
        userVehiculoDoc2.reference.delete();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Retirar auto'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Input Patente
            TextFormField(
              controller: _patenteController,
              decoration: const InputDecoration(
                labelText: 'Patente',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 50),

            // Boton retirar
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await retirarAuto(_patenteController.text);
                    //showBox();
                  },
                  child: const Text(
                    'retirar',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
