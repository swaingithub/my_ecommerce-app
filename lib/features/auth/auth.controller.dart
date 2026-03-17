import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

class AuthController extends FluxController {
  final email = flux<String>("");
  final fullName = flux<String>("");
  final password = flux<String>("");
  final isLoading = flux<bool>(false);
  final isSignUpMode = flux<bool>(false);

  Future<void> handleAuth(BuildContext context) async {
    if (email.value.isEmpty || password.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields.'), backgroundColor: Colors.redAccent)
      );
      return;
    }

    isLoading.value = true;
    
    // Simulate auth network request
    await Future.delayed(const Duration(seconds: 2));
    
    isLoading.value = false;
    
    // Auth successful -> go to home
    Fluxy.offAll('/home');
  }

  void toggleMode() {
    isSignUpMode.value = !isSignUpMode.value;
  }
}
