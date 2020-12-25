/*The import Statements import different packages,
*which add different functionalities to this file */
import 'package:flutter/material.dart';
import 'manage_music.dart';

/*In Dart/Flutter, everything that draws on the screen or influences
* the way things look is called a widget. For example, when this
* class says extends StatelessWidget, it is getting attributes from
* its parent class StatelessWidget. The Stateless part means that
* you can not call setState({}). This distinction will be important later*/
class MusicDisplay extends StatelessWidget {
  /*This class takes on all attributes from the parent class,
  * so to not have some of the functionality from statelessWidget
  * we use @override to tell our class to do something that StatelessWidget
  * would not do.*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

/*This line creates a new variable called manageMusic.
* Similar to how variables can be set to int or double or String,
* manageMusic is a ManageMusic type variable. we set it equal to the class
* ManageMusic from our manage_music file.*/
ManageMusic manageMusic = ManageMusic();

/*This class extends StatefulWidget, which means that it has a state.
* A state is useful because everytime a variable inside a state is updated
* the build function is called and the app is redrawn*/
class MainDisplay extends StatefulWidget {
  @override
  _MainDisplayState createState() => _MainDisplayState();
}

/*everything in this class is part of the state. that's why it extends
* the State of MainDisplay. The only other important piece of information here
* is the underscore before the name MainDisplayState.  This tells the app that
* everything inside here is local. This means that no outside classes would
* be able to reach in and use one of this class's functions.*/
class _MainDisplayState extends State<MainDisplay> {
  /*These are the variables with generic starting values that will be
  * updated later.*/
  double volumeValue = 1.0;
  double locationValue = 0.0;
  double lengthOfSong = 0.0;
  double currentPosition = 0.0;
  double currentPositionInSeconds = 0.0;
  double currentPositionInDisplayableSeconds = 0.0;
  double currentPositionInMinutes = 0.0;
  int currentPositionInInt = 0;
  Color buttonColor = Color(0xFF1A1A1B);

  /*This widget is a Divider widget that I have taken out of my build function
  * and externalised. The reason for doing this is that all the lines on the screen
  * are the same height and color. I want the driest code I can get easily,
  * so I can now call divide() in my build instead of creating a new widget
  * everytime.*/
  Divider divide() {
    return Divider(
      height: 4.0,
      color: Colors.grey[800],
    );
  }

  /*This function updates the value for our current position variable everytime
  * it is called. Since it is a state variable, everytime it is updated build
  * is called and the app is redrawn.*/
  void handlePositionChange() {
    setState(() {
      currentPosition = onPositionChange();
    });
  }

  /*This function looks very complicated at first, but really it is just a 
  * lot of conversions. First, we add a listener that listens for everytime 
  * onAudioPositionChanged updates. The reason that it is in this class
  * instead of ManageMusic is that setState needs to be called to 
  * constantly update the slider widget to show the music's progression
  * in real time. All of the conversions are needed to convert the current
  * position from a Duration variable to a double, which is the only
  * value type that the slider widget can take in. This function also
  * returns the value as a double because that is what is most often used
  * in this program.*/
  double onPositionChange() {
    manageMusic.audioPlayer.onAudioPositionChanged.listen((Duration player) {
      setState(() {
        currentPositionInInt = player.inSeconds;
        currentPositionInMinutes = player.inMinutes.toDouble();

        currentPositionInSeconds = currentPositionInInt.toDouble();
        currentPositionInDisplayableSeconds =
            currentPositionInSeconds - currentPositionInMinutes * 60;
      });
      return currentPositionInInt.toDouble();
    });
    return currentPositionInInt.toDouble();
  }

