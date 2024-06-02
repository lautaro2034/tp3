

import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservaProvider = StateProvider<List<Reserva>>((ref) {
  return [
    /*Reserva(fecha: "2024-05-31 00:00:00", lote: 1),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 2),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 3),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 4),*/
  ];
});


final indexButton = StateProvider<int>((ref) {
  return 0;
});