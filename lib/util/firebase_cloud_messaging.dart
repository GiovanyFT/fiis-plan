import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/util/nav.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TratadorNotificacao{
  static BuildContext _context;
  static FirebaseMessaging _fcm;

  static void inicializarFCM(BuildContext context) {
    _context = context;

    if (_fcm == null) {
      _fcm = FirebaseMessaging();
    }

    _fcm.configure(
      // Quando a aplicação está ativa
      onMessage: (Map<String, dynamic> message) async {

        // 'mensagem' deve ser chave um Dado Personalizado do item
        // Outras opções (opcional)
        // Também deve ser colocado o dado personalizado com chave
        // 'click_action' com o valor 'FLUTTER_NOTIFICATION_CLICK'
        _showDialog(message['data']['mensagem']);
      },
      // Quando a aplicação está voltando ao foco
      onResume: (Map<String, dynamic> message) async {
      //  _showDialog(message['data']['mensagem']);
      },
      // Quando a aplicação está sendo recarregada
      // (havia saído pelo botão voltar)
      onLaunch: (Map<String, dynamic> message) async {
      //  _showDialog(message['data']['mensagem']);
      },
    );

    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true));
      _fcm.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("iOS Push Settings: [$settings]");
      });
    }
  }

  static void _showDialog(String mensagem) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Notificação"),
          content:
          new Text(mensagem),
          actions: <Widget>[
            // define os botões na base do dialogo
            FlatButton(
              child: new Text("Fechar"),
              onPressed: () async {
                pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}