  /*This is the long awaited build widget. everything after the return is
  * drawn on the screen everytime this function is called.*/
  @override
  Widget build(BuildContext context) {
    manageMusic.convertDuration();
    handlePositionChange();
    onPositionChange();
    return Scaffold(
      /*The Column widget is used to position everything in a column. 
      * I used it so that all of the songs would display on top of eachother
      * the CrossAxisAlignment.stretch is used to stretch the children out 
      * across the screen if it does not have a specified width. This causes
      * the dividers and sliders to reach across the screen to fill up space.*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /*This widget is used as padding to add space between the widgets
      * and the top of the screen.*/
          SizedBox(
            height: 30.0,
          ),
          /*Here is the widget which we externalised earlier*/
          divide(),
          /*The following  widgets are very repetitive and not very dry. 
          * They all call the externalised widget in  the ManageMusic class
          * called buildButton and pass in the link to the song, a button color,
          * and the title of the song.*/
          manageMusic.buildButton(
              'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/rock_1.mp3',
              buttonColor,
              'RockCycle'),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/energy_collisions.m4a',
            buttonColor,
            'Energy Collisions',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/heating_up_-_mc_dub.m4a',
            buttonColor,
            'Heating up',
          ),
          divide(),
          manageMusic.buildButton(
              'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/maps_1.mp3',
              buttonColor,
              'Maps'),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/mc_dub_evolution_state_of_mind.mp3',
            buttonColor,
            'Evolution',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/mc_dub_universal_gravitation__space_out__.mp3',
            buttonColor,
            'Space Out',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/mitosis_1.mp3',
            buttonColor,
            'Mitosis',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/ocean_1.mp3',
            buttonColor,
            'Ocean',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/mc_dub_waves_transfer_energy.mp3',
            buttonColor,
            'Waves Transfer Energy',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/physics_force_problems.m4a',
            buttonColor,
            'Physics Force Problems',
          ),
          divide(),
          manageMusic.buildButton(
            'https://sanmarinscience.weebly.com/uploads/1/1/5/2/11528286/stars_1.mp3',
            buttonColor,
            'Stars',
          ),
          divide(),
          /*Inside of the column widget, we create a row to horizontally
          * position widgets.*/
          Row(
            children: <Widget>[
              /*This icon widget displays the icon next to the volume bar*/
              Icon(
                Icons.volume_up,
                color: Colors.grey,
              ),
              /*This slider widget displays the purple bar. The value is
              * set to volume value which is updated everytime it is changed.
              * the min and max act as the max and min volume. The active color
              * is the color of the slider at and before the value.
              * the inactive color is the color of everything after the position.
              * onChanged listens for a change in the value, and everytime it
              * detects a change the volume value is set to the current value
              * and a manageMusic function is called to change the volume.*/
              Expanded(
                child: Slider(
                  value: volumeValue,
                  min: 0,
                  max: 1,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      volumeValue = value;
                      manageMusic.setVolume(volumeValue);
                    });
                  },
                ),
              ),
            ],
          ),
          /*Here we do almost exactly the same thing as above, but now for the
          * position. we also add some text widgets to display the position
          * and total length of the song.*/
          Row(
            children: <Widget>[
              Text(
                '${currentPositionInMinutes.round()}:${currentPositionInDisplayableSeconds.round()}',
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                /*The only major difference in this slider is the max, which
                * is set at the length of the song plus a little more so
                * that the value can never exceed the max. We also use
                * a seek function in the onChanged handler instead of a
                * function that sets the volume*/
                child: Slider(
                  value: currentPosition,
                  min: 0.0,
                  max: manageMusic.lengthInSecondsConverted + 0.5,
                  activeColor: Colors.blueGrey,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    manageMusic.seekSong(value.toInt());
                    setState(() {
                      currentPosition = value;
                    });
                    //setCurrentPosition();
                  },
                ),
              ),
              Text(
                '${manageMusic.timeInMinutes.round()}:${manageMusic.displayableSeconds.round()}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                /*These buttons are very simple. I added some padding on the
              * top and  bottom to position the icons nicely, passed in a
              * color, added an icon as a child, and that was it. The
              * onPressed of this button calls the pause function,
              * and the other button's onPressed calls the resume function.*/
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  color: Colors.green[600],
                  child: Icon(
                    Icons.pause,
                  ),
                  onPressed: () {
                    manageMusic.pauseMusic();
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  color: Colors.green[600],
                  child: Icon(
                    Icons.play_arrow,
                  ),
                  onPressed: () {
                    manageMusic.resumeMusic();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
