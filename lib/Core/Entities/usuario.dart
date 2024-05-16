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
      if (email != null) "name": email,
      if (contrasenia != null) "state": contrasenia,
      if (nombre != null) "nombre": nombre,
      if (apellido != null) "capital": apellido,
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
}
