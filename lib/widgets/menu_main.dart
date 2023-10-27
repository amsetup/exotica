import 'package:exotica_app/routes/routes.dart';
import 'package:exotica_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MenuMain extends StatelessWidget {
  const MenuMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [     

            Container(
              color: AppTheme.deactivatedText,
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.only(top: 30.0, bottom: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  Divider(),
                  Text(
                    "Anderson",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  Text(
                    "amsetup.ti@gmail.com",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ), 
            
            Expanded(
              child: ListView(                
                padding: const EdgeInsets.only(top: 15, left: 15),
                children: [                  
                    ListTile(
                      title: const Text('Produtos'),
                      leading: SizedBox(
                        height: 30,
                        child: Image.asset('assets/app/tab_1s.png'),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.produtos);
                      },
                    ),
                    ListTile(
                      title: const Text('Clientes'),  
                      leading: SizedBox(
                        height: 30, 
                        child: Image.asset('assets/app/tab_4s.png'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('O.S.'),
                      leading: SizedBox(
                        height: 30, 
                        child: Image.asset('assets/app/tab_3s.png'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),  
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      endIndent: 15,
                    ),                
                    ListTile(
                      title: const Text('Sair'),
                      leading: SizedBox(
                        height: 30, 
                        child: Image.asset('assets/app/sair_s.png'),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.login);
                      },
                    ),
                ]
              ),
            ),

          ],
        ),
      );
  }
}
