import 'package:crud_notes/note_ui_here/Setting.dart';
import 'package:crud_notes/note_ui_here/archiveView.dart';
import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:flutter/material.dart';


class SideMenu extends StatefulWidget {

  @override
  State<SideMenu> createState() => _SideMenuState();
}
// late List<Note>noteList=[];

class _SideMenuState extends State<SideMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child:Container(
        decoration: BoxDecoration(
          color: bgColor
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 16),
                  child: Text(
                    "Google Keep",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  )),
                Divider(color: Colors.white.withOpacity(0.3),),
              SizedBox(height: 10,),
              sectionOne(),
              SizedBox(height: 8,),
              sectionTwo(context),
              SizedBox(height: 8,),
              sectionSetting(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget sectionOne(){
  return Container(
    margin: EdgeInsets.only(right: 10),

    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50)

          )
          // borderRadius: BorderRadius.circular(50)
        ))
      ),
      onPressed: (){},
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(Icons.lightbulb,size: 25,
            color: Colors.white.withOpacity(0.7),),
            SizedBox(width: 15,),
            Text("Notes",
              style: TextStyle(
                  color: white.withOpacity(0.7), fontSize: 18),)
          ],
        ),
      ),
    ),
  );
}



Widget sectionTwo(BuildContext context){
  return Container(
    margin: EdgeInsets.only(right: 10),

    child: TextButton(

      onPressed: (){

       Navigator.push(context, MaterialPageRoute(builder: (context)=> ArchiveView()));
      },
      child: Container(

        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(Icons.archive_outlined,size: 25,
              color: Colors.white.withOpacity(0.7),),
            SizedBox(width: 15,),
            Text("Archived",
              style: TextStyle(
                  color: white.withOpacity(0.7), fontSize: 18),)
          ],
        ),
      ),
    ),
  );
}


Widget sectionSetting(BuildContext context){
  return Container(
    margin: EdgeInsets.only(right: 10),

    child: TextButton(

      onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
      },

      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(Icons.settings,size: 25,
              color: Colors.white.withOpacity(0.7),),
            SizedBox(width: 15,),
            Text("Setting",
              style: TextStyle(
                  color: white.withOpacity(0.7), fontSize: 18),)
          ],
        ),
      ),
    ),
  );
}

