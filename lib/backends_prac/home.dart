import 'package:crud_notes/backends_prac/db_helper.dart';
import 'package:crud_notes/backends_prac/notes.dart';
import 'package:flutter/material.dart';

class BaseHere extends StatefulWidget {
  @override
  State<BaseHere> createState() => _BaseHereState();
}

class _BaseHereState extends State<BaseHere> {
  DBHelper? dbHelper;

  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Sql"),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: notesList,
              builder: (context,AsyncSnapshot<List<NotesModel>> snapshot) {
                if(snapshot.hasData){}
                else{

                  return CircularProgressIndicator();
                }

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 2),
                  child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context,int index) {
                        //dismissible function is used for delete the data in the database
                        return InkWell(
                          onTap: (){
                            dbHelper!.update(
                                NotesModel(
                                    id:snapshot.data![index].id!,
                                    title: 'First Flutter note',
                                    age: 11,
                                    description: 'Let me talk to you tommorrow',
                                    email: 'srejhrfjdh'
                                )
                            );
                            setState(() {
                              notesList = dbHelper!.getNotesList();
                            });
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(Icons.delete_forever),
                            ),
                            onDismissed: (DismissDirection direction){
                              setState(() {
                                dbHelper!.delete(snapshot.data![index].id!);
                                notesList = dbHelper!.getNotesList();
                                snapshot.data!.remove(snapshot.data![index]);

                              });
                            },
                            key: ValueKey<int>(snapshot.data![index].id!),


                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                      color: Colors.blueAccent.shade100,
                                      blurRadius: 10
                                  )]
                              ),
                              child: Card(
                                  child: ListTile(
                                    title: Text(snapshot.data![index].title.toString()),
                                    subtitle: Text(
                                        snapshot.data![index].description.toString()),
                                    trailing: Text(snapshot.data![index].age.toString()),
                                  )),
                            ),
                          ),
                        );
                      }),
                );
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          dbHelper!.insert(
              NotesModel(
                  title: 'New unerrased note',
                  age: 18,
                  description: 'DANDELIONS',
                  email: "saish297@allthetime.com"))
              .then((value) {
            print('data added');
            setState(() {
              notesList = dbHelper!.getNotesList();
            });
          }).onError((error, stackTrace) {
            print(error.toString());
          });
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
