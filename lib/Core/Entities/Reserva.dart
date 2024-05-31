import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';

class Reserva {


  String fecha;
  int lote;

  Reserva({
   required this.fecha,
   required this.lote
  });

  String getData(){
    return '${fecha}numero de lote $lote';
  }




}