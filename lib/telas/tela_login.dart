

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_login.dart';
import 'package:fundosimobiliarios/util/widgets/botao.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao.dart';
import 'package:fundosimobiliarios/util/widgets/campo_edicao_data.dart';


class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  ControleTelaLogin _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controle = ControleTelaLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _controle.formkey,
      child: Container(
        // Margem padrão no Material Design
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            CampoEdicao(
              "Login",
              texto_dica: "Digite o Login",
              controlador: _controle.controlador_login,
              teclado: TextInputType.emailAddress,
              recebedor_foco: _controle.focus_senha,
            ),
            SizedBox(
              height: 10,
            ),
            CampoEdicao(
              "Senha",
              texto_dica: "Digite a senha",
              passaword: true,
              controlador: _controle.controlador_senha,
              marcador_foco: _controle.focus_senha,
              recebedor_foco: _controle.focus_botao,
            ),
            SizedBox(
              height: 20,
            ),
            Botao(
              texto: "Login",
              cor: Colors.green,
              ao_clicar: (){
                _controle.logar(context);
              },
              marcador_foco: _controle.focus_botao,
            )
          ],
        ),
      ),
    );
  }
}
