// confirm_reservation_page.dart
import 'package:flutter/material.dart';

class ConfirmReservationPage extends StatefulWidget {
  const ConfirmReservationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmReservationPageState createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirmar Reserva'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 55),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Patente',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {},
                child: const Center(child: Text('confirmar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
