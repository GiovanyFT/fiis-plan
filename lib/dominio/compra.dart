
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/transacao.dart';

class Compra extends Transacao{
  Compra({DateTime data_transacao, double valor_cota, int quantidade, double taxa, Patrimonio patrimonio})
      : super(data_transacao, valor_cota, quantidade, taxa, patrimonio);

  Compra.fromMap(Map<String, dynamic> map) : super.fromMap(map);

}