import 'package:flutter/material.dart';
import 'package:apptarefas/modelo/objeto_data_hora.dart';
import 'package:apptarefas/widgets/itens_lista.dart';

class Data_Hora{
  Data_Hora({required this.titulo, required this.data_hora});
  
  String titulo;
  DateTime data_hora;
}