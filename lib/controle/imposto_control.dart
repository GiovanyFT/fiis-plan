
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/imposto.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/util/meses_ano.dart';

class ImpostoControl{


  Future<List<Imposto>> gerarImpostos(String texto_ano, String texto_mes) async {
    List<Imposto> impostos = List<Imposto>();
    Usuario usuario = await Usuario.obter();
    List<Patrimonio> patrimonios = await FabricaControladora
        .obterPatrimonioControl().obterPatrimonios(usuario);
    for (Patrimonio patrimonio in patrimonios) {
      List<Venda> vendas = await FabricaControladora.obterVendaControl()
          .obterVendas(patrimonio, texto_ano);
      List<Venda> vendas_a_tributar = List<Venda>();
      for (Venda venda in vendas) {
        int mes = venda.data_transacao.month;
        String mes_string = MesesAno.meses[mes - 1];
        if (mes_string == texto_mes) {
          vendas_a_tributar.add(venda);
        }
      }

      if (vendas_a_tributar.length > 0) {
        impostos.add(Imposto(vendas_a_tributar));
      }
    }
    return impostos;
  }
}