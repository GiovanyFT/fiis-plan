import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_administracao_usuario.dart';
import 'package:fundosimobiliarios/telas/localwidget/card_usuario.dart';
import 'package:fundosimobiliarios/telas/localwidget/menu_lateral_admin.dart';
import 'package:fundosimobiliarios/telas/tela_edicao_usuario.dart';
import 'package:fundosimobiliarios/telas/tela_mapa_usuarios.dart';
import 'package:fundosimobiliarios/util/nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'localwidget/menu_lateral.dart';

class TelaAdministracaoUsuario extends StatefulWidget {


  @override
  _TelaAdministracaoUsuarioState createState() => _TelaAdministracaoUsuarioState();
}

class _TelaAdministracaoUsuarioState extends State<TelaAdministracaoUsuario>{
  ControleTelaAdministracaoUsuario _controle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaAdministracaoUsuario();
    _controle.buscarUsuarios();
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
        title: Text("Administração de Usuários"),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.mapMarked,
            ),
            onPressed: () {
              push(context, TelaMapaUsuarios(_controle.usuarios));
            },
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await _controle.irParaTelaEdicaoUsuario(context, null);
        },
      ),
      drawer: MenuLateralAdmin(),
    );
  }

  _body() {
    return StreamBuilder<List<Usuario>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.usuarios = snapshot.data;
          return _gridView();
        }
    );
  }

  _gridView() {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _controle.usuarios != null ? _controle.usuarios.length : 0,
        itemBuilder: (context, index) {
          Usuario usuario = _controle.usuarios[index];
          return GestureDetector(
            onTap: (){
              _showDialog(index, usuario);
            },
            child: CardUsuario(usuario),
          );
        },
      ),
    );
  }

  void _showDialog(int index, usuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Edição de Usuário"),
          content: new Text(
              "O que você deseja fazer com esse usuário?"),
          actions: <Widget>[
            // define os botões na base do dialogo
            FlatButton(
              child: new Text("Alterar"),
              onPressed: () async {
                pop(context);
                _controle.irParaTelaEdicaoUsuario(context, usuario);
              },
            ),
            FlatButton(
              child: new Text("Excluir"),
              onPressed: () {
                pop(context);
                _controle.removerUsuario(index);
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
