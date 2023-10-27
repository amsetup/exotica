class UsuarioModel {
  final String? usuNome;
  final String? usuLogin;
  final String? usuEmail;

  UsuarioModel({
    this.usuNome,
    this.usuLogin,
    this.usuEmail
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      usuNome: map['usu_nome'],
      usuLogin: map['usu_login'],
      usuEmail: map['usu_email']
    );
  }
}