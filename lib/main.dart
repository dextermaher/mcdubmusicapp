/*The import Statements import different packages,
*which add different functionalities to this file */
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:audioplayers/audio_cache.dart';

/*Nothing here changes the ways that you can interact with the app.
* what it does is make sure everything is set up and displayed properly
* It also makes sure that the background color is correct and everything is
* titled appropriately*/
void main() => runApp(McMusic());

class McMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MC Dub Music',
      theme: ThemeData(
        canvasColor: Color(0xFF1A1A1B),
      ),
      home: MainDisplay(),
      //home: HomeScreen(),
    );
  }
}
