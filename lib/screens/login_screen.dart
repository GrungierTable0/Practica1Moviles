import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool bandera = false;
  DatabaseHelper? _database;
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  // Obtain shared preferences.
  


  
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      _database = DatabaseHelper();
    }
    
    //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
        hintText: 'Introduce el usuario ', 
        label: Text('Correo Electronico')
      ),
      //onChanged: ,
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Introduce el password ', label: Text('Contraseña')),
    );
    final choLogin = Checkbox(
      onChanged: (bool? value){
        if(value != null){
          setState(() => this.bandera = value);
        }
      },
      value: this.bandera,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //height: double.infinity,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40) ,
        height: MediaQuery.of(context).size.height,//sirve para que un elemnto tenga el ancho y largo de la pantalla
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover//Rellana el fondo para que no se vea mal
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 6,
              child: Image.asset(
                'assets/logo_A.png',
                width: MediaQuery.of(context).size.width/ 1.5,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width/60,
                left: MediaQuery.of(context).size.width/30,
                right: MediaQuery.of(context).size.width/30,
                bottom: MediaQuery.of(context).size.width/60
              ),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 15,
                    
                  ), 
                  txtPwd,
                  const Text('Mantener Sesión',textAlign:TextAlign.center,),
                  choLogin,

                ],
              ),
            ),
            /*Positioned(
              bottom: MediaQuery.of(context).size.width / 9,
              right:  MediaQuery.of(context).size.width / 20,
              child: 
            ),*/
            Positioned(
              bottom: MediaQuery.of(context).size.width / 80,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width /8
                ),
                width: MediaQuery.of(context).size.width /1,
                child: Column(
                  //shrinkWrap: true,
                  children: [
                    GestureDetector(              
                      onTap: () async {
                        await ProgressDialog.future(
                          context, 
                          future: Future.delayed(Duration(seconds: 1), () {
                            return "";
                          }),
                          message: Text("Please Wait"),
                          title: Text("Loging in"),
                        );
                        Navigator.popAndPushNamed(context, '/dash',);
                        //print('Valor de la caja ${txtConUser.text}');
                        /*if('prueba@correo.com'.compareTo(txtConUser.text)==0 && '1234'.compareTo(txtConPwd.text)==0){
                          await ProgressDialog.future(
                            context, 
                            future: Future.delayed(Duration(seconds: 1), () {
                              return "";
                            }),
                            message: Text("Please Wait"),
                            title: Text("Loging in"),
                          );
                          final prefs = await SharedPreferences.getInstance();
                          if(bandera){
                            await prefs.setBool('keepLogin', true);
                          }else{
                            await prefs.setBool('keepLogin', false);
                          }
                          Navigator.popAndPushNamed(context, '/dash',);  
                        }else{
                            await DialogBackground(
                              dialog: AlertDialog(
                                title: Text("Alert Dialog"),
                                content: Text("Ups.. Esta es una versión de prueba, debes ingresar los siguientes valores\ncorreo: prueba@correo.com\ncontraseña:1234"),
                                backgroundColor: Colors.red,
                                titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                                contentTextStyle: TextStyle(color: Colors.white),
                                
                              ),
                            ).show(context);
                        }*/
                      },
                      child: Image.asset(
                        'assets/escudo.png',
                        height: MediaQuery.of(context).size.width / 7,
                      ),
                      
                    ),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.github,
                      onPressed: () async{
                        _database?.eliminarUser(1, 'tblUsers');
                      },
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () {},
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}