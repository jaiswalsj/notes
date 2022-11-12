import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/services/db.dart';
import 'package:crud_notes/services/login_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireDB{
  //CREATE , READ , UPDATE ,DELETE
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewNoteFirestore(Note note)async{
    await LocalDataSaver.getSyncSet().then((isSyncOn)async {
      if(isSyncOn.toString() == "true"){

        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance.collection("notes").
        doc(currentUser!.email).collection("usernotes").
        doc(note.uniqueId).set
          ({
          "Title" : note.title,
          "content" : note.content,
          "uniqueId": note.uniqueId,
          "date" : note.createdTime,
        }).then((_) {
          print("DATA ADDED SUCCESSFULLY");
        });
      }
    });

  }


  getAllStoredNotes()async{

    final User? currentUser = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(currentUser!.email)
        .collection("usernotes")
        .orderBy("date")
        .get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {

          // print(result.data()["Title"]);
          Map note = result.data();
          NotesDatabase.instance.InsertEntry
            (Note(pin: false, isArchieve: false,uniqueId: note["uniqueId"], title: note["Title"], content: note["content"], createdTime: note["date"]));
        });
    });
  }


  updateNoteFirestore(Note note)async{
    await LocalDataSaver.getSyncSet().then((isSyncOn)async {
      if(isSyncOn.toString() == "true"){

        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance.collection("notes")
            .doc(currentUser!.email).collection("usernotes").doc(note.uniqueId.toString()).update(
            {"title": note.title.toString(),"content":note.content}).then((_){
          print("DATA ADDED SUCCESSFULLY");
        });
      }
    });

  }


  deleteNoteFirestore(Note note)async{

    await LocalDataSaver.getSyncSet().then((isSyncOn)async {
      if(isSyncOn.toString() == "true"){

        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance.collection
          ("notes").doc(currentUser!.email.toString()).collection
          ("usernotes").doc(note.uniqueId.toString()).delete().then((_)
        {
          print("DATA DELETED SUCCESSFULLY");
        });
      }
    });

  }



}