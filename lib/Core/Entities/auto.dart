import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auto {
  String? modelo;
  String? marca;
  String? patente;
  Usuario? duenio;

  Auto({required patente, required marca, required modelo, required duenio});

  Map<String, dynamic> toFireStore() {
    return {
      if (modelo != null) "modelo": modelo,
      if (marca != null) "marca": marca,
      if (patente != null) "patente": patente,
      if (duenio != null) "duenio": duenio,
    };
  }

  factory Auto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Auto(
        modelo: data?['modelo'],
        marca: data?['marca'],
        patente: data?['patente'],
        duenio: data?['duenio']);
  }
}
