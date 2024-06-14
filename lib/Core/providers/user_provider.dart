import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usuarioProvider = StateNotifierProvider<UsuarioNotifier, Usuario>((ref) {
  return UsuarioNotifier();
});

class UsuarioNotifier extends StateNotifier<Usuario> {
  UsuarioNotifier()
      : super(Usuario(
            id: '',
            email: '',
            contrasenia: '',
            nombre: '',
            apellido: '',
            esAdmin: false));

  void setUsuario(String id, String nombre, String apellido, String email,
      String contrasenia, bool esAdmin) {
    state = state.copywith(
        id: id,
        nombre: nombre,
        apellido: apellido,
        email: email,
        contrasenia: contrasenia,
        esAdmin: esAdmin);
  }
}
