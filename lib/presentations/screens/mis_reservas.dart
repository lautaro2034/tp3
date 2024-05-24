import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/card_reserva.dart';
import '../widgets/drawer_menu_lateral.dart';
import 'home.dart';
import 'screen_menu_lateral.dart';

class MisReservas extends StatefulWidget {
  static const String name = 'misReservas';

  const MisReservas({super.key});

  @override
  State<MisReservas> createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScreenMenuLateral(),
      drawer: const DrawerMenuLateral(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            
          children: [
            // Titulo
            const Text('Mis reservas', 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 25
              ),),
          
            const SizedBox(height: 25,),
              
          
          
            // Reservas
            Expanded(
              child: ListView.builder(
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return CardReserva(titulito: 'Reserva $index',);
                },
                ),
            ),
          

          
            // Boton 'Volver'
            ElevatedButton(
            onPressed: () {
              context.goNamed(Home.name);
            },
            child: const Text('Volver')
            )
            
          
          ],
                ),
        )
    ));
  }
}