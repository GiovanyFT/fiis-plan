import 'package:fundosimobiliarios/dominio/objeto.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';

class Dividendo extends Objeto{
  DateTime data;
  double valor;
  Patrimonio patrimonio;


  Dividendo({this.data, this.valor, this.patrimonio});

  Dividendo.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    data = gerarDateTime(map["data"]);
    valor = map["valor"];
  }

  String obterDataTransacao(){
    return formatarDateTime(data);
  }

}