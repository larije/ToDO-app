import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final int goalTime;
  final int currentTimeSpent;
  final VoidCallback onTap;
  final VoidCallback onSettingsTap;
  final bool habitStarted;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.currentTimeSpent,
    required this.goalTime,
    required this.onTap,
    required this.onSettingsTap,
    required this.habitStarted,
  }) : super(key: key);

  double convertSecToMin(int seconds) {
    double minutes = seconds / 60;
    return minutes;
  }

  String formatTimeToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(3);

    // kung seconds kay single digit number, add 0 infront
    if (secs.length == 1) {
      secs = '0' + secs;
    }

    // make mins a whole number without rounding
    int decimalIndex;
    for (int i = 0; i < mins.length; i++) {
      if (mins[i] == '.') {
        decimalIndex = i;
        mins = mins.substring(0, decimalIndex);
      }
    }

    return mins + ':' + secs;
  }

  // mukuha og percentage sa completion
  double percentCompleted() {
    return (currentTimeSpent / (goalTime * 60));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        // progress circle ni sya
                        CircularPercentIndicator(
                          radius: 30,
                          percent:
                              percentCompleted() < 1 ? percentCompleted() : 1,
                          lineWidth: 6,
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          progressColor: percentCompleted() > 0.5
                              ? (percentCompleted() > 0.75
                                  ? Colors.green
                                  : Colors.orange)
                              : Colors.red,
                        ),

                        Container(
                          alignment: Alignment.center,
                          child: Icon(
                            habitStarted ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit name
                    Text(
                      habitName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // To DO time details
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      formatTimeToMinSec(currentTimeSpent) +
                          ' / ' +
                          goalTime.toString() +
                          ' mins' +
                          ' = ' +
                          (percentCompleted() * 100).toStringAsFixed(0) +
                          '%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // settings
            GestureDetector(
              onTap: onSettingsTap,
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
