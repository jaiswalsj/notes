import 'package:crud_notes/models/MyNoteModel.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/services/db.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'noteView.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  List<int>SearchResultIds = [];
  List<Note?> SearchResultNotes = [];

  bool isLoading = false;
  void SearchResults(String query) async{
    SearchResultNotes.clear();
    setState(() {
      isLoading = true;
    });

    final ResultIds = await NotesDatabase.instance.getNoteString(query);

    List<Note?>SearchResultNotesLocal = [];

    ResultIds.forEach((element) async{

      final SearchNote = await NotesDatabase.instance.readOneNote(element);
      SearchResultNotesLocal.add(SearchNote);
      setState(() {

        SearchResultNotes.add(SearchNote);
      });
    });

    setState(() {
      isLoading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.arrow_back_outlined,color: Colors.white,)),

                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,

                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search Your Note",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.5),

                          ),

                        ),
                        onSubmitted: (value){
                          setState(() {
                            SearchResults(value.toLowerCase());
                          });
                        },
                      ),
                    ),
                  ],
                ),
                isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),): NoteSectionAll()
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
                Text("Search Result",style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),

            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: SearchResultNotes.length,
                crossAxisCount: 4,
                staggeredTileBuilder: (index)=> StaggeredTile.fit(2),
                itemBuilder: (context,index)=>
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteView(note: SearchResultNotes[index]!)));
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
                            Text(SearchResultNotes[index]!.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(SearchResultNotes[index]!.content.length> 200
                                ?"${SearchResultNotes[index]!.content.substring(0,200)}..."
                                :SearchResultNotes[index]!.content,

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
}
