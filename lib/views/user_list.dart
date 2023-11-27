
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/Users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: context);
            }, icon: const Icon(Icons.add, color: Colors.white,))
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i))
        ),
    );
  }
}