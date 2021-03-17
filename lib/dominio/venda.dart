
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/transacao.dart';

class Venda extends Transacao{
  double valor_medio_compra;

  Venda({DateTime data_transacao, double valor_cota, int quantidade, double taxa, Patrimonio patrimonio})
      : super(data_transacao, valor_cota, quantidade, taxa, patrimonio){
    this.valor_medio_compra = patrimonio.valor_medio;
  }

  Venda.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    this.valor_medio_compra = map["valor_medio_compra"];
  }

}