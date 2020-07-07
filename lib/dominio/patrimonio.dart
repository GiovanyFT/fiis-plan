
import 'package:fundosimobiliarios/dominio/fundo_imobiliario.dart';
import 'package:fundosimobiliarios/dominio/objeto.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';

class Patrimonio extends Objeto{
  FundoImobiliario fundo;
  Usuario usuario;
  double valor_medio;
  int qt_cotas;

  Patrimonio({this.fundo, this.usuario, this.valor_medio,
      this.qt_cotas});

  @override
  String toString() {
    return 'Patrimonio{id: $id, fundo: $fundo, usuario: $usuario, '
        'valor_medio: $valor_medio, qt_cotas: $qt_cotas}';
  }

  Patrimonio.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    valor_medio = map["valor_medio"];
    qt_cotas = map["qt_cotas"];
    fundo = FundoImobiliario.fromMap(map);
  }
}
