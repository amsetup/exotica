class ProdutoModel {
  final String? proID;
  final String? proModelo;
  final String? proTamanho;
  final String? proCor;
  final String? proPreco;
  final String? gruID;
  final String? gruNome;
  final String? proEstALV;
  final String? proEstBVP;
  final String? proEstPDM;
  final String? proEstSER;
  final String? proEstBVP2;
  final String? proEstPositivo;

  ProdutoModel({
    this.proID,
    this.proModelo,
    this.proTamanho,
    this.proCor,
    this.proPreco,
    this.gruID,
    this.gruNome,
    this.proEstALV,
    this.proEstBVP,
    this.proEstPDM,
    this.proEstSER,
    this.proEstBVP2,
    this.proEstPositivo,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      proID: map['proID'],
      proModelo: map['proModelo'],
      proTamanho: map['proTamanho'],
      proCor: map['proCor'],
      proPreco: map['proPreco'],
      gruID: map['gruID'],
      gruNome: map['gruNome'],
      proEstALV: map['proEstALV'],
      proEstBVP: map['proEstBVP'],
      proEstPDM: map['proEstPDM'],
      proEstSER: map['proEstSER'],
      proEstBVP2: map['proEstBVP2'],
      proEstPositivo: map['proEstPositivo'],
    );
  }
}