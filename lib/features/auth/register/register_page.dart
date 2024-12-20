import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/components/my_button.dart';
import 'package:quiz_app_flutter/components/my_textfield.dart';
import 'package:quiz_app_flutter/navigation_page.dart';
import 'package:quiz_app_flutter/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // DateTime? _birthdate = null;
  String? _errorMessage;

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Display loading circle
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      String firstname = _firstNameController.text;
      String lastname = _lastNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String passwordConfirmation = _confirmPasswordController.text;

      bool success = await AuthService()
          .register(firstname, lastname, email, password, passwordConfirmation);
      Navigator.of(context).pop();

      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavigationPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Registration failed, please try again.')));
      }
    }
  }

  // Future<void> _selectBirthdate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _birthdate ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null && pickedDate != _birthdate) {
  //     setState(() {
  //       _birthdate = pickedDate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  // Welcome Text
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                  const Text(
                    'Let\'s create an account for you!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Username textfield
                  // MyTextField(
                  //   controller: _usernameController,
                  //   hintText: 'Username',
                  //   obscureText: false,
                  // ),

                  // const SizedBox(height: 10),

                  // Firstname textfield
                  MyTextField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // Lastname textfield
                  MyTextField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // email textfield
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // birthday textfield
                  // Expanded(
                  //   child: TextFormField(
                  //     readOnly: true,
                  //     onTap: () => _selectBirthdate(context),
                  //     controller: TextEditingController(
                  //       text: _birthdate != null
                  //           ? '${_birthdate!.day.toString().padLeft(2, '0')}/${_birthdate!.month.toString().padLeft(2, '0')}/${_birthdate!.year}'
                  //           : '01/Jan/1990',
                  //     ),
                  //     decoration: const InputDecoration(
                  //       labelText: 'Birthday',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // confirm password textfield
                  MyTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  if (_errorMessage != null) const SizedBox(height: 10),

                  // sign up button
                  MyButton(
                    onTap: _register,
                    buttonText: "Sign Up",
                  ),

                  const SizedBox(height: 30),

                  // already a member? login now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
