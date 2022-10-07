import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  
  var contador=1;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stateless vs Stateful',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(
          'Contador $contador', 
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador=contador*2;
          print(contador);
          setState(() {
            
          });
        },
        child: Icon(
          Icons.ads_click,
          color: Colors.black,
        ),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    
    );
  }
}