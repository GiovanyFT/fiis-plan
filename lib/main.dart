import 'package:flutter/material.dart';
import 'package:fundosimobiliarios/telas/tela_abertura.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Força português independente o idioma do smartphone
      // Deixei essa linha apenas para mostrar, num aplicativo a ser
      // disponibilizado no AppStore, ela deve ser retirada
      locale: Locale('pt', 'BR'),  // Current locale
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('pt', 'BR'), // Brasil
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        // Define o tema para claro ou escuro
        brightness: Brightness.light,
        // Define a cor de fundo padrão para Containers
        scaffoldBackgroundColor: Colors.white,
      ),
      home: TelaAbertura(),
    );
  }
}
