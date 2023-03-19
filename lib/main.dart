import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'todo.dart';


void main() async{

// Initialize Hive
  await Hive.initFlutter();

  // Register the Todo adapter
  Hive.registerAdapter(TodoAdapter());

  // Open the Todo box
  final box = await Hive.openBox<Todo>('todoBox');

  runApp(MyApp(box: box));


}

class MyApp extends StatefulWidget {

  final Box<Todo> box;
  MyApp({required this.box});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
              controller: _nameController,
            ),

            ElevatedButton(onPressed: () async{
              
                final todo=Todo(title: _nameController.text);
                await widget.box.add(todo);
                int index=widget.box.length-1;
                print(widget.box.getAt(index)!.title.toString());
                setState(() {
                  
                });
            

            }, child: const Text('Inset data'))
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.box.length,
                itemBuilder: (context,index){
                  return Text(widget.box.getAt(index)!.title.toString());
                }
                )
              )
            
          ],
        ),
      ),
    );;
  }
}