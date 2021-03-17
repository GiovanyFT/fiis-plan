

import 'package:fundosimobiliarios/dominio/compra.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/persistencia/compra_dao.dart';
import 'package:fundosimobiliarios/persistencia/venda_dao.dart';

Comparator<Venda> vendaPorData = (v1, v2) => v1.data_transacao.compareTo(v2.data_transacao);

class VendaControl{
  VendaDAO _dao = VendaDAO();

  Future<List<Venda>> obterVendas(Patrimonio patrimonio, String texto_ano) async {
    List<Venda> vendas = await _dao.obterLista(patrimonio);
    List<Venda> vendas_ano = <Venda>[];
    for(Venda venda in vendas){
      int ano = venda.data_transacao.year;
      if(ano == int.parse(texto_ano)){
        vendas_ano.add(venda);
      }
    }
    vendas_ano.sort(vendaPorData);
    return vendas_ano;
  }


  void inserirVenda(Venda venda){
    Patrimonio patrimonio = venda.patrimonio;

    int nova_quantidade_cotas = patrimonio.qt_cotas - venda.quantidade;
    if (nova_quantidade_cotas == 0){
      patrimonio.valor_medio = 0.0;
      patrimonio.qt_cotas = 0;
    } else {
      patrimonio.qt_cotas = nova_quantidade_cotas;
    }
    _dao.inserir(venda);
  }

  void removerVenda(Venda venda) async {
    Patrimonio patrimonio = venda.patrimonio;

    int nova_quantidade_cotas = patrimonio.qt_cotas + venda.quantidade;
    patrimonio.valor_medio = await _recalcularValorMedio(patrimonio);

    patrimonio.qt_cotas = nova_quantidade_cotas;
    _dao.excluir(venda);
  }

  Future<double> _recalcularValorMedio(Patrimonio patrimonio) async {
    CompraDAO comprasDAO = CompraDAO();
    List<Compra> compras = await comprasDAO.obterLista(patrimonio);
    double valor_medio, valor_cotas = 0.0;
    int qt_cotas = 0;
    for(Compra compra in compras){
      valor_cotas += (compra.valor_cota * compra.quantidade) + compra.taxa;
      qt_cotas += compra.quantidade;
    }
    if (qt_cotas > 0)
      valor_medio = valor_cotas/qt_cotas;
    else
      valor_medio = 0;
    return valor_medio;
  }

  Future<int> obterQuantidadeVendas() async{
    return await _dao.obterQuantidadeBase();
  }
}