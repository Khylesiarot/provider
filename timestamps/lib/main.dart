import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
      MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ));
}

@immutable
class BaseObject {
  final String id;
  final String lastUpdated;

  BaseObject()
    : id = const Uuid().v4(), 
    lastUpdated = DateTime.now().toIso8601String();

  @override
  bool operator ==(covariant BaseObject other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  
}

@immutable
class ExpensiveObject extends BaseObject
 {
  
}
@immutable
class CheapsObject extends BaseObject
 {
  
}

class ObjectProvider extends ChangeNotifier{
  late String id;
  late CheapsObject _cheapsObject;
  late StreamSubscription _cheapObjectStreamSubs;
  late ExpensiveObject _expensiveObject;
  late StreamSubscription _expensiveObjectStreamSubs;

  CheapsObject get cheapObject => _cheapsObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  void start(){
    _cheapObjectStreamSubs = Stream.periodic(const Duration(seconds: 1),).listen((_) {
      _cheapsObject =CheapsObject();
      notifyListeners();
     });

     _expensiveObjectStreamSubs = Stream.periodic(const Duration(seconds: 1),).listen((_) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
     });

     void stop(){
      _cheapObjectStreamSubs.cancel();
      _expensiveObjectStreamSubs.cancel();
     }
  }

}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true,),
);
  }
}