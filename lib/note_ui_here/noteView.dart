import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/note_ui_here/editNoteView.dart';
import 'package:crud_notes/note_ui_here/front_page.dart';
import 'package:crud_notes/services/db.dart';
import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: ()async{
                await NotesDatabase.instance.pinNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FrontPage()));
              },
          icon: Icon(widget.note.pin?Icons.push_pin:Icons.push_pin_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: ()async{
                await NotesDatabase.instance.archNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FrontPage()));
              },
              icon: Icon(widget.note.isArchieve?Icons.archive:Icons.archive_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNoteView(note: widget.note,)));
              },
              icon: Icon(Icons.edit_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: ()async{
                await NotesDatabase.instance.deleteNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FrontPage()));
              },
              icon: Icon(Icons.delete_forever_outlined))
        ],
      ),


      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.note.title,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(widget.note.content,style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),


    );
  }
}
