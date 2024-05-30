import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehiculo {
  String? modelo;
  String? marca;
  String? patente;
  String? idDuenio;

  Vehiculo(
      {required this.patente,
      required this.marca,
      required this.modelo,
      required this.idDuenio});

  Map<String, dynamic> toFireStore() {
    return {
      if (modelo != null) "modelo": modelo,
      if (marca != null) "marca": marca,
      if (patente != null) "patente": patente,
      if (idDuenio != null) "idDuenio": idDuenio, // Convertir a Map
    };
  }

  factory Vehiculo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Vehiculo(
        modelo: data?['modelo'],
        marca: data?['marca'],
        patente: data?['patente'],
        idDuenio: data?['patente']);
  }
}
