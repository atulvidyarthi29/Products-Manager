import 'package:meta/meta.dart';

class User {
  final String id;
  final String email;
  final String token;

  User({
    @required this.email,
    @required this.token,
    @required this.id,
  });
}
