import 'dart:async';

import 'package:uuid/uuid.dart';

import 'models/models.dart';

class UserRepository {
  UserRepository();
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(id: const Uuid().v4()),
    );
  }

  User fromJson(Map<String, dynamic> json) {
    _user = _user?.copyWith(
      id: '-',
      username: json['username'],
      name: json['name'],
      url: json['url'],
    );

    return _user ?? User.empty;
  }
}
