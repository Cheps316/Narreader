import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pallete.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 24.0),
          child: Column(
            children: [
            Container(
              child: Center(
                child: Text(
                    'Login',
                  style: TextStyle(
                      color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                 
                ),
                       decoration: BoxDecoration(
                        border:
                          Border(bottom: BorderSide( width: 2, color: kWhite))),
              ),
              Container(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Password',
              
                  ),
             
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    buttonName: 'Login',
                  ),
                  SizedBox(
                    height: 25,
                  ),GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    'Create New Account',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
                ],
              ),
              ),
              ]
              )
          ),
              );      
  }
}
