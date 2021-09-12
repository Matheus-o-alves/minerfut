import 'package:flutter/foundation.dart';

class AuthCredentials {
  final String username;
  final String? email;
  final String? password;
  String? userId;

  AuthCredentials(
     this.userId,
      this.email,
    this.password,
    {
    required this.username,
   
   
  });
}