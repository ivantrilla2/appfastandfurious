import 'package:flutter/material.dart';
import 'dart:async';
import 'fast_and_furious_model.dart';
import 'fast_and_furious_list.dart';
import 'new_fast_and_furious_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My fav Fast And Furious Characters',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.deepPurple,),
      home: const MyHomePage(
        title: 'My fav Fast And Furious Characters',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FastAndFuriousCharacter> initialFastAndFuriousCharacters = [FastAndFuriousCharacter('Dominic'), FastAndFuriousCharacter('Jakob'), FastAndFuriousCharacter('Letty')];

  Future _showNewFastAndFuriousCharacterForm() async {
    FastAndFuriousCharacter newFastAndFuriousCharacter = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddFastAndFuriousCharacterFormPage();
    }));
    //print(newFastAndFuriousCharacter);
    initialFastAndFuriousCharacters.add(newFastAndFuriousCharacter);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0), 
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: _showNewFastAndFuriousCharacterForm,
            ),
          )
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 255, 204, 128),
          child: Center(
            child: FastAndFuriousCharacterList(initialFastAndFuriousCharacters),
          )),
    );
  }
}