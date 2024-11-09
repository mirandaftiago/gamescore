import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamescore/HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  bool isRegistering = false;
  String _name = '';
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validate name function
  String? validateName(String? name) {
    if (isRegistering && (name == null || name.isEmpty)) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  // Validate email function
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Can\'t be empty';
    }
    if (email.length < 4) {
      return 'Too short';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Invalid Email Id';
    }
    return null;
  }

  // Validate password function
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Can\'t be empty';
    }
    if (password.length < 6) {
      return 'Password should not be less than 6 characters';
    }
    return null;
  }

  // Submit function for login and registration
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (isRegistering) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')),
          );
          setState(() {
            isRegistering = false;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } else {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isRegistering ? "Register" : "Login"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 120.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child:
                    SizedBox(width: 200, height: 150, child: Image.asset('')),
              ),
              if (isRegistering) // Show Name field only when registering
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter your name',
                    ),
                    validator: validateName,
                    onChanged: (text) => setState(() => _name = text),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter valid email id',
                  ),
                  validator: validateEmail,
                  onChanged: (text) => setState(() => _email = text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: validatePassword,
                  onChanged: (text) => setState(() => _password = text),
                ),
              ),
              Container(
                width: 350.0,
                height: 70,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: FilledButton(
                  onPressed: _submit,
                  child: Text(
                    isRegistering ? 'Register' : 'Login',
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isRegistering = !isRegistering;
                  });
                },
                child: Text(
                  isRegistering
                      ? 'Already have an account? Login'
                      : 'New User? Create Account',
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
