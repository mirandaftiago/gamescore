import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  String _email = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Validade email function
  String? validateEmail(String? email) {
    if (email!.isEmpty) {
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
    // return null if the text is valid
    return null;
  }

  //Validate password function
  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Can\'t be empty';
    }
    if (password.length < 6) {
      return 'Password should not less than 6 digit';
    }
    // return null if the text is valid
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 5.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter valid email id',
                  ),
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) => setState(() => _email = text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 15, bottom: 10),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 18.0),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
              Container(
                width: 350.0,
                height: 70,
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                child: FilledButton(
                  onPressed: _email.isNotEmpty ? _submit : null,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'New User? Create Account',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
