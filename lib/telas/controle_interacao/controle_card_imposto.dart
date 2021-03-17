
import 'package:fundosimobiliarios/dominio/imposto.dart';
import 'package:fundosimobiliarios/dominio/venda.dart';
import 'package:fundosimobiliarios/util/formatacao.dart';

class ControleCardImposto{
  Imposto imposto;

  ControleCardImposto(this.imposto);

  String valor_compra_texto, valor_venda_texto, resultado;

  void gerarValoresItemVenda(Venda venda) {
     double valor_compra = venda.valor_medio_compra * venda.quantidade;
     double valor_venda = venda.valor_cota*venda.quantidade - venda.taxa;
     valor_compra_texto = formatarNumero(valor_compra);
     valor_venda_texto = formatarNumero(valor_venda);
     resultado = formatarNumero(valor_venda - valor_compra);
  }

  double calcularValorTotal(){
    double total = 0;
    List<Venda> vendas = imposto.vendas;
    for(Venda venda in vendas){

      double valor_compra = venda.valor_medio_compra * venda.quantidade;
      double valor_venda = venda.valor_cota*venda.quantidade  - venda.taxa;;
      total += valor_venda - valor_compra;
    }
    return total;
  }

  double calcularImposto(){
    return calcularValorTotal() * 0.2;
  }

}