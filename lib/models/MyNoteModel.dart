class NotesImpNames{

  static final String id = "id";
  static final String  uniqueId= "uniqueId";
  static final String pin = "pin";
  static final String isArchieve = 'isArchieve';
  static final String title = "title";
  static final String content = "content";
  static final String createdTime = "createdTime";
  static final String TableName = "Notes";

  static final List<String> values = [id,pin,isArchieve,title,content,uniqueId,createdTime];

}


class Note {

  final int? id;
  final bool pin;
  final bool isArchieve;
  final String  title;
  final String  uniqueId;
  final String content;
  final String createdTime;

  const Note({this.id ,
  required this.pin,
    required this.isArchieve,
  required this.title,
  required this.uniqueId,
  required this.content,
  required this.createdTime,
  });

  Note copy
      ({
    int? id,
    bool? pin,
    bool? isArchieve,
    String? title,
    String? uniqueId,
    String ?content,
    String? createdTime
})  {
    return Note(
        id: id?? this.id,
        pin: pin?? this.pin,
        isArchieve: isArchieve?? this.isArchieve,
        title: title?? this.title,
        uniqueId: uniqueId?? this.uniqueId,
        content: content?? this.content,
        createdTime: createdTime?? this.createdTime
    );
  }

  static Note fromJson(Map<String, Object?>json){
    return Note(
        id: json[NotesImpNames.id] as int?,
        pin: json[NotesImpNames.pin] ==1,
        isArchieve: json[NotesImpNames.isArchieve]==1,
        title: json[NotesImpNames.title]as String,
        uniqueId: json[NotesImpNames.uniqueId]as String,
        content: json[NotesImpNames.content] as String,
        createdTime: json[NotesImpNames.createdTime] as String,

        // createdTime: String.parse(json[NotesImpNames.createdTime].toString())
    );
  }


  Map<String,Object?> toJson(){
    return{

      NotesImpNames.id :id,
      NotesImpNames.pin : pin ?1:0 ,
      NotesImpNames.isArchieve:isArchieve?1:0,
      NotesImpNames.title: title,
      NotesImpNames.uniqueId: uniqueId,
      NotesImpNames.content: content,
      NotesImpNames.createdTime: createdTime
    };
  }
}

