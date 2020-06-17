import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_edicao_venda.dart';
import 'package:fundosimobiliarios/util/widgets/botao.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_data.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_double_maior_que_zero.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_int_maior_que_zero.dart';

class TelaEdicaoVenda extends StatefulWidget {
  Patrimonio patrimonio;

  TelaEdicaoVenda(this.patrimonio);

  @override
  _TelaEdicaoVendaState createState() => _TelaEdicaoVendaState();
}

class _TelaEdicaoVendaState extends State<TelaEdicaoVenda> {
  ControleTelaEdicaoVenda _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaEdicaoVenda(widget.patrimonio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inclusão de Venda de FII"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _controle.formkey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CampoEdicaoData(
                "Data de Venda:",
                controlador: _controle.controlador_data_compra,
                recebedor_foco: _controle.focus_valor_cota,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicaoDoubleMaiorQueZero(
                "Valor da Cota:",
                controlador: _controle.controlador_valor_cota,
                marcador_foco: _controle.focus_valor_cota,
                recebedor_foco: _controle.focus_quantidade_cotas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicaoIntMaiorQueZero(
                "Quantidade de cotas:",
                controlador: _controle.controlador_quantidade_cotas,
                marcador_foco: _controle.focus_quantidade_cotas,
                recebedor_foco: _controle.focus_taxas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicao(
                "Taxas:",
                controlador: _controle.controlador_taxas,
                marcador_foco: _controle.focus_taxas,
                recebedor_foco: _controle.focus_botao_salvar,
                validador: _controle.validarTaxas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Botao(
                      texto: "Salvar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.salvar_venda(context);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Botao(
                      texto: "Cancelar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.inicializar_campos_edicao();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
