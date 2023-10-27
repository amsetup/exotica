// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, avoid_print, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:exotica_app/services/produto_service.dart';
import 'package:exotica_app/models/produto_model.dart';
import 'package:flutter/services.dart';

import '../utils/app_theme.dart';
import 'grupo_filter_list.dart';

class ProdutoFiltroScreen extends StatefulWidget {
  final Function(List<ProdutoModel>) onFilterApplied;

  ProdutoFiltroScreen({Key? key, required this.onFilterApplied}) : super(key: key);

  @override
  _ProdutoFiltroScreenState createState() => _ProdutoFiltroScreenState();
}

class _ProdutoFiltroScreenState extends State<ProdutoFiltroScreen> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController corController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  List<GrupoFilterListData> grupoFilterListData = GrupoFilterListData.gruposList;
  bool hasError = false;
  bool isLoading = false;

  void applyFilter() async {
    setState(() {
      hasError = false;
      isLoading = true;
    });

    final service = ProdutoService();
    const url = 'getProdutos.php';
    final params = {
      "gruID": getSelectedGruID().join(','),
      "proID": codigoController.text,
      "proModelo": modeloController.text,
      "proCor": corController.text,
      "proMarca": marcaController.text,
    };

    try {
      final listaProdutos = await service.fetchProdutos(url, params);
      widget.onFilterApplied(listaProdutos);
      Navigator.pop(context);
      print('Produtos: $listaProdutos');
    } catch (e) {
      setState(() {
        hasError = true;
      });

      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto não encontrado, tente novamente!'),
            backgroundColor: Colors.red,
          ),
        );
      });

      print('Erro ao buscar produtos: $url $params. Erro: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> getSelectedGruID() {
    final List<String> selectedGruIDs = [];

    for (int i = 0; i < grupoFilterListData.length; i++) {
      final GrupoFilterListData grupo = grupoFilterListData[i];
      if (grupo.isSelected) {
        selectedGruIDs.add(grupo.id);
      }
    }

    if (selectedGruIDs.isEmpty) {
      selectedGruIDs.add("0"); // Adicione um valor padrão se nenhum estiver selecionado
    }

    return selectedGruIDs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            buildBody(),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ]
        )          
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        getAppBarUI(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                allFilters(),
                allGrupos(),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.darkText,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Material(
              color: AppTheme.dark_grey,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                highlightColor: AppTheme.grey,
                onTap: () {
                  applyFilter(); // Corrigido para chamar a função applyFilter
                },
                child: Center(
                  child: Text(
                    'Pesquisar',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget allGrupos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 0, bottom: 8),
          child: Text(
            'Grupo',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Column(
            children: getGrupos(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getGrupos() {
    final List<Widget> switches = <Widget>[];

    for (int i = 0; i < grupoFilterListData.length; i++) {
      final GrupoFilterListData grupo = grupoFilterListData[i];
      switches.add(
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                grupo.grupo,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            CupertinoSwitch(
              activeColor: grupo.isSelected ? AppTheme.darkText : Colors.grey.withOpacity(0.6),
              onChanged: (bool value) {
                setState(() {
                  grupo.isSelected = value;
                });
              },
              value: grupo.isSelected,
            ),
          ],
        ),
      );

      if (i != grupoFilterListData.length - 1) {
        switches.add(const Divider(height: 1));
      }
    }

    return switches;
  }

  Widget allFilters() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: codigoController,
                    inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    keyboardType: TextInputType.number,                    
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Código',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: modeloController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Modelo',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: corController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cor',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: marcaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Marca',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Filtros',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: ProdutoFiltroScreen(onFilterApplied: (_) {}),
  ));
}