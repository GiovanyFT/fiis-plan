
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/dividendo.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/telas/tela_edicao_dividendo.dart';
import 'package:fundosimobiliarios/util/meses_ano.dart';
import 'package:fundosimobiliarios/util/nav.dart';

class ControleTelaListagemDividendos{
  final streamController = StreamController<List<Dividendo>>();
  Patrimonio patrimonio;
  List<Dividendo> dividendos;

  ControleTelaListagemDividendos(this.patrimonio);

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();


  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString(); ;
  }

  Future<List<Dividendo>> buscarDividendos() async{
    dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, controlador_ano.text);
    streamController.add(dividendos);
    return dividendos;
  }


  void irTelaEdicaoDividendo(BuildContext context) async{
    String s = await push(context, TelaEdicaoDividendo(patrimonio));
    if (s == "Salvou") {
      dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, controlador_ano.text);
      streamController.add(dividendos);
    }
  }

  void removerDividendo(int index) {
    Dividendo dividendo = dividendos[index];
    dividendos.removeAt(index);
    FabricaControladora.obterDividendoControl().removerDividendo(dividendo);
    streamController.add(dividendos);
  }


}