import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(const MaterialApp(home:FormBasico()));
}

class FormBasico extends StatefulWidget {
  const FormBasico({super.key});

  @override
  State<FormBasico> createState() => _FormBasicoState();  
}

class _FormBasicoState extends State<FormBasico> {
  final _formKey = GlobalKey();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _idadeController = TextEditingController();

  bool _mostraSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Primeiro Formulario"),
      ),
      body: Form(
        key:_formKey,
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(        
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: "Digite seu nome",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Digite um nome válido";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Digite seu email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Digite um email valido";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: _mostraSenha,
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: "Digite sua senha",
                border: OutlineInputBorder(),
                suffix: IconButton(onPressed: () {
                  setState(() {
                    _mostraSenha = !_mostraSenha;
                  });
                }, 
                icon: _mostraSenha ? Icon(Icons.visibility_off):Icon(Icons.visibility)),                
              ),
              validator:(value) {
                if (value == null || value.isEmpty){
                  return "Digite uma senha";
                }
                if (value.length < 5){
                  return "A senha deve ter no minino 5 caracteres";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _idadeController,
              decoration: InputDecoration(
                labelText: "Digite sua Idade",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
             validator:(value) {
               int? idade = int.tryParse(value!);
               if (idade == null){
                return "Digite uma idade";
               }
                if(idade > 130 || idade < 0) {
                  return "Verifique Idade!!";
                }
                return null;
               }
            )
          ],
                ),
        )),
    );    
  }
}
    