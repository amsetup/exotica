class GrupoFilterListData {
  GrupoFilterListData({
    this.id = '',
    this.grupo = '',
    this.icon = '',
    this.isSelected = false,
  });

  String id;
  String grupo;
  String icon;
  bool isSelected;

  static List<GrupoFilterListData> gruposList = [
    /* GrupoFilterListData(
      id: '0', 
      grupo: 'TODOS', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ), */
    GrupoFilterListData(
      id: '1', 
      grupo: 'LENTES', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
    GrupoFilterListData(
      id: '2', 
      grupo: 'ARMAÇÕES', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
    GrupoFilterListData(
      id: '3', 
      grupo: 'ÓCULOS DE SOL', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
    GrupoFilterListData(
      id: '5', 
      grupo: 'LENTES DE CONTATO', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
    GrupoFilterListData(
      id: '6', 
      grupo: 'RELOGIOS', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
    GrupoFilterListData(
      id: '7', 
      grupo: 'FOLHEADOS', 
      icon: 'assets/app/area1.png',
      isSelected: false,
    ),
  ];
}