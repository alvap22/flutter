import 'package:flutter/material.dart';
import 'package:apptarefas/modelo/objeto_data_hora.dart';
import 'package:apptarefas/widgets/itens_lista.dart';

class Pagina_lista extends StatefulWidget {
  @override
  State<Pagina_lista> createState() => _Pagina_listaState();
}

class _Pagina_listaState extends State<Pagina_lista> {
  final TextEditingController mensagensControlador = TextEditingController();
  List<Data_Hora> Mensagens = [];

  void mostrarConfirmacaoLimpar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Limpar Tarefas"),
          content: Text("Tem certeza que deseja limpar todas as tarefas?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Mensagens.clear();
                });
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text("Limpar"),
            ),
          ],
        );
      },
    );
  }

  void deletar_tarefas(Data_Hora mensagem_data_hora) {
    setState(() {
      Mensagens.remove(mensagem_data_hora);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${mensagem_data_hora.titulo} foi removida com sucesso",
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Voltar',
          onPressed: () {
            setState(() {
              Mensagens.add(mensagem_data_hora);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: mensagensControlador,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicione uma tarefa",
                        hintText: "Digite aqui",
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      String qualquercoisa = mensagensControlador.text;
                      if (qualquercoisa.isNotEmpty) {
                        setState(() {
                          Data_Hora item_data_hora = Data_Hora(
                              titulo: qualquercoisa, data_hora: DateTime.now());
                          Mensagens.add(item_data_hora);
                        });
                        mensagensControlador.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff0ffa00),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Data_Hora mensagem_controle in Mensagens)
                      TudoItemLista(
                        mensagem_data_hora: mensagem_controle,
                        item_deletar_tarefas: deletar_tarefas,
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text("Você possui ${Mensagens.length} tarefas pendentes"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: mostrarConfirmacaoLimpar,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff0ffa00),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Text("Limpar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
