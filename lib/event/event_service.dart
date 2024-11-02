import 'event_model.dart';
import 'package:localstore/localstore.dart';
class EventService {
  final db = Localstore.getInstance(useSupportDir: true);
  //Tên collection trong localstore(giống như tên bảng)
  final path = 'events';
  // Hàm lấy danh sách sự kiện từ localstore
  Future<List<EventModel>>getAllEvents() async{
    final eventsMap = await db.collection(path).get();
    if(eventsMap != null){
      return eventsMap.entries.map((entry){
        final eventData = entry.value as Map<String,dynamic>;
        if(!eventData.containsKey('id')){
          eventData['id'] = entry.key.split('/').last;
        }
        return EventModel.fromMap(eventData);
      }).toList();
    } 
    return[];
  }
  // Hàm lưu một sự kiện vào localstore
}