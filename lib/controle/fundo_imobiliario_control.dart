
import 'package:fundosimobiliarios/dominio/fundo_imobiliario.dart';
import 'package:fundosimobiliarios/persistencia/fundo_imobiliario_dao.dart';


class FundoImobiliarioControl {
  FundoImobiliarioDAO _dao = FundoImobiliarioDAO();

  void atualizarFundoImobiliario(FundoImobiliario fundo){
    _dao.atualizar(fundo);
  }

  void inserirFundoImobiliario(FundoImobiliario fundo){

  }
}