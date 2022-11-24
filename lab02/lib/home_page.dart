import 'package:flutter/material.dart';

import 'modify_gem.dart';
import 'register_gem.dart';

class HomePage extends StatefulWidget {
  final String _title;

  HomePage(this._title);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Gem> gems = [
    Gem(
        id: 0,
        name: 'Amethyst',
        description: 'pretty',
        color: 'violet',
        hardness: 7,
        birthstone: 'may'),
    Gem(
        id: 0,
        name: 'Tiger\'s Eye',
        description: 'amazing',
        color: 'brown',
        hardness: 6,
        birthstone: 'october'),
    Gem(
        id: 0,
        name: 'Ruby',
        description: 'lovely',
        color: 'red',
        hardness: 8,
        birthstone: 'september'),
    Gem(
        id: 0,
        name: 'Moonstone',
        description: 'majestic',
        color: 'white',
        hardness: 5,
        birthstone: 'july'),
    Gem(
        id: 0,
        name: 'Diamond',
        description: 'refined',
        color: 'blue',
        hardness: 10,
        birthstone: 'june'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Color.fromRGBO(255, 204, 229, 296),
            ],
          )),
          child: ListView.builder(
            itemCount: gems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(left: 3, right: 3, top: 10),
                  child: ListTile(
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ModifyGem(gems[index])))
                          .then((newContact) {
                        if (newContact != null) {
                          setState(() {
                            gems.removeAt(index);
                            newContact.id = index;
                            gems.insert(index, newContact);

                            messageResponse(context,
                                newContact.name + " Has been modified...!");
                          });
                        }
                      });
                    },
                    onLongPress: () {
                      removeGem(context, gems[index]);
                    },
                    title: Text(gems[index].name),
                    subtitle: Text(gems[index].description),
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink[100],
                      child: Text(gems[index].name.substring(0, 1),
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterGem()))
              .then((newGem) {
            if (newGem != null) {
              setState(() {
                gems.add(newGem);
                messageResponse(context, newGem.name + " was added...!");
              });
            }
          });
        },
        tooltip: "Add Gem",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeGem(BuildContext context, Gem gem) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Delete Gem"),
              content:
                  Text("Are you sure you want to delete " + gem.name + "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      gems.remove(gem);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}

class Gem {
  var id;
  var name;
  var description;
  var color;
  var hardness;
  var birthstone;

  Gem(
      {this.id,
      this.name,
      this.description,
      this.color,
      this.hardness,
      this.birthstone});
}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Update Message...!"),
            content: Text("Gem $name"),
          ));
}
