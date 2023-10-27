// products.dart

// ignore_for_file: prefer_const_constructors

import 'package:exotica_app/components/title_view.dart';
import 'package:exotica_app/models/tabIcon_data.dart';
import 'package:exotica_app/widgets/bottom_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:exotica_app/widgets/produto_filtro.dart';
import 'package:exotica_app/utils/app_theme.dart';
import 'package:exotica_app/widgets/menu_main.dart';
import 'package:exotica_app/widgets/produto_card.dart';
import 'package:exotica_app/models/produto_model.dart';
import 'package:exotica_app/services/produto_service.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();

  static const padding = EdgeInsets.symmetric(horizontal: 20);
}

class _ProdutosScreenState extends State<ProdutosScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  List<ProdutoModel> produtos = [];
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );
  
  get animationController => null;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    addAllListData();
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() async {

    listViews.add(
      Text(''),
    );
    
    /* final service = ProdutoService();
    const url = 'getProdutos.php';
    final params = {
      "gruID": "1",
    };

    try {
      final listaProdutos = await service.fetchProdutos(url, params);
      setState(() {
        produtos = listaProdutos;
      });
    } catch (e) {
      print('Erro ao buscar produtos: $url $params. Erro: $e');
    }

    if (produtos.isNotEmpty) {
      for (final produto in produtos) {
        listViews.add(
          ProdutoCardView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
              ),
            ),
            animationController: widget.animationController!,
            produto: produto,
          ),
        );
      }
    } */
  }

  void addListData() async {

    listViews.clear(); 
    
    if (produtos.isNotEmpty) {
      for (final produto in produtos) {
        listViews.add(
          ProdutoCardView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
              ),
            ),
            animationController: widget.animationController!,
            produto: produto,
          ),
        );
      }
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  // Função para atualizar a lista de produtos
  void updateProdutosList(List<ProdutoModel> updatedProdutos) {
    setState(() {
      produtos = updatedProdutos;
      addListData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        /* appBar: AppBar(
          title: Text('Produtos'),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: openFilterScreen,
            ),
          ],
        ), */
        drawer: const MenuMain(),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),           
            bottomBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  void openFilterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProdutoFiltroScreen(
          onFilterApplied: updateProdutosList,
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/app/tab_1s.png',
                              width: 24,
                              height: 24,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Produtos',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                      letterSpacing: 1.2,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout),
                              tooltip: 'Fechar',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            openFilterScreen();
          },
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProdutosScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  //tabBody = TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
  