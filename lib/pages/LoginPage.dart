import 'package:flutter/material.dart';
import 'package:akad/pages/template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateWidgetLogin(
        child: Scaffold(
          body: Column(
            children: [
              Text(
                  "LOG IN",
                  style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
               Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                      height: 300,
                      width: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            autocorrect: false,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your e-mail',
                              labelText: 'Username',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:25,
                            ),
                            child: TextField(
                            autocorrect: false,
                            autofocus: false,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text(
                               'Forget Password?',
                               style: TextStyle(
                                 color: Colors.red,
                                 fontSize: 14,
                               ),
                             ),
                           ],
                         ),
                         Padding(
                          padding: EdgeInsets.all(10),
                        ),
                         MaterialButton(
                           onPressed: (){},
                           minWidth: 250,
                           splashColor: Colors.green,
                           color: Colors.red,
                           padding: EdgeInsets.symmetric(
                             vertical: 12,
                           ),
                           child: Text(
                             'Login',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                             ),
                           ),
                         ),
                        ],
                      ),
                    ),
                ),
            ],
          ),
          ],
        ),
        )
    );
  }
}
