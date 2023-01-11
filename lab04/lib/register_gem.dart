import 'package:flutter/material.dart';

import 'home_page.dart';

class RegisterGem extends StatefulWidget {
  const RegisterGem({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterGem();
}

class _RegisterGem extends State<RegisterGem> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescription;
  late TextEditingController controllerColor;
  late TextEditingController controllerHardness;
  late TextEditingController controllerBirthstone;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerDescription = TextEditingController();
    controllerColor = TextEditingController();
    controllerHardness = TextEditingController();
    controllerBirthstone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Gem"),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Color.fromRGBO(255, 204, 229, 296),
              ],
            )),
            child: ListView(
              children: [
                Text("Name"),
                TextField(controller: controllerName),
                Text("Description"),
                TextField(controller: controllerDescription),
                Text("Color"),
                TextField(controller: controllerColor),
                Text("Hardness"),
                TextField(controller: controllerHardness),
                Text("Birthstone"),
                TextField(controller: controllerBirthstone),
                ElevatedButton(
                    onPressed: () {
                      String name = controllerName.text;
                      String description = controllerDescription.text;
                      String color = controllerBirthstone.text;
                      String hardness = controllerHardness.text;
                      String birthstone = controllerBirthstone.text;

                      if (name.isNotEmpty &&
                          description.isNotEmpty &&
                          color.isNotEmpty &&
                          hardness.isNotEmpty &&
                          birthstone.isNotEmpty) {
                        Navigator.pop(
                            context,
                            Gem(
                                name: name,
                                description: description,
                                color: color,
                                hardness: int.parse(hardness),
                                birthstone: birthstone));
                      }
                    },
                    child: const Text("Add Gem")),
              ],
            )));
  }
}
