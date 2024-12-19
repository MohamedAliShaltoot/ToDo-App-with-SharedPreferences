// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/shared_preferences.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   SharedPreferencesService? service;
//   List<Map<String, dynamic>> allTodos = [];
//   List<Map<String, dynamic>> filteredTodos = [];
//   String? lastDeletedNote;
//   int? lastDeletedNoteIndex;
//   Color? lastDeletedColor;

//   @override
//   void initState() {
//     initSharedPreferences();
//     super.initState();
//   }

//   Future<void> initSharedPreferences() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     service = SharedPreferencesService(sharedPreferences);
//     await fetchTodos();
//   }

//   Future<void> fetchTodos() async {
//     if (service != null) {
//       final todos = await service!.getTodoWithColors();
//       setState(() {
//         allTodos = todos;
//         filteredTodos = todos;
//       });
//     }
//   }

//   void showBottomSheetToAddOrUpdate(
//       {String? title, int? index, Color? selectedColor}) {
//     final controller = TextEditingController(text: title);
//     Color cardColor = selectedColor ?? Colors.white;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             left: 16,
//             right: 16,
//             top: 16,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Add or Update Note',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   hintText: 'Enter a task',
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               DropdownButton<Color>(
//                 value: cardColor,
//                 items: [
//                   Colors.white,
//                   Colors.blue,
//                   Colors.red,
//                   Colors.green,
//                   Colors.orange
//                 ]
//                     .map((color) => DropdownMenuItem(
//                           value: color,
//                           child: Container(
//                             width: 50,
//                             height: 20,
//                             color: color,
//                           ),
//                         ))
//                     .toList(),
//                 onChanged: (newColor) {
//                   setState(() {
//                     cardColor = newColor!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (controller.text.isNotEmpty) {
//                     if (index != null) {
//                       await service?.updateTodo(
//                           index, controller.text, cardColor.value);
//                     } else {
//                       await service?.addTodoWithColor(
//                           controller.text, cardColor.value);
//                     }
//                     await fetchTodos();
//                     Navigator.pop(context);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Please enter a valid task")),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void deleteNoteWithUndo(int index) {
//     lastDeletedNote = allTodos[index]['title'];
//     lastDeletedNoteIndex = index;
//     lastDeletedColor = Color(allTodos[index]['color'] ?? Colors.white.value);

//     service?.removeTodoWithColor(index);
//     fetchTodos();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Deleted: "$lastDeletedNote"'),
//         action: SnackBarAction(
//           label: 'UNDO',
//           textColor: Colors.yellow,
//           onPressed: () async {
//             if (lastDeletedNote != null && lastDeletedNoteIndex != null) {
//               await service?.addTodoWithColor(
//                   lastDeletedNote!, lastDeletedColor!.value,
//                   index: lastDeletedNoteIndex!);
//               await fetchTodos();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('My Notes'),
//         centerTitle: true,
//       ),
//       body: filteredTodos.isEmpty
//           ? const Center(
//               child: Text('No notes found', style: TextStyle(fontSize: 18)),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: filteredTodos.length,
//               itemBuilder: (context, index) {
//                 return Dismissible(
//                   key: Key(filteredTodos[index]['title']),
//                   onDismissed: (direction) {
//                     deleteNoteWithUndo(index);
//                   },
//                   child: Card(
//                     elevation: 4,
//                     color: Color(filteredTodos[index]['color']),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(
//                         filteredTodos[index]['title'],
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.black),
//                         onPressed: () {
//                           showBottomSheetToAddOrUpdate(
//                             title: filteredTodos[index]['title'],
//                             index: index,
//                             selectedColor:
//                                 Color(filteredTodos[index]['color']),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showBottomSheetToAddOrUpdate();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferencesService? service;
  List<String> allTodos = [];
  List<String> filteredTodos = [];
  String? lastDeletedNote;
  int? lastDeletedNoteIndex;

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  Future<void> initSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    service = SharedPreferencesService(sharedPreferences);
    await fetchTodos();
  }

  Future<void> fetchTodos() async {
    if (service != null) {
      final todos = await service!.getTodo();
      setState(() {
        allTodos = todos;
        filteredTodos = todos;
      });
    }
  }

  void showBottomSheetToAddOrUpdate({String? title, int? index}) {
    final controller = TextEditingController(text: title);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add or Update Note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter a task',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    if (index != null) {
                      await service?.updateTodo(index, controller.text);
                    } else {
                      await service?.addTodo(controller.text);
                    }
                    await fetchTodos();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid task")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteNoteWithUndo(int index) {
    lastDeletedNote = allTodos[index];
    lastDeletedNoteIndex = index;

    service?.removeTodo(index);
    fetchTodos();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted: "$lastDeletedNote"'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.yellow,
          onPressed: () async {
            if (lastDeletedNote != null && lastDeletedNoteIndex != null) {
              await service?.addTodo(
                  lastDeletedNote!); // Insert at the end
              await fetchTodos();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Animate(
  effects: const [
    FadeEffect(duration: Duration(seconds: 4)),
    ScaleEffect(duration: Duration(seconds: 2), ),
    RotateEffect(duration: Duration(seconds: 3),), // تأثير الدوران
  ],
  child: const Text(
    "My Notes",
    style: TextStyle(
      fontSize: 24, // حجم الخط
      fontWeight: FontWeight.bold, // سمك الخط
      color: Color.fromARGB(255, 14, 14, 15), // لون النص
    ),
  ),
),
















        centerTitle: true,
      ),
      body: filteredTodos.isEmpty
          ? const Center(
              child: Text('No notes found', style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(filteredTodos[index]),
                  onDismissed: (direction) {
                    deleteNoteWithUndo(index);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        filteredTodos[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () {
                          showBottomSheetToAddOrUpdate(
                            title: filteredTodos[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheetToAddOrUpdate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
