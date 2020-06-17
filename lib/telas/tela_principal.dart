import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_principal.dart';
import 'package:fundosimobiliarios/telas/localwidget/card_patrimonio.dart';
import 'package:fundosimobiliarios/telas/localwidget/menu_lateral.dart';
import 'package:fundosimobiliarios/telas/tela_edicao_fundo_imobiliario.dart';
import 'package:fundosimobiliarios/telas/tela_webview_fundos.dart';
import 'package:fundosimobiliarios/util/firebase_cloud_messaging.dart';
import 'package:fundosimobiliarios/util/nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundosimobiliarios/util/widgets/seletor_opcoes.dart';


class TelaPrincipal extends StatefulWidget {
  Usuario usuario;

  TelaPrincipal(this.usuario);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  ControleTelaPrincipal _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaPrincipal(widget.usuario);
    _controle.buscarPatrimonios();

    TratadorNotificacao.initFcm(context);

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
        title: Text("Patrimônio"),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chartPie,
            ),
            onPressed: () {
              _controle.irParaTelaGraficoPatrimonios(context);
            },
          ),
          IconButton(
            icon: FaIcon(
              //,
              FontAwesomeIcons.searchDollar,
            ),
            onPressed: () {
              _controle.irParaTelaDividendosImpostos(context);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String valor) {
              push(context, TelaWebViewFundos(valor));
            },
            icon: FaIcon(FontAwesomeIcons.chrome),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "https://www.clubefii.com.br/fundo_imobiliario_lista",
                  child: FlatButton(
                    child: Text(
                      "Clube FII",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "https://fiis.com.br/lista-de-fundos-imobiliarios/",
                  child: FlatButton(
                    child: Text(
                      "FIIs.com.br",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "https://www.fundsexplorer.com.br/funds",
                  child: FlatButton(
                    child: Text(
                      "Fundsexplorer",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await _controle.irParaTelaEdicao(
              context, TelaEdicaoFundoImobiliario(null));
        },
      ),
      drawer: MenuLateral(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: SeletorOpcoes(
                    tamanho_fonte: 20,
                    opcoes: ControleTelaPrincipal.campos_ordenacao,
                    valor_selecionado: _controle.campo_selecionado,
                    ao_mudar_opcao: (String novoItemSelecionado) {
                      _controle.campo_selecionado = novoItemSelecionado;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          flex: 8,
          child: RefreshIndicator(
            onRefresh: () {
              return _controle.buscarPatrimonios();
            },
            child: StreamBuilder<List<Patrimonio>>(
                stream: _controle.streamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _controle.patrimonios = snapshot.data;
                  return _listView();
                }),
          ),
        ),
      ],
    );
  }

  Container _listView() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
            _controle.patrimonios != null ? _controle.patrimonios.length : 0,
        itemBuilder: (context, index) {
          Patrimonio patrimonio = _controle.patrimonios[index];
          return GestureDetector(
            onTap: () {
              _showDialog(index, patrimonio);
            },
            child: CardPatrimonio(patrimonio, _controle),
          );
        },
      ),
    );
  }

  void _showDialog(int index, Patrimonio patrimonio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Edição de Fundo Imobiliário"),
          content:
              new Text("O que você deseja fazer com esse fundo imobiliário?"),
          actions: <Widget>[
            // define os botões na base do dialogo
            FlatButton(
              child: new Text("Alterar"),
              onPressed: () async {
                pop(context);
                _controle.irParaTelaEdicao(
                    context, TelaEdicaoFundoImobiliario(patrimonio.fundo));
              },
            ),
            FlatButton(
              child: new Text("Excluir"),
              onPressed: () {
                pop(context);
                setState(() {
                  _controle.removerPatrimonio(index);
                });
              },
            ),
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
