// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService{
// final SharedPreferences sharedPreferences;
// SharedPreferencesService ( this.sharedPreferences ) ;

//  Future<void> addTodo(String value) async {
// final result = sharedPreferences.getStringList('Items') ;
// result?.add(value);
// await sharedPreferences.setStringList('Items', result ?? [] ) ;
// print(" set todo");

//  }


// Future<List<String>> getTodo() async {
//   print(" get todo");
//   return sharedPreferences.getStringList('Items') ?? [] ;
//  }



// }

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesService(this.sharedPreferences);

  Future<void> addTodo(String value) async {
    // Get the current list of items
    final result = sharedPreferences.getStringList('Items') ?? [];
    
    // Add the new value to the list
    result.add(value);
    
    // Save the updated list back to SharedPreferences
    await sharedPreferences.setStringList('Items', result);
    
    print("Added todo: $value");
  }

  Future<List<String>> getTodo() async {
    print("Getting todos");
    return sharedPreferences.getStringList('Items') ?? [];
  }


 Future<void> removeTodo(int index) async {
    final result = sharedPreferences.getStringList('Items') ;
result?.removeAt(index);
await sharedPreferences.setStringList('Items', result ?? [] ) ;
    
  }







  
}
