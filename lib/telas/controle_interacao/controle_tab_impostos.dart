
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/imposto.dart';
import 'package:fundosimobiliarios/util/meses_ano.dart';

class ControleTabImpostos {
  final streamController = StreamController<List<Imposto>>();
  List<Imposto> impostos;

  final List<String> meses = MesesAno.meses;
  String mes_selecionado = MesesAno.janeiro;

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();

  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString();
  }

  Future<List<Imposto>> gerarImpostos() async{
    impostos = await FabricaControladora.obterImpostoControl().gerarImpostos(controlador_ano.text, mes_selecionado);
    print("Impostos gerados");
    streamController.add(impostos);
    return impostos;
  }

}