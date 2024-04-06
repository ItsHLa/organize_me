import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: ExpansionTile(
            shape: StadiumBorder(),
            title: Text('Task Name'),
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  child:
                      Text('Description Description Description Description')),
              Row(
                children: [
                  Spacer(),
                  IconButton(onPressed: null, icon: Icon(Icons.edit)),
                  IconButton(onPressed: null, icon: Icon(Icons.delete))
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ));
  }
}
