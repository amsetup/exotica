import 'package:flutter/material.dart';
import 'package:exotica_app/pages/produtos/produtos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, AnimationController? animationController});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  
  AnimationController? animationController;  
  Widget tabBody = Container(
    
  );

  @override
  void initState() {    
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = ProdutosScreen(animationController: animationController);
    //tabBody = GruposScreen(animationController: animationController);
    super.initState();
  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

}
