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
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _idadeController = TextEditingController();

  bool _mostraSenha = true;
  String _genero = "outro";
  bool _aceitoTermos = false;

  void enviar(){
    final valido = _formKey.currentState?.validate()?? false;
    if (!valido) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Verifique seu formulario"),
          duration: const Duration(seconds: 3),
         )
        );
    }
    if (!_aceitoTermos){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aceite os Termos'),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
    
     showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (context) {
        return AlertDialog(
           title: Text('Title'),
           content: Column(
            children: [
              Text(_nomeController.text),
              Text(_emailController.text),
            ],
            ),
            actions: [
              TextButton(onPressed:(){
                 Navigator.of(context).pop();
              },
              child: Text("Fechar"),
              )
            ],
           );
         },
       );
  }

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
            ),
             SizedBox(height: 16,),
          DropdownButtonFormField<String>(
            value: _genero,
            decoration: const InputDecoration(
              labelText: 'Genêro',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: "masculino",
                child: Text("Masculino")),

              DropdownMenuItem(
                value: "feminino",
                child: Text("Feminino")),

              DropdownMenuItem(
                value: "outro",
                child: Text("Outro")),
            ],
            onChanged: (value) {
              setState(() {
                _genero =value ?? "Outro";
              });
            },
          ),
          SizedBox(height: 16,),
          CheckboxListTile(
           contentPadding: EdgeInsets.zero,
           controlAffinity: ListTileControlAffinity.leading,
           title: Text("Aceito os termos") ,
           subtitle: _aceitoTermos? null : Text("Aceite os termos para continuar", style: TextStyle(color: Colors.red),),
           value:_aceitoTermos,
           onChanged: (v){
            setState(() {
              _aceitoTermos = v?? false;
            });
           }
           ),
            SizedBox(height: 17,),
            ElevatedButton.icon(
              onPressed: enviar,
              label: Text("Enviar"),
              icon: Icon(Icons.check),
          )
          ],     
         ),
        )),
    );    
  }
}
    