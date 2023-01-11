import 'package:flutter/material.dart';

import 'database.dart';
import 'modify_gem.dart';
import 'register_gem.dart';

class HomePage extends StatefulWidget {
  final String _title;

  HomePage(this._title);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Gem>>(
            future: DatabaseHelper.instance.getGems(),
            builder: (BuildContext context, AsyncSnapshot<List<Gem>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Gems in List.'))
                  : Center(
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    EdgeInsets.only(left: 3, right: 3, top: 10),
                                child: ListTile(
                                  textColor: Colors.white,
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ModifyGem(
                                                    snapshot.data![index])))
                                        .then((newGem) {
                                      if (newGem != null) {
                                        setState(() {
                                          DatabaseHelper.instance
                                              .update(newGem);

                                          messageResponse(
                                              context,
                                              newGem.name +
                                                  " Has been modified...!");
                                        });
                                      }
                                    });
                                  },
                                  onLongPress: () {
                                    removeGem(context, snapshot.data![index]);
                                  },
                                  title: Text(snapshot.data![index].name),
                                  subtitle:
                                      Text(snapshot.data![index].description),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.pink[100],
                                    child: Text(
                                        snapshot.data![index].name
                                            .substring(0, 1),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ));
                          },
                        ),
                      ),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterGem()))
              .then((newGem) {
            if (newGem != null) {
              DatabaseHelper.instance.add(newGem);
              messageResponse(context, newGem.name + " was added...!");
              setState(() {});
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
                      try {
                        DatabaseHelper.instance.remove(gem.id!);
                      } on Exception catch (_) {
                        rethrow;
                      }
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

  factory Gem.fromMap(Map<String, dynamic> json) => Gem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        color: json['color'],
        hardness: json['hardness'],
        birthstone: json['birthstone'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'hardness': hardness,
      'birthstone': birthstone
    };
  }
}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Update Message...!"),
            content: Text("Gem $name"),
          ));
}
