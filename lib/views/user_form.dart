
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/Users.dart';
import 'package:provider/provider.dart';


class UserForm extends StatelessWidget {
  final Map<String, String> _formData = {};

  UserForm({super.key});

  void _loadFormData(User user){
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatar_url'] = user.avatar_url;
  }

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    final Users users = Provider.of(context, listen: false);

    
    var user =  ModalRoute.of(context)?.settings.arguments;
    
    print(user);

    if(user.runtimeType == User){
      _loadFormData(user as User);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de usuário', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(onPressed: () {
            form.currentState?.validate(); // chama o validate de todos os TextForm dentro do form em questão
            form.currentState?.save(); // chama o save de todos os TextForm dentro do form em questão

            String id = _formData['id'] != null ? _formData['id']! : '';

            users.put(User(
              id: id,
              name: _formData['name']!,
              email: _formData['email']!,
              avatar_url: _formData['avatar_url']!)
              );

            Navigator.of(context).pop();
          }, icon: const Icon(Icons.save, color: Colors.white))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15), 
        child: Form(
          key: form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if(value?.trim() == ''){
                    return "Preencher";
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if(value?.trim() == ''){
                    return "Preencher";
                  }

                  return null;
                },
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatar_url'],
                decoration: const InputDecoration(labelText: "URL"),
                validator: (value) {
                  if(value?.trim() == ''){
                    return "Preencher";
                  }

                  return null;
                },
                onSaved: (value) => _formData['avatar_url'] = value!,
              ),
            ],
          ),
        )
      )
    );
  }
}