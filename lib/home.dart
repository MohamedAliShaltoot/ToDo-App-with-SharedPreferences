// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:my_shared_preferences_example/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todo/add_todo_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final saerchBarTec = TextEditingController();

  SharedPreferencesService? service;
  @override
  void initState() {
    initSharedPreferences();
// TO[X): implement initState
    super.initState();
    
  }

  initSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    service = SharedPreferencesService(sharedPreferences);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.0,
              color: const Color.fromARGB(255, 5, 27, 105),
            ),
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  size: 22,
                  color: Color.fromARGB(255, 5, 27, 105),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: saerchBarTec,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 130, 133, 131),
                      fontSize: 16.0,
                    ),
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 0, bottom: 2.0),
                    filled: true,
                    isDense: true,
                    fillColor: Colors.transparent,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: service?.getTodo(), 
          builder: (context, snapshot) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return   Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.0,
                    color: const Color.fromARGB(255, 5, 27, 105),
                  ),
                ),
                margin: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                height: 60,
                child: Row(children: [
                  Expanded(
                    child: Row(
                      
                      children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Expanded(
                        child: Text(
                          snapshot.data?[index]?? " jjjjjjjjjj",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              
                            });
                            service?.removeTodo(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Note Deleted"))
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),
              );
                  
          },

          );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
        await  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddToDoScreen()));
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
