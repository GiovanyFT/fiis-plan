import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/telas/tela_ajuda.dart';
import 'package:fundosimobiliarios/telas/tela_login.dart';
import 'package:fundosimobiliarios/database_storage.dart';
import 'package:fundosimobiliarios/util/gerenciadora_arquivo.dart';
import 'package:fundosimobiliarios/util/nav.dart';

class MenuLateralAdmin extends StatelessWidget {
  Usuario usuario;

  UserAccountsDrawerHeader _header(ImageProvider imageProvider) {
    return UserAccountsDrawerHeader(
      accountName: Text(usuario.nome),
      accountEmail: Text(usuario.login),
      currentAccountPicture: CircleAvatar(
        backgroundImage: imageProvider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.obter();
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: Platform.isAndroid
              ? <Widget>[
                  _cabecalho(future),
                  _ajuda(context),
                  _backup(context),
                  _restore(context),
                  _sair(context)
                ]
              : <Widget>[
                  _cabecalho(future),
                  _ajuda(context),
                  _sair(context),
                ],
        ),
      ),
    );
  }

  ListTile _sair(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text("Sair"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Fechando o menu lateral
        pop(context);

        // Sobrescrevendo a tela de Login
        push(context, TelaLogin(), replace: true);

        // Retirando o usuário das Shared Preferences
        Usuario.limpar();
      },
    );
  }

  ListTile _restore(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.restore),
      title: Text("Restore"),
      subtitle: Text("buscando o banco de dados na nuvem"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () async {
        // Fechando o menu lateral
        pop(context);

        // Salvando o banco de dados na nuvem
        DataBaseStorage.buscarBDDoStorage(usuario.login);

        // Sobrescrevendo a tela de Login
        push(context, TelaLogin(), replace: true);

        // Retirando o usuário das Shared Preferences
        Usuario.limpar();
      },
    );
  }

  ListTile _backup(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.backup),
      title: Text("Backup"),
      subtitle: Text("salvando o banco de dados na nuvem"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () async {
        // Fechando o menu lateral
        pop(context);

        // Salvando o banco de dados na nuvem
        DataBaseStorage.enviarBDParaStorage(usuario.login);
      },
    );
  }

  ListTile _ajuda(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.help),
      title: Text("Ajuda"),
      subtitle: Text("como usar"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Fechando o menu lateral
        pop(context);

        push(context, TelaAjuda());
      },
    );
  }

  FutureBuilder<Usuario> _cabecalho(Future<Usuario> future) {
    return FutureBuilder<Usuario>(
      future: future,
      builder: (context, snapshot) {
        usuario = snapshot.data;
        if (usuario == null) {
          return Container();
        } else if (usuario.urlFoto != null) {
          Future<File> future_arquivo =
              GerenciadoraArquivo.obterImagem(usuario.urlFoto);
          return FutureBuilder<File>(
              future: future_arquivo,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                File imagem = snapshot.data;
                return _header(FileImage(imagem));
              });
        } else {
          return _header(AssetImage("assets/icon/icone_aplicacao.png"));
        }
      },
    );
  }
}
