
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practica1/models/users_model.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/database_helper.dart';

class DashboardScreen extends StatefulWidget {
   DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
  
}


class _DashboardScreen extends State<DashboardScreen> {
  DatabaseHelper? _database;
  final controllerPage=PageController();
  bool isLastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelper();
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
  Widget buildPage({required Color color,required String title,required String URLImage,required String Decription}){
    return  Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GoogleFonts.peralta().fontFamily,
              fontSize: 50,
              
            ),
            
          ),
          
          
          Container(
            child: Image.asset(
              URLImage,
              fit: BoxFit.cover,
              width: double.infinity,
              
            ),
          ),
          
          Padding(padding: EdgeInsets.symmetric(vertical: 10),),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width-20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueAccent,
                width: 20
              )
            ),
            child: Text(
              Decription,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: GoogleFonts.signika().fontFamily
              ),
            ),
          )
          

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {   
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      
      drawer: Drawer(
        backgroundColor: Colors.blueGrey,
        
        child: ListView(
          children: [
            FutureBuilder(
              future: _database!.getUser(),
              builder: (context, AsyncSnapshot<List<UsersDAO>> snapshot) {
                if(snapshot.hasData&&snapshot.data?.length!=0){
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg'),
                        fit: BoxFit.cover
                      ),
                    ),
                    
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            '/profile',
                            arguments:{

                              'idUser': snapshot.data![0].idUser,
                              'imageUser': snapshot.data![0].imageUser,
                              'nameUser': snapshot.data![0].nameUser,
                              'emailUser': snapshot.data![0].emailUser,
                              'phoneUser': snapshot.data![0].phoneUser,
                              'gitUser': snapshot.data![0].gitUser,
                            } 
                          ).then((value) {
                            setState(() {});      
                          });
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: FileImage(File(snapshot.data![0].imageUser!)),
                          ),
                          
                        ),
                      ),
                    accountName: Text(
                      snapshot.data![0].nameUser!,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      snapshot.data![0].emailUser!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ); 
                }else{
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg'),
                        fit: BoxFit.cover
                      ),
                    ),
                    
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile').then((value){setState(() {
                            
                          });});
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/default-user-image.png',),
                            
                          ),
                          
                        ),
                      ),
                    accountName: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              } 
            ),
            ListTile(
              leading: Image.asset('assets/iconGroot.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Práctica 1'),
              onTap: (){},
            ),
            ListTile(
              leading: Image.asset('assets/iconGroot.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de Datos'),
              onTap: (){
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              leading: Image.asset('assets/iconGroot.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Popular Movies'),
              onTap: (){
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              leading: Image.asset('assets/iconGroot.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
              onTap: () {
                /*final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('keepLogin', false);*/
                Navigator.popAndPushNamed(context, '/login');
              
              },
            ),
            
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: PageView(
          controller: controllerPage,
          onPageChanged: (index) {
            setState(() {
             isLastPage = index ==2; 
            });
          },

          children: [
            buildPage(
              color: Colors.red,
              title: '!Bienvenida!',
              URLImage: 'assets/page1-image.jpg',
              Decription: 'El pasado miércoles 21 del presente, en el Auditorio del Centro para las Artes del Campus II del TecNM en Celaya, se llevó a cabo la Tradicional bienvenida de la carrera de Ingeniería en Sistemas Computacionales, "Hochos y Chescos". \n\nEn el presídium se contó con la presencia del doctor José Antonio Vázquez López, Subdirector del TecNM en Celaya; maestro Teodoro Villalobos Salinas, Subdirector Administrativo; ingeniero José Salvador Sosa de Santiago, Jefe del departamento de Sistemas Computacionales e Informática; Leonardo Hernández Ojeda, representante ante el H. Consejo y Daisha Erandi García Arriaga, presidenta de la Asociación estudiantil de Ingeniería en Sistemas Computacionales.'
            ),
            buildPage(
              color: Colors.indigo, 
              title: '!Honorarios!',
              URLImage: 'assets/page2-image.jpg',
              Decription: 'Como ya es una costumbre, se realizó la entrega de reconocimientos a los alumnos que destacaron académicamente durante el semestre agosto-diciembre 2018:\nNOMBRE                                           SEMESTRE   PROMEDIO\nLuis Manuel Rodríguez Castro            3                 96.83\nBenjamín Jaramillo Nava                      5                 92.75\nJosé Manuel Montero Rodríguez        7                90.38\nEdgar Juárez Cordero                             7                93.14\nLuis Alberto Soto Mejía                         8                   92\nMoisés Ismael Reyes García                 9                 95.17\n\nDe igual forma se reconoció a los estudiantes que han destacado por su desempeño en actividades deportivas, sociales y culturales:\nPor trayectoria deportiva:\nGuillermo Peasland Aguilar, Voleibol\nJosé Eduardo Pérez Cabrera, Futbol.'
            ),
            buildPage(
              color: Colors.green, 
              title: '!Enterate de más!',
              URLImage: 'assets/page3-image.png',
              Decription: '!Ven a visitar y enterate de nuestras mas recientes noticias!'
            ),
          ],
        ),
      ),
      bottomSheet:isLastPage?
      TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          ),
          primary: Colors.white,
          backgroundColor: Colors.teal.shade700,
          minimumSize: const Size.fromHeight(60)
        ),
        child: const Text('Vamos a Comenzar',style: TextStyle(fontSize: 24),),
        onPressed:()async{
          
          _launchInBrowser(Uri.parse("https://celaya.tecnm.mx/bienvenida-de-ingenieria-en-sistemas-computacionales-hochos-y-chescos/"));
        }, 
        
      )
      : 
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('SKIP'),
              onPressed: () {
                controllerPage.previousPage(
                  duration: const Duration(microseconds: 500), 
                  curve: Curves.easeInOut
                );
              },
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controllerPage, 
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.black
                ),
                onDotClicked: ((index) {
                  controllerPage.animateToPage(
                    index, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeIn
                    );

                }),
              ),
            ),
            TextButton(
              child: const Text('NEXT'),
              onPressed: (() {
                controllerPage.nextPage(
                  duration: const Duration(microseconds: 500), 
                  curve: Curves.easeInOut
                );
              }),
            )
          ],
        ),
      ),
      
      //ThemeScreen(),
    
    );
  }
}