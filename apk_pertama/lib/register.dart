import 'package:flutter/material.dart';

class registerPage extends StatefulWidget{
  const registerPage({super.key});

  @override
 State<registerPage> createState() => _registerPageState();
}

 class _registerPageState extends State<registerPage> {
    final TextEditingController  _usernameController = TextEditingController();
    final TextEditingController  _passwordController = TextEditingController();
    final TextEditingController  _ageController = TextEditingController();

    @override

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Masukan username',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukan Password',
                  border: OutlineInputBorder(

                  )
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Masukan Umur Anda',
                  border: OutlineInputBorder(

                  )
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
                    String age = _ageController.text;
                    print('Username: $username, Passwrod: $password, age:$age');
                    Navigator.pop(context);
                  },
                  child: const Text('register')
                ),
              )
            ],
          ),
        ),
      );
    
    }
  
  }

