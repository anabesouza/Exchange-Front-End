import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/usuario_provider.dart';
import '../models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsuarioProvider>(context, listen: false).fetchUsuarios();
  }

  final matriculaCtrl = TextEditingController();
  final nomeCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Usuários')),
      body: RefreshIndicator(
        onRefresh: provider.fetchUsuarios,
        child: ListView.builder(
          itemCount: provider.usuarios.length,
          itemBuilder: (ctx, i) {
            final u = provider.usuarios[i];
            return ListTile(
              title: Text(u.nome),
              subtitle: Text('${u.email}\\nInstituição: ${u.instituicao}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => provider.deleteUsuario(u.matricula),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirDialog(context, provider),
        child: Icon(Icons.add),
      ),
    );
  }

  void _abrirDialog(BuildContext context, UsuarioProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Novo Usuário'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: matriculaCtrl, decoration: InputDecoration(labelText: 'Matrícula')),
              TextField(controller: nomeCtrl, decoration: InputDecoration(labelText: 'Nome')),
              TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: instCtrl, decoration: InputDecoration(labelText: 'Instituição')),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Salvar'),
            onPressed: () async {
              if (matriculaCtrl.text.isEmpty || nomeCtrl.text.isEmpty) return;
              await provider.addUsuario(Usuario(
                matricula: matriculaCtrl.text,
                nome: nomeCtrl.text,
                email: emailCtrl.text,
                instituicao: instCtrl.text,
              ));
              matriculaCtrl.clear();
              nomeCtrl.clear();
              emailCtrl.clear();
              instCtrl.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
#teste cometario