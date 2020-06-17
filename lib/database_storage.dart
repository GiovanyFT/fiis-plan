import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fundosimobiliarios/controle/fabrica_contoladora.dart';
import 'package:fundosimobiliarios/dominio/usuario.dart';

class DataBaseStorage {
  static Future<List<File>> filesInDirectory(Directory dir) async {
    List<File> files = <File>[];
    await for (FileSystemEntity entity
        in dir.list(recursive: false, followLinks: false)) {
      FileSystemEntityType type = await FileSystemEntity.type(entity.path);
      if (type == FileSystemEntityType.FILE) {
        files.add(entity);
        print(entity.path);
      }
    }
    return files;
  }

  static void enviarBDParaStorage(String nome_arquivo) async {
    var storageRef = FirebaseStorage.instance.ref();
    var bdRef = storageRef.child("/$nome_arquivo/$nome_arquivo.db");
    StorageTaskSnapshot task = await bdRef
        .putFile(File(
            "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db"))
        .onComplete;
    String urlFile = await task.ref.getDownloadURL();
    print("urlFile1 => $urlFile");

    bdRef = storageRef.child("/$nome_arquivo/$nome_arquivo.db-shm");
    task = await bdRef
        .putFile(File(
            "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db-shm"))
        .onComplete;
    urlFile = await task.ref.getDownloadURL();
    print("urlFile2 => $urlFile");

    bdRef = storageRef.child("/$nome_arquivo/$nome_arquivo.db-wal");
    task = await bdRef
        .putFile(File(
            "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db-wal"))
        .onComplete;
    urlFile = await task.ref.getDownloadURL();
    print("urlFile3 => $urlFile");

    Directory diretorio =
        Directory("/data/data/com.fundos.fundosimobiliarios/app_flutter/");
    List<File> arquivos = await filesInDirectory(diretorio);
    for (int i = 0; i < arquivos.length; i++) {
      bdRef = storageRef.child("/$nome_arquivo/imagens/${arquivos[i].path.substring(52)}");
      task = await bdRef.putFile(arquivos[i]).onComplete;
      urlFile = await task.ref.getDownloadURL();
      print("arquivo$i => $urlFile");
    }
  }

  static void buscarBDDoStorage(String nome_arquivo)  {
    String arquivo_db = "/$nome_arquivo/$nome_arquivo.db";
    print("Arquivo db $arquivo_db");
    StorageReference ref = FirebaseStorage.instance.ref().child(arquivo_db);
    ref.writeToFile(
        File("/data/data/com.fundos.fundosimobiliarios/databases/fundos.db"));

    ref = FirebaseStorage.instance.ref().child(arquivo_db + "-shm");
    ref.writeToFile(File(
        "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db-shm"));

    ref = FirebaseStorage.instance.ref().child(arquivo_db + "-wal");
    ref.writeToFile(File(
        "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db-wal"));

    // Dando um tempo para exibição da tela de abertura
    Future futureB = Future.delayed(Duration(seconds: 3));
     futureB.then((value){
       Future<List<Usuario>> future = FabricaControladora.obterUsuarioControl().obterUsuarios();
       future.then((usuarios) {
         for(Usuario usuario in usuarios){
           print("Usuário: $usuario");
           if(usuario.urlFoto != null){
             String caminho_foto = "/$nome_arquivo/imagens/${usuario.urlFoto.substring(55)}";
             print("CAMINHO ==> $caminho_foto");
             ref = FirebaseStorage.instance.ref().child(caminho_foto);
             print("URL FOTO => ${usuario.urlFoto}");
             ref.writeToFile(File(usuario.urlFoto));
           }
         }
       });

     });

  }
}
