import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Menu extends StatelessWidget {
  Future<List<Map<String, Object?>>> buscarDados() async {
    String caminho = join(await getDatabasesPath(), 'banco.db');
    //deleteDatabase(caminho);
    Database db = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE tarefa(id INT PRIMARY KEY, nome TEXT NOT NULL, descricao TEXT NOT NULL)''');
        db.execute(
            'INSERT INTO tarefa(nome, descricao) VALUES("Projeto", "Projeto Web") ');
        db.execute(
            'INSERT INTO tarefa(nome, descricao) VALUES("Apresentação", "Apresentação em grupo") ');
        db.execute(
            'INSERT INTO tarefa(nome, descricao) VALUES("Lista", "Lista Exercicios") ');
      },
    );
    List<Map<String, Object?>> lista =
        await db.rawQuery('SELECT * FROM tarefa');
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white70,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/formTarefa');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white70,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/usuarios');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: buscarDados(),
        builder: (context, AsyncSnapshot<List<Map<String,Object?>>> dadosFuturos) {
          if (!dadosFuturos.hasData) return CircularProgressIndicator();
          var listaTarefa = dadosFuturos.data!;
          return ListView.builder(  
            itemCount: listaTarefa.length,
            itemBuilder: (context, contador){
              var tarefa = listaTarefa[contador];
              return ListTile(  
                title: Text(tarefa['nome'].toString()),
                subtitle: Text(tarefa['descricao'].toString(),),
              );
            }

          );
        },
      ),
    );
  }
}
