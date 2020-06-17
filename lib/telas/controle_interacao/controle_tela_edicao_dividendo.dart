

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/dividendo.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';

class ControleTelaEdicaoDividendo{
  Patrimonio patrimonio;
  Dividendo dividendo = null;

  ControleTelaEdicaoDividendo(this.patrimonio);

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  // Controladores de edição
  final controlador_data = TextEditingController();
  final controlador_valor = TextEditingController();

  // Controladores de foco
  final focus_valor = FocusNode();
  final focus_botao_salvar = FocusNode();

  void inicializar_campos_edicao() {
    controlador_data.text = "";
    controlador_valor.text = "";
  }

  void _inserir_dividendo() {
    dividendo = Dividendo(
        data: gerarDateTime(controlador_data.text),
        valor: double.parse(controlador_valor.text),
        patrimonio: patrimonio);

    FabricaControladora.obterDividendoControl().inserirDividendo(dividendo);
  }

  void salvar_dividendo(BuildContext context) {
    if (formkey.currentState.validate()) {
      _inserir_dividendo();
      Navigator.pop(context, "Salvou");
    }
  }
}