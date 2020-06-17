
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_principal.dart';
import 'package:fundosimobiliarios/telas/tela_edicao_venda.dart';
import 'package:fundosimobiliarios/util/nav.dart';

class ControleTelaListagemVendas {
  final streamController = StreamController<List<Venda>>();

  Patrimonio patrimonio;
  ControleTelaPrincipal controleTelaPrincipal;
  List<Venda> vendas;

  ControleTelaListagemVendas(this.patrimonio, this.controleTelaPrincipal);

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();


  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString(); ;
  }

  void setarMudanca(){
    controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
  }

  Future<List<Venda>> buscarVendas() async{
    vendas = await FabricaControladora.obterVendaControl().obterVendas(patrimonio,  controlador_ano.text);
    streamController.add(vendas);
  }

  void irTelaEdicaoVenda(BuildContext context) async{
    String s = await push(context, TelaEdicaoVenda(patrimonio));
    if (s == "Salvou") {
      vendas = await FabricaControladora.obterVendaControl().obterVendas(patrimonio, controlador_ano.text);
      streamController.add(vendas);
      controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
    }
  }

  void removerVenda(int index) {
    Venda venda = vendas.removeAt(index);
    FabricaControladora.obterVendaControl().removerVenda(venda);
    streamController.add(vendas);
    controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
  }
}