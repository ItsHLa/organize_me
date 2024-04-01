import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        alignment: Alignment.center,
        child:const Column(

          children: [
            Row(
              children: [Spacer(),
              IconButton(onPressed: null, icon: Icon(
                Icons.nightlight_outlined
              ))],
            ),
            // photo
            SizedBox(height: 15,),
            Text('اهلا بك' , style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('كل امورك المهمة في مكان واحد ' , style: TextStyle(fontWeight: FontWeight.normal),)
            ,SizedBox(height: 5,),
            ElevatedButton(onPressed: null, child: Text('البدء'))


          ],
        ),
      ),
    );
  }
}
