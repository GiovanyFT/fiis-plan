import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/dividendo.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_listagem_dividendos.dart';
import 'package:fundosimobiliarios/util/widgets/botao_icone.dart';

class CardDividendo extends StatelessWidget {
  ControleTelaListagemDividendos controle;
  Dividendo dividendo;
  int index;


  CardDividendo(this.dividendo, this.controle, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 120,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  dividendo.obterDataTransacao(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 25),
                child: Text(
                  dividendo.valor.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: BotaoIcone(
                //   texto: "Excluir",
                ao_clicar: () async {
                  controle.removerDividendo(index);
                },
                cor: Colors.red,
                icone: Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
