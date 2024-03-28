import 'package:flutter/material.dart';
import 'package:organize_me/notes_section/widget/search_widget.dart';
import '../widget/note_list_view.dart';
import 'note_task.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

   Widget myWidget = const Spacer();
   Icon myIcon = const Icon(Icons.search_outlined);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddTaskScrn();
              });
        },
        shape: const StadiumBorder(),
        child: const Icon(Icons.add_task),
      ),
      body:  Column(
        children: [
          Row(
            children: [
              myWidget,
              IconButton(onPressed: (){
                setState(() {
                  if( myIcon == const Icon(Icons.search_outlined)){
                    myIcon =  const Icon(Icons.cancel_outlined);
                    myWidget = const MySearchWidget();

                  }else{
                    myWidget = const Spacer();
                    myIcon =  const Icon(Icons.search_outlined);
                  }
                });
               }
               , icon: myIcon)
            ],
          ),
          Expanded(child: TaskListView()),
        ],
      ),
    );
  }
}
