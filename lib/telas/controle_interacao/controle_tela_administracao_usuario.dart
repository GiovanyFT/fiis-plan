
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/telas/tela_edicao_usuario.dart';
import 'package:fundosimobiliarios/util/gerenciadora_arquivo.dart';
import 'package:fundosimobiliarios/util/nav.dart';
import 'package:fundosimobiliarios/util/toast.dart';

class ControleTelaAdministracaoUsuario{
  final streamController = StreamController<List<Usuario>>();

  List<Usuario> usuarios;

  Future<List<Usuario>> buscarUsuarios() async{
    usuarios = await FabricaControladora.obterUsuarioControl().obterUsuarios();
    streamController.add(usuarios);
    return usuarios;
  }

  void removerUsuario(int index) async{
    int qt_patrimonios = await FabricaControladora.obterPatrimonioControl().obterQuantidadePatrimonios(usuarios[index]);
    if (qt_patrimonios > 0){
      MensagemAlerta("Não é possível excluir o usuário (existem patrimônios vinculadoss a esse usuário) ");
    } else {
      Usuario usuario_logado = await Usuario.obter();
      Usuario usuario_a_ser_excluido = usuarios[index];
      if(usuario_logado.id == usuario_a_ser_excluido.id){
        MensagemAlerta("Não é possível excluir o usuário atualmente logado ");
      } else {
        Usuario usuario = usuarios.removeAt(index);
        if (usuario.urlFoto != null){
          GerenciadoraArquivo.excluirArquivo(usuario.urlFoto);
        }
        FabricaControladora.obterUsuarioControl().removerUsuario(usuario);
        streamController.add(usuarios);
      }
    }
  }

  void irParaTelaEdicaoUsuario(BuildContext context, Usuario usuario) async{
    String s = await push(context, TelaEdicaoUsuario(usuario));
    if (s == "Salvou"){
      buscarUsuarios();
    }
  }
}