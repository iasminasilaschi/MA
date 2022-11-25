import 'package:flutter/material.dart';

import 'home_page.dart';

class ModifyGem extends StatefulWidget {
  final Gem _gem;

  const ModifyGem(this._gem, {super.key});

  @override
  State<StatefulWidget> createState() => _ModifyGem();
}

class _ModifyGem extends State<ModifyGem> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescription;
  late TextEditingController controllerColor;
  late TextEditingController controllerHardness;
  late TextEditingController controllerBirthstone;

  @override
  void initState() {
    Gem a = widget._gem;
    controllerName = TextEditingController(text: a.name);
    controllerDescription = TextEditingController(text: a.description);
    controllerColor = TextEditingController(text: a.color);
    controllerHardness = TextEditingController(text: a.hardness.toString());
    controllerBirthstone = TextEditingController(text: a.birthstone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Gem"),
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
                    String color = controllerColor.text;
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
                  child: const Text("Save Gem")),
            ],
          ),
        ));
  }
}
