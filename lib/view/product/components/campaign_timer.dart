import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class CampaignTimer extends StatefulWidget {
  const CampaignTimer({super.key, required this.remainingTime});

  final remainingTime;

  @override
  State<CampaignTimer> createState() => _CampaignTimerState();
}

class _CampaignTimerState extends State<CampaignTimer> {
  final CustomTimerController timerController = CustomTimerController();

  @override
  void initState() {
    super.initState();
    timerController.start();
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = DateTime.now();
    final timeLeft = widget.remainingTime.difference(todayDate).inDays;

    return CustomTimer(
        controller: timerController,
        begin: Duration(days: timeLeft),
        end: const Duration(),
        builder: (time) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  height: 68,
                  width: 68,
                  margin: EdgeInsets.only(right: i == 3 ? 0 : 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor),
                  child: TimerCard(
                    i: i,
                    time: time,
                  ),
                )
            ],
          );
        });
  }
}

class TimerCard extends StatelessWidget {
  const TimerCard({
    Key? key,
    required this.i,
    required this.time,
  }) : super(key: key);

  final int i;
  final time;

  @override
  Widget build(BuildContext context) {
    List timeCardTitle = ['Days', 'Hours', 'Minutes', 'Seconds'];

    getTime(index) {
      if (index == 0) {
        return time.days;
      } else if (index == 1) {
        return time.hours;
      } else if (index == 2) {
        return time.minutes;
      } else if (index == 3) {
        return time.seconds;
      }
    }

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AutoSizeText(
        getTime(i),
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      ),
      gapH(3),
      AutoSizeText(
        timeCardTitle[i],
        maxLines: 1,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    ]);
  }
}
