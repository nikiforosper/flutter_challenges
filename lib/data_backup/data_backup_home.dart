import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_backup/data_backup_cloud_page.dart';
import 'package:flutter_application_1/data_backup/data_backup_completed_page.dart';
import 'package:flutter_application_1/data_backup/data_backup_initial_page.dart';

const mainDataBackupColor = Color(0xff5113aa);
const secondaryDataBackupColor = Color(0xffbc53fa);
const backgroundColor = Color(0xfffce7fe);

class DatabackupHome extends StatefulWidget {
  const DatabackupHome({Key? key}) : super(key: key);

  @override
  State<DatabackupHome> createState() => _DatabackupHomeState();
}

class _DatabackupHomeState extends State<DatabackupHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _cloudAnimation;
  late Animation<double> _endingAnimation;
  late Animation<double> _bubblesAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    _progressAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.65),
    );
    _cloudAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        0.85,
        curve: Curves.easeOut,
      ),
    );
    _bubblesAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        1.0,
        curve: Curves.decelerate,
      ),
    );
    _endingAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.8,
        1.0,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            DataBackupInitialPage(
              progressAnimation: _progressAnimation,
              onAnimationStarted: () {
                _animationController.forward();
              },
            ),
            DataBackupCloudPage(
              progressAnimation: _progressAnimation,
              cloudOutAnimation: _cloudAnimation,
              bubblesAnimation: _bubblesAnimation,
            ),
            DatabackupCompletedPage(
              _endingAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
