import 'package:flutter/material.dart';

class LoteData {
  final int id;
  bool estaReservado;
  bool estaConfirmado;

  LoteData(this.id, this.estaReservado, {this.estaConfirmado = false});
}

class Lote extends StatelessWidget {
  final LoteData loteData;
  final VoidCallback? onTap;

  const Lote({
    Key? key,
    required this.loteData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorBoton;
    if (loteData.estaConfirmado) {
      colorBoton = Colors.red;
    } else if (loteData.estaReservado) {
      colorBoton = Colors.yellow;
    } else {
      colorBoton = Colors.blue;
    }

    return GestureDetector(
      onTap: loteData.estaConfirmado ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorBoton,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "p${loteData.id}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
