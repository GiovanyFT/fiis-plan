
import 'package:fundosimobiliarios/dominio/fundo_imobiliario.dart';
import 'package:fundosimobiliarios/dominio/patrimonio.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/persistencia/patrimonio_dao.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_principal.dart';

Comparator<Patrimonio> patrimonioPorSiglaFundo = (p1, p2) => p1.fundo.sigla.compareTo(p2.fundo.sigla);
Comparator<Patrimonio> patrimonioPorSiglaFundoDesc = (p1, p2) => p2.fundo.sigla.compareTo(p1.fundo.sigla);

Comparator<Patrimonio> patrimonioPorNomeFundo = (p1, p2) => p1.fundo.nome.compareTo(p2.fundo.nome);
Comparator<Patrimonio> patrimonioPorNomeFundoDesc = (p1, p2) => p2.fundo.nome.compareTo(p1.fundo.nome);

Comparator<Patrimonio> patrimonioPorTipoFundo = (p1, p2) => p1.fundo.segmento.compareTo(p2.fundo.segmento);
Comparator<Patrimonio> patrimonioPorTipoFundoDesc = (p1, p2) => p2.fundo.segmento.compareTo(p1.fundo.segmento);

Comparator<Patrimonio> patrimonioPorValorMedioFundo = (p1, p2) => p1.valor_medio.compareTo(p2.valor_medio);
Comparator<Patrimonio> patrimonioPorValorMedioFundoDesc = (p1, p2) => p2.valor_medio.compareTo(p1.valor_medio);

Comparator<Patrimonio> patrimonioPorQtCotaFundo = (p1, p2) => p1.qt_cotas.compareTo(p2.qt_cotas);
Comparator<Patrimonio> patrimonioPorQtCotaFundoDesc = (p1, p2) => p2.qt_cotas.compareTo(p1.qt_cotas);


class PatrimonioControl{
  PatrimonioDAO _dao = PatrimonioDAO();

  Future<List<Patrimonio>> obterPatrimonios(Usuario usuario, {String atributo = "Sigla - Crescente"}) async{
    List<Patrimonio> patrimonios = await _dao.obterLista(usuario);
    if(atributo == ControleTelaPrincipal.campos_ordenacao[0]){
      patrimonios.sort(patrimonioPorSiglaFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[1]){
      patrimonios.sort(patrimonioPorSiglaFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[2]){
      patrimonios.sort(patrimonioPorNomeFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[3]){
      patrimonios.sort(patrimonioPorNomeFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[4]){
      patrimonios.sort(patrimonioPorTipoFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[5]){
      patrimonios.sort(patrimonioPorTipoFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[6]){
      patrimonios.sort(patrimonioPorQtCotaFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[7]){
      patrimonios.sort(patrimonioPorQtCotaFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[8]){
      patrimonios.sort(patrimonioPorValorMedioFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[9]){
      patrimonios.sort(patrimonioPorValorMedioFundoDesc);
    }else if (atributo == ControleTelaPrincipal.campos_ordenacao[3]){
      patrimonios.sort(patrimonioPorNomeFundoDesc);
    }
    return patrimonios;
  }

  void criarNovoPatrimonio(FundoImobiliario fundo, Usuario usuario) {
    Patrimonio patrimonio = Patrimonio( fundo: fundo,
                                        usuario: usuario,
                                        valor_medio: 0.0,
                                        qt_cotas:  0);
    _dao.incluir(patrimonio);
  }

  void removerPatrimonio(Patrimonio patrimonio) {
    _dao.remover(patrimonio);
  }

  Future<int> obterQuantidadePatrimonios(Usuario usuario) async{
    return _dao.obterQuantidade(usuario);
  }
}