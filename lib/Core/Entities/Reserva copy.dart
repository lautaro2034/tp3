import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';

class Reserva {
  int fecha;
  int lote;

  Reserva({required this.fecha, required this.lote});

  String getData() {
    return 'Dia reservado: $fecha, numero de lote $lote';
  }
}
