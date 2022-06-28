import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String _id;
  final String _username;
  final String _name;
  final String _url;
  const User({required id, username = '-', name = '-', url = '-'})
      : _id = id,
        _username = username,
        _name = name,
        _url = url;

  User copyWith(
      {String? id, String? username, String? name = '-', String? url = '-'}) {
    return User(
      id: id ?? _id,
      username: username ?? _username,
      name: name ?? _name,
      url: url ?? _url,
    );
  }

  String get id => _id;
  String get username => _username;
  String get name => _name;
  String get url => _url;

  @override
  List<Object> get props => [_id, _username, _name, _url];

  static const empty = User(id: '-');
}
