class Usuario {
  final String matricula;
  final String nome;
  final String email;
  final String instituicao;

  Usuario({
    required this.matricula,
    required this.nome,
    required this.email,
    required this.instituicao,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      matricula: json['matricula'],
      nome: json['nome'],
      email: json['email'],
      instituicao: json['instituicao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'nome': nome,
      'email': email,
      'instituicao': instituicao,
    };
  }
}
#teste cometario