class Instituicao {
  final String id;
  final String nome;
  final String cidade;
  final String pais;
  final String contatoEmail;

  Instituicao({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.pais,
    required this.contatoEmail,
  });

  factory Instituicao.fromJson(Map<String, dynamic> json) {
    return Instituicao(
      id: json['id'],
      nome: json['nome'],
      cidade: json['cidade'] ?? '',
      pais: json['pais'] ?? '',
      contatoEmail: json['contato_email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cidade': cidade,
      'pais': pais,
      'contato_email': contatoEmail,
    };
  }
}
