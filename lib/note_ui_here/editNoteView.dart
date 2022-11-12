import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/note_ui_here/noteView.dart';
import 'package:crud_notes/services/db.dart';
import 'package:flutter/material.dart';

class EditNoteView extends StatefulWidget {
  Note note;
   EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}


class _EditNoteViewState extends State<EditNoteView> {

  late String NewTitle ;
  late String NewNoteDet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDet = widget.note.content.toString();
  }
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
                Note newNote = Note(isArchieve:widget.note.isArchieve,pin: widget.note.pin,uniqueId: widget.note.uniqueId, title: NewTitle, content: NewNoteDet, createdTime: widget.note.createdTime,id: widget.note.id);
                await NotesDatabase.instance.updateNote(newNote);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NoteView(note: newNote)));
              },  icon: Icon(Icons.save_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              Form(
                child: TextFormField(
                  initialValue: NewTitle,
                  cursorColor: Colors.white,
              onChanged: (value){
                    NewTitle = value;
        },
                  style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8)
                    )
                  ),
                ),
              ),
              Container(
                height: 300,
                  child: Form(
                    child: TextFormField(
                      onChanged: (value){
                        NewNoteDet = value;
                      },
                      initialValue: NewNoteDet,

                      keyboardType: TextInputType.multiline,
                      minLines: 50,
                      maxLines: null,
                      cursorColor: Colors.white,
                      style: TextStyle(fontSize: 17,color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "note",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8)
                        )
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
