import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fundosimobiliarios/dominio/usuario.dart';
import 'package:fundosimobiliarios/telas/controle_interacao/controle_tela_mapa_usuarios.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TelaMapaUsuarios extends StatefulWidget {
  List<Usuario> usuarios;

  TelaMapaUsuarios(this.usuarios);

  @override
  _TelaMapaUsuariosState createState() => _TelaMapaUsuariosState();
}

class _TelaMapaUsuariosState extends State<TelaMapaUsuarios> {
  ControleTelaMapaUsuarios _controle;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle = ControleTelaMapaUsuarios(widget.usuarios);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Usuários'),
      ),
      body: _body(),
    );
  }

  _body() {
    Future<List<Marker>> future = _controle.obterMarkers(widget.usuarios);
    return FutureBuilder<List<Marker>>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _controle.markers = Set.of(snapshot.data);
        _controle.inicializarPosicaoAtual();
        return _conteudo();
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controle.mapController = controller;
  }

  _conteudo() {
    return Stack(
      children: <Widget>[
        Container(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _controle.obterPosicaoInicial(),
              zoom: 17,
            ),
            markers: _controle.markers,
            onMapCreated: _onMapCreated,
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            onPressed: () {
              _controle.avancarProximoMarker();
            },
          ),
        ),
      ],
    );
  }
}
