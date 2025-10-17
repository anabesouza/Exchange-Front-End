import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'pages/homePage.dart';
import 'pages/telaInstituicoes.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchange',
      theme: ThemeData.dark(),
      home: loginMaster(),
    );
  }
}


class loginMaster extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  loginMaster({super.key});

  get style => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Faça seu login.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: loginController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Login',
                    labelStyle: TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);

                    final name = loginController.text.trim();
                    final password = senhaController.text.trim();

                    await userProvider.loginMaster(name, password);

                    final message = userProvider.userMessage;

                    if (message != null && message.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      });
                    }

                    if (message == "Login realizado com sucesso!") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => telaInstituicoes()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Acessar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ), ]
                    ),
                  ),
                ),
            ),
          );
  }
}
