
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';

class ControleTabDividendos {
  final streamController = StreamController<List<Patrimonio>>();
  List<Patrimonio> patrimonios;

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();

  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString();
  }

  Future<List<Patrimonio>> buscarPatrimonios({String atributo = "Sigla"}) async{
    Usuario usuario = await Usuario.obter();
    patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario);
    streamController.add(patrimonios);
    return patrimonios;
  }

}