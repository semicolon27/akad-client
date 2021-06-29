import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/login_background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            )),
          Expanded(
            flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 100,
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
                            Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                              Text(
                                  " LOG IN ",
                                  style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                              )),
                             ],
                            ),
                            Padding(
                            padding: EdgeInsets.all(10)),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                              Text(
                                "Silahkan masuk ke Dasboard Admin",
                                  style: TextStyle(
                                  color: Colors.blue[100],
                                  fontSize: 15,
                              )),
                             ],
                            ),
                            Padding(
                            padding: EdgeInsets.all(30)),
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
                                   color: Colors.blueAccent,
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
                             color: Colors.blueAccent,
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
                    )),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
