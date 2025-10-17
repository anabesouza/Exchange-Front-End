import 'package:flutter/material.dart';
import '../services/instituicao_service.dart';

class TelaInstituicoes extends StatefulWidget {
  const TelaInstituicoes({Key? key}) : super(key: key);

  @override
  State<TelaInstituicoes> createState() => _TelaInstituicoesState();
}

class _TelaInstituicoesState extends State<TelaInstituicoes> {
  final service = InstituicaoService();
  List<dynamic> instituicoes = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarInstituicoes();
  }

  Future<void> carregarInstituicoes() async {
    final data = await service.listarInstituicoes();
    setState(() {
      instituicoes = data ?? []; // evita null
      carregando = false;
    });
  }

  void abrirForm({Map<String, dynamic>? instituicao}) {
    final nomeCtrl = TextEditingController(text: instituicao?["nome"] ?? "");
    final paisCtrl = TextEditingController(text: instituicao?["pais"] ?? "");
    final cidadeCtrl = TextEditingController(text: instituicao?["cidade"] ?? "");

    if (!mounted) return; // evita erro se o contexto for destruído
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(instituicao == null ? "Nova Instituição" : "Editar Instituição"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeCtrl, decoration: const InputDecoration(labelText: "Nome")),
            TextField(controller: paisCtrl, decoration: const InputDecoration(labelText: "País")),
            TextField(controller: cidadeCtrl, decoration: const InputDecoration(labelText: "Cidade")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              if (instituicao == null) {
                await service.criarInstituicao(nomeCtrl.text, paisCtrl.text, cidadeCtrl.text);
              } else {
                await service.atualizarInstituicao(
                  instituicao["id"] ?? 0,
                  nomeCtrl.text,
                  paisCtrl.text,
                  cidadeCtrl.text,
                );
              }
              if (mounted) Navigator.pop(context);
              carregarInstituicoes();
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  Future<void> deletarInstituicao(int id) async {
    await service.deletarInstituicao(id);
    carregarInstituicoes();
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return Scaffold(
        appBar: AppBar(title: const Text("Instituições")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Instituições")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirForm(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: instituicoes.length,
        itemBuilder: (context, index) {
          final inst = instituicoes[index];
          return ListTile(
            title: Text(inst["nome"] ?? "Sem nome"),
            subtitle: Text("${inst["cidade"] ?? "-"}, ${inst["pais"] ?? "-"}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => abrirForm(instituicao: inst),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    final id = inst["id"];
                    if (id != null) deletarInstituicao(id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
