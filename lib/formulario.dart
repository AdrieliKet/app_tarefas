import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FormuTarefas extends StatelessWidget {
  Future<int> salvar(String nome, String descricao, [int? id]) async {
    String caminho = join(await getDatabasesPath(), 'banco.db');
    Database banco = await openDatabase(caminho, version: 1);

    String sql;
    Future<int> linhasAfetadas;
    if (id == null) {
      sql = 'INSERT INTO tarefa (nome, descricao) VALUES (?,?)';
      linhasAfetadas = banco.rawInsert(sql, [nome, descricao]);
    } else {
      sql = 'UPDATE tarefas SET nome = ?, descricao = ? WHERE id = ?';
      linhasAfetadas = banco.rawUpdate(sql, [nome, descricao, id]);
    }
    return linhasAfetadas;
  }

  

  String? nome;
  String? descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas'),
        ),
        body: Center(
            child: Column(children: [
          TextFormField(
            onChanged: (value) => nome = value,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              label: Text("Nome"),
              border: OutlineInputBorder(),
              hintText: "Digite o nome da tarefa",
              helperText: "Ex. Ir ao mercado",
              prefixIcon: Icon(Icons.add_box),
            ),
          ),
          TextFormField(
            onChanged: (value) => descricao = value,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              label: Text("Descrição"),
              border: OutlineInputBorder(),
              hintText: "Digite a descricão",
              helperText: "Ex. Comprar verduras",
              prefixIcon: Icon(Icons.assignment_turned_in_sharp),
            ),
          ),
          ElevatedButton(
            child: Text("Adicionar tarefa"),
            onPressed: () => (salvar(nome!, descricao!)),
          ),
        ])));
  }
}
