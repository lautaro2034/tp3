import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String id;
  String email;
  String contrasenia;
  String nombre;
  String apellido;

  Usuario(
      {required this.id,
      required this.email,
      required this.contrasenia,
      required this.nombre,
      required this.apellido});

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (email != null) "email": email,
      if (contrasenia != null) "contrasenia": contrasenia,
      if (nombre != null) "nombre": nombre,
      if (apellido != null) "apellido": apellido,
    };
  }

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      id: data?['id'],
      email: data?['email'],
      contrasenia: data?['contrasenia'],
      nombre: data?['nombre'],
      apellido: data?['apellido'],
    );
  }

  //Sirve para editar datos
  Usuario copywith(
      {String? id,
      String? email,
      String? contrasenia,
      String? nombre,
      String? apellido,
      bool? esAdmin}) {
    return Usuario(
        id: id ?? this.id,
        email: email ?? this.email,
        contrasenia: contrasenia ?? this.contrasenia,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido);
  }

  String get recuperarId {
    return id;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "el id: ${id}, en nombre: ${nombre},  el apellido ${apellido} el correo  ${email}, contrasenia: ${contrasenia} ";
  }
}
