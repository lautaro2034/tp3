import 'package:app_de_estacionamiento/presentations/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class BuscadorAuto extends StatefulWidget {
  static const String name = 'BuscadorAuto';
  const BuscadorAuto({super.key});

  @override
  State<BuscadorAuto> createState() => _BuscadorAutoState();
}

class _BuscadorAutoState extends State<BuscadorAuto> {


  // Alerta => Info de la busqueda
  void showBox(){
    showDialog(
      context: context, 
      builder: (context) {
        return BoxDialog(
          onCancel: onCancel
          );
      }
      
      );
  }

  void onCancel(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Buscar auto'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            // Input Modelo
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
              ),


              const SizedBox(height: 55),


              // Input Patente
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Patente',
                  border: OutlineInputBorder(),
                ),
              ),


              const SizedBox(height: 50),
              

              // Input Marca
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 80),

              // Boton Buscar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  showBox();
                }, 
                  child: const Text('Buscar', style: TextStyle(
                    fontSize: 18
                  ),),

                )
              )
            
            ]
              
            
          ),
        ),
      ),
    );
  }
}
