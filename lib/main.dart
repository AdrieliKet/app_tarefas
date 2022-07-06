import 'package:flutter/material.dart';
import 'package:flutter_crud/formulario.dart';
import 'package:flutter_crud/menu_tarefa.dart';
import 'package:flutter_crud/usuario.dart';

imprimir() async {
  await Future.delayed(const Duration(seconds: 3));
  print(0);
}

carregarTela() {
  print('carregando tela...');
}

carregarBotoes() {
  print('carregando botões...');
}

carregarCampos() {
  print('carregando campos...');
}

carregarDados() async {
  await Future.delayed(const Duration(seconds: 2));
  print('carregando dados...');
}

lerHD() async {
  await Future.delayed(const Duration(seconds: 4));
  print('lendo HD...');
}

void main() async {
  await lerHD();
  await carregarDados();
  carregarTela();
  carregarBotoes();
  carregarCampos();
  imprimir();

  Map<String, dynamic> aluno = {'Ra': 2020, 'nome': 'adrieli', 'peso': 70.5};
  print(aluno.values);
  print(aluno['peso']);

  Map<String, String> pessoa = {'nome': 'adrieli', 'sobrenome': 'santos'};
  print(pessoa.length);
  print(pessoa.keys);
  print(pessoa.values);
  print(pessoa['nome']);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: { //map
        '/': (context) => Menu(),
        '/formTarefa': (context) => FormuTarefas(),
        '/usuarios': (context) => Usuario()  
      },
    );
  }
}
