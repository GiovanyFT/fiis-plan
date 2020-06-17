import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_dividendos_impostos.dart';
import 'package:fundosimobiliarios/telas/localwidget/tab_dividendos.dart';
import 'package:fundosimobiliarios/telas/localwidget/tab_impostos.dart';

class TelaDividendosImpostos extends StatefulWidget {

  @override
  _TelaDividendosImpostosState createState() => _TelaDividendosImpostosState();
}

class _TelaDividendosImpostosState extends State<TelaDividendosImpostos> {
  ControleTelaDividendosImpostos _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaDividendosImpostos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dividendos e Impostos"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Dividendos",
                icon: Icon(FontAwesomeIcons.handHoldingUsd),
              ),
              Tab(
                text: "Impostos",
                icon: Icon(FontAwesomeIcons.fileInvoiceDollar),
              ),
            ],
          ),
        ),
        body: Builder(builder: (context) {
          return TabBarView(
            children: <Widget>[
              TabDividendos(),
              TabImpostos(),
            ],
          );
        },
        ),
      ),
    );
  }
}