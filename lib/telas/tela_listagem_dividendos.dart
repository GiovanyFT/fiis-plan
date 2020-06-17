import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/dividendo.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_listagem_dividendos.dart';
import 'package:fundosimobiliarios/telas/localwidget/card_dividendo.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:fundosimobiliarios/util/widgets/seletor_opcoes.dart';

class TelaListagemDividendos extends StatefulWidget {
  Patrimonio patrimonio;

  TelaListagemDividendos(this.patrimonio);

  @override
  _TelaListagemDividendosState createState() => _TelaListagemDividendosState();
}

class _TelaListagemDividendosState extends State<TelaListagemDividendos> {
  ControleTelaListagemDividendos _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaListagemDividendos(widget.patrimonio);
    _controle.setarAnoAtual();
    _controle.buscarDividendos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controle.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dividendos"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controle.irTelaEdicaoDividendo(context);
        },
      ),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top:  16, left: 16, right: 16),
            child: CampoEdicaoIntMaiorQueZero(
              "Ano:",
              texto_dica: "Digite o ano",
              tamanho_fonte: 20,
              controlador: _controle.controlador_ano,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        Expanded(
          flex: 10,
          child: RefreshIndicator(
            onRefresh: (){
              return _controle.buscarDividendos();
            },
            child: _stream_builder(),
          ),
        ),
      ],
    );
  }

  Container _stream_builder() {
    return Container(
    padding: EdgeInsets.all(16),
    child: StreamBuilder<List<Dividendo>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.dividendos = snapshot.data;
          return _listView();
        }
    ),
  );
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: _controle.dividendos != null ? _controle.dividendos.length : 0,
      itemBuilder: (context, index) {
        Dividendo dividendo = _controle.dividendos[index];
        return CardDividendo(dividendo, _controle, index);
      },
    );
  }
}
