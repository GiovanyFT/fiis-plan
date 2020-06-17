import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_grafico_patrimonios.dart';
import 'package:fundosimobiliarios/util/widgets/grafico_pizza.dart';
// Orientação da tela
import 'package:flutter/services.Dart';


class TelaGraficoPatrimonios extends StatefulWidget {
  List<Patrimonio> patrimonios;


  TelaGraficoPatrimonios(this.patrimonios);

  @override
  _TelaGraficoPatrimoniosState createState() => _TelaGraficoPatrimoniosState();
}

class _TelaGraficoPatrimoniosState extends State<TelaGraficoPatrimonios> {
  ControleTelaGraficoPatrimonios _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Bloqueando a orientação da tela para Retrato
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controle = ControleTelaGraficoPatrimonios(widget.patrimonios , "Gráfico de Fundos");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // Desbloqueando a orientação da tela
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráficos"),
      ),
      body: _body(),
    );
  }

  _body() {
    return GraficoPizza(_controle.labels, _controle.valores, _controle.titulo, 4);
  }
}
