
import 'package:fundosimobiliarios/dominio/fundo_imobiliario.dart';
import 'package:fundosimobiliarios/persistencia/base_dao.dart';

class FundoImobiliarioDAO extends BaseDAO<FundoImobiliario>{
  @override
  // TODO: implement tableName
  String get nomeTabela => "FUNDO_IMOBILIARIO";

  @override
  FundoImobiliario fromMap(Map<String, dynamic > map) {
    // TODO: implement fromJson
    return FundoImobiliario.fromMap(map);
  }

  void atualizar(FundoImobiliario fundo) async{
    this.atualizarBase(
        colunas: ["sigla", "nome", "segmento"],
        nomes_filtros: [ "id" ],
        valores : [fundo.sigla, fundo.nome, fundo.segmento, fundo.id]
    );
  }
}
