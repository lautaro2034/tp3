import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/Core/Entities/Vehiculo.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';
import 'package:flutter/material.dart';
import 'package:app_de_estacionamiento/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calendar_demo extends ConsumerStatefulWidget {
  static final String name = 'Calendar_demo';

  const Calendar_demo({super.key});

  @override
  _Calendar_demoState createState() => _Calendar_demoState();
}

class _Calendar_demoState extends ConsumerState<Calendar_demo> {
  final algunasReservas = [
    Reserva(
        fecha: 7,
        lote: 1,
        elvehiculo: Vehiculo(
            patente: 'fgh123',
            marca: 'Ferrari',
            modelo: 'modelo',
            idDuenio: "RIWofZj3xzRRHeMRg73YUZCG89m2")),
  ];

  List<Reserva> reservasDelDia = [];
  int? _selectedButtonIndex;
  int? fechaSeleccionada;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  void _filtrarReservasPorFecha(int dia) {
    setState(() {
      reservasDelDia =
          algunasReservas.where((reserva) => reserva.fecha == dia).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(kToday.year, kToday.month - 3, kToday.day),
          lastDate: DateTime(kToday.year, kToday.month + 3, kToday.day),
          //currentDate: DateTime(2024, 06, 09),
          onDateChanged: (DateTime value) {
            setState(() {
              fechaSeleccionada = value.day;
              _selectedButtonIndex = null;
            });
            _filtrarReservasPorFecha(fechaSeleccionada!);
          },
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0, // Espacio horizontal entre los elementos
              runSpacing: 8.0, // Espacio vertical entre las filas
              children: List.generate(10, (nroLote) {
                bool isSelected = false;
                for (var reserva in reservasDelDia) {
                  if (reserva.lote == nroLote) {
                    isSelected = true;
                    break;
                  }
                }

                return SizedBox(
                    height: 80,
                    child: Lote(
                        loteData: LoteData(id: nroLote, estaReservado: false)

                        /* identificador: 'P$nroLote',
                        isSelected:
                            _selectedButtonIndex == nroLote || isSelected,
                        onPressed: () => _onButtonPressed(nroLote))); */
                        ));
              }),
            ),
          ),
        ),

        // Estilo
        /*Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2, // Hacer botones rectangulares
            ),
            itemCount: listaLotes.length,
            itemBuilder: (context, index) {
              final elLote = Lote(loteData: listaLotes[index]);
              final elvehiculo = ref.read(vehiculoProvider);

              final laReserva = Reserva(
                  fecha: fechaSeleccionada!.day,
                  lote: elLote.loteData.id,
                  elvehiculo: elvehiculo);

              return Lote(
                  loteData: listaLotes[index],
                  onTap: () {
                    print(laReserva);
                    print(fechaSeleccionada.toString());
                    print(elLote.loteData.id);
                    _reservarPosicion(index);

                    FirebaseFirestore.instance
                        .collection('Reservas')
                        .add(laReserva.toFirestore());
                  });
            },
          ),
        ),*/

        ElevatedButton(
            onPressed: () {
              if (fechaSeleccionada != null && _selectedButtonIndex != null) {
                Reserva reserva = algunasReservas[0];
                print(reserva.getData());
              } else {
                print('Seleccione una fecha y un lote');
              }
            },
            child: const Text('Reservar'))
      ],
    );
  }
}
