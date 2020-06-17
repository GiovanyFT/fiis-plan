
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/transacao.dart';

class Venda extends Transacao{

  Venda({DateTime data_transacao, double valor_cota, int quantidade, double taxa, Patrimonio patrimonio})
      : super(data_transacao, valor_cota, quantidade, taxa, patrimonio);

  Venda.fromMap(Map<String, dynamic> map) : super.fromMap(map);

}