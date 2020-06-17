
import 'package:fundosimobiliarios/controle/compra_control.dart';
import 'package:fundosimobiliarios/controle/dividendo_control.dart';
import 'package:fundosimobiliarios/controle/fundo_imobiliario_control.dart';
import 'package:fundosimobiliarios/controle/imposto_control.dart';
import 'package:fundosimobiliarios/controle/patrimonio_control.dart';
import 'package:fundosimobiliarios/controle/usuario_control.dart';
import 'package:fundosimobiliarios/controle/venda_control.dart';
import 'package:fundosimobiliarios/persistencia/fundo_imobiliario_dao.dart';

class FabricaControladora {
  static final UsuarioControl _usuarioControl = UsuarioControl();
  static final PatrimonioControl _patrimonioControl = PatrimonioControl();
  static final FundoImobiliarioControl _fundoImobiliarioControl = FundoImobiliarioControl();
  static final CompraControl _compraControl = CompraControl();
  static final VendaControl _vendaControl = VendaControl();
  static final ImpostoControl _impostoControl = ImpostoControl();
  static final DividendoControl _dividendoControl = DividendoControl();


  static UsuarioControl obterUsuarioControl(){
    return _usuarioControl;
  }

  static PatrimonioControl obterPatrimonioControl(){
    return _patrimonioControl;
  }

  static FundoImobiliarioControl obterFundoImobiliarioControl(){
    return _fundoImobiliarioControl;
  }

  static CompraControl obterCompraControl(){
    return _compraControl;
  }

  static VendaControl obterVendaControl(){
    return _vendaControl;
  }

  static DividendoControl obterDividendoControl(){
    return _dividendoControl;
  }

  static ImpostoControl obterImpostoControl(){
    return _impostoControl;
  }
}