import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),

                  defaultFormField(

                    controller: emailController,

                    iconData: Icons.email,

                    label: 'Enter your email',

                    textInputType: TextInputType.emailAddress,

                    validator: (String value) {
                      if (value.isEmpty) {

                        return 'enter your email';

                      }
                      return null;
                    }
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(

                      controller: passwordController,

                      iconData: Icons.lock,

                      label: 'Enter your password',

                      textInputType: TextInputType.visiblePassword,


                      suffix:isPassword? Icons.remove_red_eye_rounded :Icons.visibility_off,

                      isPassword: isPassword,

                      isPressed: (){
                        setState(() {
                          isPassword =!isPassword;
                        });
                      },

                      validator: (String value) {
                        if (value.isEmpty) {

                          return 'enter your password ';

                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {

                        if(formKey.currentState.validate()){

                          print(emailController.text);
                          print(passwordController.text);
                        }

                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
