import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/note_ui_here/front_page.dart';
import 'package:crud_notes/services/db.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {

  TextEditingController title = new TextEditingController();

  TextEditingController content = new TextEditingController();

  var uuid = Uuid();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
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
                await NotesDatabase.instance.InsertEntry(Note(isArchieve:false,pin: false, title: title.text,uniqueId:uuid.v1(), content: content.text, createdTime: NotesImpNames.createdTime));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FrontPage()));
              },  icon: Icon(Icons.save_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: title,
                cursorColor: Colors.white,
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
              Container(
                  height: 300,
                  child: TextField(
                    controller: content,
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}