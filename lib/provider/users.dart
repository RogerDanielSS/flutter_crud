import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_user.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier{
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex (int index) {
    return _items.values.elementAt(index);
  }

  void put (User user){
    print("teste");
    if(user.id.trim().isNotEmpty && _items.containsKey(user.id)){
      _items.update(user.id, (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatar_url: user.avatar_url));
    } else {
      final id = Random().nextDouble().toString();

    _items.putIfAbsent(id, () => User(
      id: id,
      name: user.name,
      email: user.email,
      avatar_url: user.avatar_url
    ));    
    }

    notifyListeners();
  }

  void remove(String userId){
    _items.remove(userId);

    notifyListeners();
  }
}