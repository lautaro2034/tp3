import 'package:app_de_estacionamiento/Core/Entities/Vehiculo.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reserva {
  int fecha;
  int lote;
  Vehiculo elvehiculo;

  Reserva({required this.fecha, required this.lote, required this.elvehiculo});

  String getData() {
    return 'Dia reservado: $fecha, numero de lote $lote';
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.fecha.toString() +
        '' +
        this.lote.toString() +
        '' +
        elvehiculo.toString();
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fecha': this.fecha,
      'lote': this.lote,
      'elvehiculo': {
        'modelo': elvehiculo.modelo,
        'marca': elvehiculo.marca,
        'patente': elvehiculo.patente,
        'idDuenio': elvehiculo.idDuenio
      }
    };
  }

  factory Reserva.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Reserva(
        fecha: snapshot.data()?['fecha'],
        lote: snapshot.data()?['lote'],
        elvehiculo: snapshot.data()?['vehiculo']);
  }
}
