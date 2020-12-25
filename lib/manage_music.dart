/*The import Statements import different packages,
*which add different functionalities to this file */
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/*This class does not extend anything, meaning it has no parent to inherit
* any properties from. It also does not have a state, meaning that there is
* no way to call build from this class*/
class ManageMusic {
  /*These are all of our variables for this class.*/
  AudioPlayer audioPlayer = AudioPlayer();
  double lengthInSecondsConverted = 1.0;
  double timeInMinutes = 0.0;
  double timeInSeconds = 0.0;
  double displayableSeconds = 0.0;
  double currentPositionInSeconds = 0.0;
  int currentPositionInInt = 0;
  bool isPlaying = false;
  Stream<Duration> currentPosition;

  /*This function takes in a song and then plays it. If the result is a 1, that
  * means it is playing the song, so we set isPlaying to true. The only tricky
  * part of this function is the keywords async and await. these keywords mean
  * that the function returns asynchronously. this is because the function is
  * making a call to the internet to receive the files. This can't happen
  * instantaneously, so we need to put these keywords in to tell the program
  * to not continue until the call has come back with a response. */
  void playSound(songLocation) async {
    int resultForPlay = await audioPlayer.play(songLocation);
    if (resultForPlay == 1) {
      isPlaying = true;
    }
  }

  /*The Future<int> means that this function is calling a function which is
  * asynchronous so it does not return the result immediately. As for the
  * functionality, this function makes a call to get the duration of the
  * file that is currently playing. it then either returns the length or a 0
  * if the length was null or an error occurred.*/
  Future<int> getDuration() async {
    if (isPlaying == true) {
      int songLength = await audioPlayer.getDuration();
      return songLength;
    } else {
      return 0;
    }
  }

  /*This function is yet another async await function. It first makes a call
  * to get the duration, then it converts the lengths several times to
  * get the value as an int. we then create a new variable called duration.
  * this variable is equal to a function that takes in a measurement and
  * a value. you can then convert that value to different measurements.
  * that is exactly what we do. we get the value in minutes and seconds
  * as doubles. we then create a variable called displayableSeconds and
  * calculate the amount of trailing seconds without the minutes included.
  * the final piece is setting lengthInSecondsConverted to the absolute
  * value of lengthInSeconds. (I don't know why but lengthInSeconds returned
  * as a negative that was less than the min value on the slider widget.)*/
  void convertDuration() async {
    int lengthInInt = await getDuration();
    double lengthInDouble = lengthInInt.toDouble();
    double lengthInSeconds = lengthInDouble / 1000;
    Duration duration = Duration(milliseconds: lengthInInt);

    timeInMinutes = duration.inMinutes.toDouble();
    timeInSeconds = duration.inSeconds.toDouble();
    displayableSeconds = timeInSeconds - timeInMinutes * 60;

    lengthInSecondsConverted = lengthInSeconds.abs();
  }

  /*This function pauses the music*/
  void pauseMusic() async {
    int resultForPause = await audioPlayer.pause();
  }

  /*This function plays the music*/
  void resumeMusic() async {
    int resultForPause = await audioPlayer.resume();
  }

  /*This function changes the volume of the music to the value passed in*/
  void setVolume(volume) {
    audioPlayer.setVolume(volume);
  }

  /*This function seeks in the song to the value passed in*/
  void seekSong(seconds) {
    audioPlayer.seek(Duration(seconds: seconds));
  }

  /*This is the externalised widget that takes in the songLocation, color, and
  * songTitle and returns a button widget that had all of the information
  * built in.*/
  Expanded buildButton(
    songLocation,
    color,
    songTitle,
  ) {
    return Expanded(
      child: FlatButton(
        color: color,
        child: Text(
          '$songTitle',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          playSound(songLocation);
        },
      ),
    );
  }
}
