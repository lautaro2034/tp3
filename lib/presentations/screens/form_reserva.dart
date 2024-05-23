import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Confirmar Reserva'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            context.goNamed(BookingCalendarDemoApp.name);
                          },
                          child: const Center(child: Text('confirmar')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
