import 'package:appfastandfurious/fast_and_furious_model.dart';
import 'package:flutter/material.dart';

class AddFastAndFuriousCharacterFormPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AddFastAndFuriousCharacterFormPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _AddFastAndFuriousCharacterFormPageState createState() => _AddFastAndFuriousCharacterFormPageState();
}

class _AddFastAndFuriousCharacterFormPageState
    extends State<AddFastAndFuriousCharacterFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the Fast And Furious character name'),
      ));
    } else {
      var newFastAndFuriousCharacter = FastAndFuriousCharacter(nameController.text);
      Navigator.of(context).pop(newFastAndFuriousCharacter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a New Fast And Furious Character',
          style: TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 204, 128),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  onChanged: (v) => nameController.text = v,
                  decoration: InputDecoration(
                    labelText: 'Fast And Furious Character Name',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    ),
                    child: const Text('Submit Fast And Furious Character'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
