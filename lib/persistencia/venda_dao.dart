

import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/persistencia/base_dao.dart';
import 'package:fundosimobiliarios/persistencia/db_helper.dart';
import 'package:fundosimobiliarios/persistencia/transacao_dao.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';
import 'package:sqflite/sqflite.dart';

class VendaDAO extends TransacaoDAO<Venda>{
  @override
  // TODO: implement tableName
  String get nomeTabela => "VENDA";

  @override
  Venda fromMap(Map<String, dynamic> map) {
  // TODO: implement fromJson
  return Venda.fromMap(map);
  }
}