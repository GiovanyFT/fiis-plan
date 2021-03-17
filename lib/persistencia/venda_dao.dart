

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


  void inserir(Venda venda) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      Patrimonio patrimonio = venda.patrimonio;
      int id1 = await txn.rawUpdate('UPDATE PATRIMONIO SET '
          ' valor_medio = ?, qt_cotas = ? WHERE id = ?',
          [ patrimonio.valor_medio, patrimonio.qt_cotas, patrimonio.id]);
      print('updated1: $id1');

      int id2 = await txn.rawInsert(
          'INSERT INTO $nomeTabela (data_transacao, valor_cota, quantidade, taxa, id_patrimonio, valor_medio_compra) '
              'VALUES(?, ?, ?, ?, ?, ? )',
          [formatarDateTime(venda.data_transacao), venda.valor_cota, venda.quantidade, venda.taxa,
            venda.patrimonio.id, venda.valor_medio_compra]);
      print('inserted2: $id2');
      print('valor medio compra: ${venda.valor_medio_compra}');
    });
  }
}