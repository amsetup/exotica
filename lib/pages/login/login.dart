// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:exotica_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:exotica_app/models/usuario_model.dart';
import 'package:exotica_app/services/usuario_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuLoginController = TextEditingController();
  final TextEditingController usuSenhaController = TextEditingController();
  bool isLoading = false;

  Future<void> authenticateUser() async {
    final usuarioService = UsuarioService();
    final userCredentials = {
      'usuLogin': usuLoginController.text,
      'usuSenha': usuSenhaController.text,
    };

    try {
      setState(() {
        isLoading = true;
      });

      final List<UsuarioModel> users = await usuarioService.fetchUsuario('getLogin.php', userCredentials);

      if (users.isNotEmpty) {
        Navigator.pushNamed(context, '/home');
      } else {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuário não encontrado, verifique os dados informados e tente novamente!'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } catch (e) {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuário não encontrado, verifique os dados informados e tente novamente!'),
              backgroundColor: Colors.red,
            ),
          );
        });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidCredentials() {
    return usuLoginController.text.isNotEmpty && usuSenhaController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/amsetup.png"),
                  height: 250,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: usuLoginController,
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: usuSenhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (isValidCredentials()) {
                      authenticateUser();
                    } else {
                      Future.delayed(Duration.zero, () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Usuário não encontrado, verifique os dados informados e tente novamente!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.dark_grey),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Login'),
                      //SizedBox(width: 0, height: 115,),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
