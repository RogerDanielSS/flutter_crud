import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/Users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user; 

  const UserTile(this.user, {super.key});
  
  @override
  Widget build(BuildContext context) {
    final avatar = user.avatar_url.isEmpty 
    ? const CircleAvatar(child: Icon(Icons.person)) 
    : CircleAvatar(backgroundImage: NetworkImage(user.avatar_url));
    final Users users = Provider.of(context);

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
        children: <Widget>[
          IconButton(onPressed: () {
            
            Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: user);

          }, icon: const Icon(Icons.edit), color: Colors.blue[400]),

          IconButton(onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Excluir usuário'),
                content: const Text('Tem certeza'),
                actions: <Widget>[
                  TextButton(child: const Text("Não", style: TextStyle(color: Colors.red)), onPressed: () => Navigator.of(context).pop(false),),
                  TextButton(child: const Text("Sim", style: TextStyle(color: Colors.red)), onPressed: () => Navigator.of(context).pop(true),),
                ],
              ),
            ).then((confirmed){
              if(confirmed){
                users.remove(user.id); 
              }
            });
          }, icon: const Icon(Icons.delete), color: Colors.red[600],),
        ],
      ),
      )
    );
  }
  
}