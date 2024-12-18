import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_preferences.dart';

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
// TO[X): implement initState
    super.initState();
  }

  initSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    service = SharedPreferencesService(sharedPreferences);
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
                  color: Color.fromARGB(255, 3, 172, 40),
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
        child: Column(
          children: [
            Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10),
               border: Border.all(
                 width: 1.0,
                 color: const Color.fromARGB(255, 5, 27, 105),
               ),
             ),
             margin: const EdgeInsets.only(
               top: 10,
               left: 20,
               right:20,
               bottom: 10
             ),
             height: 60,
             child: Row(
               children: [
            Expanded(child: Row(
              children: [
              const SizedBox(
               
                width: 10,),
                const Icon(Icons.check_circle_outline,color: Colors.blue,size: 20,),
            
                const SizedBox(
               
                width: 10,),
                const Expanded(child: Text('go to gym',overflow: TextOverflow.ellipsis,),
                ),
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: (){
              
                },
                child:Icon(Icons.delete,color: Colors.red,) ,
              
              ),
            ),
            
              
              
            ]),),
               
             ]),
             ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
