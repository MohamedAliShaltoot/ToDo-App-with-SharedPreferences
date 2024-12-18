import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
final SharedPreferences sharedPreferences;
SharedPreferencesService ( this.sharedPreferences ) ;

 Future<void> addTodo(String value) async {
final result = sharedPreferences.getStringList( ' items' ) ;
result?. add(value);
await sharedPreferences. setStringList(  'items', result ?? [] ) ;

 }


}
