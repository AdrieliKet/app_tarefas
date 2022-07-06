import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Usuario extends StatelessWidget {
  Future<List<Map<String, Object?>>> buscarDados() async {
    String caminho = join(await getDatabasesPath(), 'banco');
    //deleteDatabase(caminho);
    Database db = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE usuario(id INT PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL)''');
        db.execute(
            'INSERT INTO usuario(nome, email) VALUES("Adrieli", "adrieli@gmail.com") ');
        db.execute(
            'INSERT INTO usuario(nome, email) VALUES("Jean", "jean@gmail.com") ');
        db.execute(
            'INSERT INTO usuario(nome, email) VALUES("Danieli", "dani@gmail.com") ');
      },
    );
    List<Map<String, Object?>> lista =
        await db.rawQuery('SELECT * FROM usuario');
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),
      body: FutureBuilder(
        future: buscarDados(),
        builder:
            (context, AsyncSnapshot<List<Map<String, Object?>>> dadosFuturos) {
          if (!dadosFuturos.hasData) return CircularProgressIndicator();
          var usuarios = dadosFuturos.data!;
          return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, contador) {
                var usuario = usuarios[contador];
                return ListTile(
                  title: Text(usuario['nome'].toString()),
                  subtitle: Text(usuario['email'].toString(),
                  ),
                );
              });
        },
      ),
    );
  }
}
