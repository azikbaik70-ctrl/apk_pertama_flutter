import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController _usernameController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Masukan Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
             obscureText: true,
             decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Massukan Password',
              border: OutlineInputBorder()
             ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  print('Username: $username, Password: $password');
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('login'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Belum punya akun? Register'),
            )
          ],
        ),
      )
    );
   }
}