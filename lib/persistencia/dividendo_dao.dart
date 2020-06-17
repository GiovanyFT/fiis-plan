
import 'package:fundosimobiliarios/dominio/dividendo.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/persistencia/base_dao.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';

class DividendoDAO extends BaseDAO<Dividendo> {

  @override
  // TODO: implement tableName
  String get nomeTabela => "DIVIDENDO";


  @override
  Dividendo fromMap(Map<String, dynamic> map) {
    // TODO: implement fromJson
    return Dividendo.fromMap(map);
  }

  Future<List<Dividendo>> obterLista(Patrimonio patrimonio) async{
    List<Dividendo> dividendos = await this.obterListaBase(
        nomes_filtros : ["id_patrimonio"],
        valores : [patrimonio.id]);
    for(Dividendo dividendo in dividendos){
      dividendo.patrimonio = patrimonio;
    }
    return dividendos;
  }

  Future<int> excluir(Dividendo dividendo) async {
    return this.excluirBase(
      nomes_filtros: ["id"],
      valores: [dividendo.id],
    );
  }

  Future<int> inserir(Dividendo dividendo) async{
    return this.inserirBase(
        colunas : ["data", "valor", "id_patrimonio"],
        valores: [formatarDateTime(dividendo.data), dividendo.valor, dividendo.patrimonio.id]);
  }
}