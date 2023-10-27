class GrupoModel {
  final String id;
  final String grupo;
  final String icon;

  GrupoModel({
    required this.id,
    required this.grupo,
    required this.icon,
  });

  static List<GrupoModel> getGrupos() {
    return [
      GrupoModel(id: '1', grupo: 'LENTES', icon: 'assets/app/area1.png'),
      GrupoModel(id: '2', grupo: 'ARMAÇÕES', icon: 'assets/app/area1.png'),
      GrupoModel(id: '3', grupo: 'ÓCULOS DE SOL', icon: 'assets/app/area1.png'),
      GrupoModel(id: '5', grupo: 'LENTES DE CONTATO', icon: 'assets/app/area1.png'),
      GrupoModel(id: '6', grupo: 'RELOGIOS', icon: 'assets/app/area1.png'),
      GrupoModel(id: '7', grupo: 'FOLHEADOS', icon: 'assets/app/area1.png'),
    ];
  }
  
}
