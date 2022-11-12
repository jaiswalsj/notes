import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/Side_menu_bar.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/note_ui_here/createNoteView.dart';
import 'package:crud_notes/note_ui_here/noteView.dart';
import 'package:crud_notes/services/db.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'Search_Page.dart';

class ArchiveView extends StatefulWidget {

// Note note;
//  ArchiveView({required this.note});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}


class _ArchiveViewState extends State<ArchiveView> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late List<Note> noteList;
  bool isLoading = true;

  String note = "THIS IS A NOTE THIS IS A NOTE  THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE ";

  String note1 = "THIS IS A NOTE THIS IS A NOTE THIS IS A NOTE ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
  }
  Future getAllNotes()async{
    this.noteList = await NotesDatabase.instance.readAllArchNotes();
    if(this.mounted){
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Scaffold( backgroundColor:bgColor,body: Center(child: CircularProgressIndicator(color: Colors.white,),),): Scaffold(

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
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
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

                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 13),
                      //   child: Row(
                      //     children: [
                      //       TextButton(
                      //           style: ButtonStyle(
                      //               overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.1)),
                      //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //                   RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(50.0)
                      //                   )
                      //               )
                      //           ),
                      //           onPressed: (){}, child: Icon(Icons.grid_view,color: Colors.white,)),
                      //
                      //       SizedBox(width: 9,),
                      //
                      //       CircleAvatar(
                      //         backgroundColor: Colors.white,
                      //         radius: 16,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),

                NoteSectionAll(),
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
                itemBuilder: (context,index)=> InkWell(
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
                        Text(noteList[index].title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
          SizedBox(height: 60,)
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
                Text("LIST VIEW",style: TextStyle(
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

                itemCount: 10,


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
                      Text("HEADING",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(index.isEven ?note.length> 200?"${note.substring(0,200)}...":note :note1,
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
