import 'package:flutter/material.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 2));
    return false;
  }
}
