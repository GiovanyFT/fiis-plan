
import 'package:flutter/cupertino.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/persistencia/db_helper.dart';
import 'package:fundosimobiliarios/telas/tela_administracao_usuario.dart';
import 'package:fundosimobiliarios/telas/tela_login.dart';
import 'package:fundosimobiliarios/telas/tela_principal.dart';
import 'package:fundosimobiliarios/util/nav.dart';

class ControleTelaAbertura{
  void inicializarAplicacao(BuildContext context) {

    // Inicializando o banco
    Future futureA = DatabaseHelper.getInstance().db;

    // Dando um tempo para exibição da tela de abertura
    Future futureB = Future.delayed(Duration(seconds: 3));

    // Obtendo o usuário logado (se houver)
    Future<Usuario>  futureC = Usuario.obter();

    // Agurandando as 3 operações terminarem
    // Quando terminarem a aplicação ou vai para a tela de login
    // ou para a tela principal
    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario usuario = values[2];

      if(usuario != null){
        if (usuario.tipo == TipoUsuario.padrao) {
          push(context, TelaPrincipal(usuario), replace: true);
        } else {
          push(context, TelaAdministracaoUsuario(), replace: true);
        }
      } else {
        push(context, TelaLogin(), replace: true);
      }
    });
  }
}
