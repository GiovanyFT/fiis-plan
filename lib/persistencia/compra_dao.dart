
import 'package:fundosimobiliarios/dominio/compra.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/persistencia/base_dao.dart';
import 'package:fundosimobiliarios/persistencia/transacao_dao.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';
import 'package:sqflite/sqflite.dart';

class CompraDAO extends TransacaoDAO<Compra>{

  @override
  // TODO: implement tableName
  String get nomeTabela => "COMPRA";

  @override
  Compra fromMap(Map<String, dynamic> map) {
    // TODO: implement fromJson
    return Compra.fromMap(map);
  }




}