import 'package:crud_notes/note_ui_here/colors.dart';
import 'package:crud_notes/services/login_info.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late bool value ;
  getSyncSet()async{
     await LocalDataSaver.getSyncSet().then((valueFromDb) {
      setState(() {
        value = valueFromDb!;
      });
    });
  }

  @override
  void initState() {
    getSyncSet();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text("Sync",style: TextStyle(fontSize: 18,color: Colors.white),),
                Spacer(),
                Transform.scale(scale: 1.2,
                  child: Switch.adaptive(value: value, onChanged: (switchValue){
                  setState(() {
                    this.value = switchValue;
                    LocalDataSaver.saveSyncSet(switchValue);
                  });
                  }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
