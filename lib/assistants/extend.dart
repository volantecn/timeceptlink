
extension JsonRead on Map<String, dynamic> {
  String? confirmAndRead(String key,{String failure=""}) {
    return containsKey(key)?this[key]:failure;
  }
// ···
}

extension EnumChange on List{
  Map<String,String>listToMap(){
    var re=<String,String>{};

    forEach((element) {re[element.toString()]=element.toString(); });

    return re;
  }
}

class Helper{

  static int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }

  static String hhMMAddDot(String original){

    String re=original;
    if(original.length==4){

      re="${original.substring(0,2)}:${original.substring(2)}";
    }
    return re;
  }

  static List<int>  getSubIpAddress(String address){
    List<int>pointLocations=<int>[-1];
    List<int>re=<int>[];


    for(int i=0;i<address.length;i++){
      if(address[i]=='.')pointLocations.add(i);

    }
    pointLocations.add(address.length);

    for(int j=0;j<pointLocations.length-1;j++){

      re.add(int.tryParse(address.substring(pointLocations[j]+1,pointLocations[j+1]))??0);
    }

    return re;
  }

  static String intListToHexString(List<int> origianl){
    var re="";

    for(int i=0;i<origianl.length ;i++){
      re+="-${origianl[i].toRadixString(16).padLeft(2,"0")}";
    }
    return re.substring(1);
  }
  static String intListToIPAddressFormat(List<int> origianl){
    var re="";

    for(int i=0;i<origianl.length ;i++){
      re+=".${origianl[i]}";
    }
    return re.substring(1);
  }




  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }


  static int durationMinute(int timestamp){

    int duriansec=(DateTime.now().millisecondsSinceEpoch - timestamp) ~/ 1000;
    return duriansec ~/60;

  }
  static int durationMinute2(DateTime dateTime){

    int duriansec=(DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch) ~/ 1000;
    return duriansec ~/60;

  }




}