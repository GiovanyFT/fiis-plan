

import 'package:fundosimobiliarios/dominio/objeto.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';

abstract class Transacao extends Objeto{
  DateTime data_transacao;
  double valor_cota;
  int quantidade;
  double taxa;
  Patrimonio patrimonio;


  Transacao(this.data_transacao, this.valor_cota, this.quantidade,
      this.taxa, this.patrimonio);

  Transacao.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    data_transacao = gerarDateTime(map["data_transacao"]);
    valor_cota = map["valor_cota"];
    quantidade = map["quantidade"];
    taxa = map["taxa"];
  }


  @override
  String toString() {
    return 'Transacao{id: $id, data_transacao: $data_transacao, valor_cota: $valor_cota, quantidade: $quantidade, taxa: $taxa, patrimonio: $patrimonio}';
  }

  String obterDataTransacao(){
    return formatarDateTime(data_transacao);
  }
}