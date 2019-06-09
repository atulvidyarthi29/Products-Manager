import 'package:meta/meta.dart';

class User {
  final String id;
  final String email;
  final String password;

  User({
    @required this.email,
    @required this.password,
    @required this.id,
  });
}
