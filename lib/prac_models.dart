import 'dart:math';

class NotesVarNames{

  static final String id = 'id';
  static final String pin = 'pin';
  static final String title = 'title';
  static final String content = 'content';
  static final String createdTime = 'createdTime';
  static final String TableName = 'Notes';
  static final List<String> values = [id,pin,title,content,createdTime];
}

class NotesLine{
        final int? id;
        final bool pin;
        final String title;
        final String content;
        final DateTime createdTime;

        const NotesLine({
          this.id,
          required this.pin,
          required this.title,
          required this.content,
          required this.createdTime
});
        NotesLine copy({
          int? id,
          bool ?pin,
          String ?title,
          String ?content,
          DateTime? createdTime,
}){return NotesLine(
            id: id??this.id,
            pin: pin?? this.pin,
            title: title ?? this.title,
            content: content?? this.content,
            createdTime: createdTime??this.createdTime);
        }


        static NotesLine fromJson(Map<String, Object?>json){
          return NotesLine(
              id: json[NotesVarNames.id]as int,
              pin: json[NotesVarNames.pin]==1,
              title: json[NotesVarNames.title]as String,
              content: json[NotesVarNames.content]as String,
              createdTime: DateTime.parse(json[NotesVarNames.createdTime]as String)
          );
        }
        Map<String,Object?> toJson(){
          return{
            NotesVarNames.id :id,
            NotesVarNames.pin:pin?1:0,
            NotesVarNames.title:title,
            NotesVarNames.content:content,
            NotesVarNames.createdTime:createdTime.toIso8601String()
          };
        }

}