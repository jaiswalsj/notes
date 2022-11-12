import 'package:crud_notes/login.dart';
import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/Search_Page.dart';
import 'package:crud_notes/note_ui_here/Side_menu_bar.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/note_ui_here/createNoteView.dart';
import 'package:crud_notes/note_ui_here/noteView.dart';
import 'package:crud_notes/services/auth.dart';
import 'package:crud_notes/services/db.dart';
import 'package:crud_notes/services/login_info.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';


class FrontPage extends StatefulWidget {
  @override
  State<FrontPage> createState() => _FrontPageState();
}


class _FrontPageState extends State<FrontPage> {

  bool isLoading = true;
  late List<Note> noteList;
  late String? ImgUrl;
  bool isStaggered = true;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String note = "THIS IS A NOTE THIS IS A NOTE  THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE ";

  String note1 = "THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalDataSaver.saveSyncSet(false);
     getAllNotes();
  }




  // Future createEntry()async{
  //   await NotesDatabase.instance.InsertEntry();
  // }

  Future createEntry(Note note)async{
    await NotesDatabase.instance.InsertEntry(note);
  }

  // Future<String?> getAllNotes ()async{
  //   await NotesDatabase.instance.readAllNotes();
  // }

  Future<String?> getAllNotes ()async{

    LocalDataSaver.getImage().then((value) {
      if(this.mounted){
        setState(() {
          ImgUrl = value;
        });
      }
    });
    this.noteList = await NotesDatabase.instance.readAllNotes();
    if(this.mounted){
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<String?>getOneNotes () async{
  //   await NotesDatabase.instance.readOneNote(13);
  // }

  Future getOneNotes (int id) async{
    await NotesDatabase.instance.readOneNote(id);
  }

  // Future updateOneNotes() async {
  //   await NotesDatabase.instance.updateNote(233);
  // }

  Future updateOneNotes(Note note) async {
    await NotesDatabase.instance.updateNote(note);
  }

  // Future deleteOneNotes() async {
  //   await NotesDatabase.instance.deleteNote(238);
  // }

  Future deleteOneNotes(Note note) async {
    await NotesDatabase.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Scaffold( backgroundColor:bgColor,body: Center(child: CircularProgressIndicator(color: Colors.white,),),):Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNoteView()));
        },
        backgroundColor: cardColor,
        child: Icon(Icons.add,size: 45,),
      ),
      endDrawerEnableOpenDragGesture: true,
      key: _drawerKey,
      drawer: SideMenu(),
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.7),spreadRadius: 2,blurRadius: 3)],
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            _drawerKey.currentState!.openDrawer();
                          }, icon: Icon(Icons.menu,color: Colors.white,)),

                          GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchView()));
                          },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width/3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Search your Notes",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.5)),),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 13),
                        child: Row(
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.1)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0)
                                    )
                                  )
                                ),
                                onPressed: (){
                                  setState(() {
                                    isStaggered = !isStaggered;
                                  });
                                }, child: Icon(Icons.grid_view,color: Colors.white,)),

                            SizedBox(width: 9,),

                            GestureDetector(
                              onTap: (){
                                signOut();
                                LocalDataSaver.saveLoginData(false);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                              },
                              child : CircleAvatar(
                                onBackgroundImageError: (Object,StackTrace){
                                  print("OK");
                                },
                                radius: 16,
                                backgroundImage: NetworkImage(ImgUrl.toString()),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

            isStaggered? NoteSectionAll():
             NoteListSection(),

              ],
            ),
          ),
        ),

       ),
    );
  }

  Widget NoteSectionAll(){
    return    Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("All",style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 13),),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            height: MediaQuery.of(context).size.height,
            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: noteList.length,
                crossAxisCount: 4,
                staggeredTileBuilder: (index)=> StaggeredTile.fit(2),
                itemBuilder: (context,index)=>
                    InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteView(note: noteList[index],)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: white.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(noteList[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(noteList[index].content.length> 200
                            ?"${noteList[index].content.substring(0,200)}..."
                            :noteList[index].content,

                          style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                )),

          ),
            SizedBox(height: 100,)
        ],
      ),
    );
  }

  Widget NoteListSection(){
    return    Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("ALL",style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 13),),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: noteList.length,


                itemBuilder: (context,index)=> Container(

                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(noteList[index].title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(noteList[index].content.length> 200
                          ?"${noteList[index].content.substring(0,200)}..."
                          :noteList[index].content,

                        style: TextStyle(color: Colors.white),)
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

}
