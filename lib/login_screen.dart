import 'package:flutter/material.dart';
import 'package:user_app/second_screen.dart';
import 'package:user_app/user_model.dart';
import 'constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<User> users = [];

  final _loginFromkey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  String? _selectedSource;

  @override
  void dispose() {
    super.dispose();
    nameFieldController.dispose();
    emailFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginFromkey,
        child: Column(
          children: [
            TextFormField(
              controller: nameFieldController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            verticalpadding16,
            TextFormField(
              controller: emailFieldController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            verticalpadding16,
            DropdownButtonFormField<String>(
              value: _selectedSource,
              items: ['Facebook', 'Instagram', 'Organic', 'Friend', 'Google']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSource = value!;
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Where are you coming from?'),
              validator: (value) {
                if (value == null) {
                  return 'Please select a source';
                }
                return null;
              },
            ),
            verticalpadding16,
            ElevatedButton(
              onPressed: () {
                if (_loginFromkey.currentState!.validate()) {
                  User newuser = User(
                      name: nameFieldController.text,
                      email: emailFieldController.text,
                      source: _selectedSource.toString());
                  users.add(newuser);
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckUsers(
                                allUsers: users,
                              )));
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
