import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_listagem_vendas.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_principal.dart';
import 'package:fundosimobiliarios/telas/localwidget/card_venda.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_int_maior_que_zero.dart';



class TelaListagemVendas extends StatefulWidget {
  Patrimonio patrimonio;
  ControleTelaPrincipal controleTelaPrincipal;

  TelaListagemVendas(this.patrimonio, this.controleTelaPrincipal);

  @override
  _TelaListagemVendasState createState() => _TelaListagemVendasState();
}

class _TelaListagemVendasState extends State<TelaListagemVendas> {
  ControleTelaListagemVendas _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaListagemVendas(
        widget.patrimonio, widget.controleTelaPrincipal);
    _controle.setarAnoAtual();
    _controle.buscarVendas();
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
        title: Text("Vendas"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controle.irTelaEdicaoVenda(context);
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
              return _controle.buscarVendas();
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
    child: StreamBuilder<List<Venda>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.vendas = snapshot.data;
          return _listView();
        }
    ),
  );
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: _controle.vendas != null ? _controle.vendas.length : 0,
      itemBuilder: (context, index) {
        Venda venda = _controle.vendas[index];
        return CardVenda(venda, _controle, index);
      },
    );
  }
}

