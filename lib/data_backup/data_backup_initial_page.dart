import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_backup/data_backup_home.dart';
import 'package:intl/intl.dart';

enum DataBackupState {
  initial,
  start,
  end,
}
const _duration = Duration(milliseconds: 500);

class DataBackupInitialPage extends StatefulWidget {
  const DataBackupInitialPage({
    Key? key,
    required this.onAnimationStarted,
    required this.progressAnimation,
  }) : super(key: key);
  final VoidCallback onAnimationStarted;
  final Animation<double> progressAnimation;
  @override
  State<DataBackupInitialPage> createState() => _DataBackupInitialPageState();
}

class _DataBackupInitialPageState extends State<DataBackupInitialPage> {
  DataBackupState _currentState = DataBackupState.initial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 3,
            child: Text(
              "Cloud Storage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          if (_currentState == DataBackupState.end)
            Expanded(
              flex: 2,
              child: TweenAnimationBuilder<double>(
                duration: _duration,
                tween: Tween(begin: 0.0, end: 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "uploading files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ProgressCounter(widget.progressAnimation),
                        ),
                      ),
                    ),
                  ],
                ),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child!,
                  );
                },
              ),
            ),
          if (_currentState != DataBackupState.end)
            Expanded(
              flex: 2,
              child: TweenAnimationBuilder<double>(
                duration: _duration,
                tween: Tween(
                    begin: 1.0,
                    end: _currentState != DataBackupState.initial ? 0.0 : 1.0),
                onEnd: () {
                  setState(() {
                    _currentState = DataBackupState.end;
                  });
                },
                child: Column(
                  children: [
                    const Text(
                      "Last backup",
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat("dd MMMM yyyy").format(
                        DateTime.now().subtract(
                          const Duration(days: 1),
                        ),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                        offset: Offset(0.0, -50 * value), child: child!),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AnimatedSwitcher(
              duration: _duration,
              child: _currentState == DataBackupState.initial
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentState = DataBackupState.start;
                          });
                          widget.onAnimationStarted();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Create backup",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(mainDataBackupColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  : OutlinedButton(
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: mainDataBackupColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentState = DataBackupState.initial;
                        });
                      },
                    ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  const ProgressCounter(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);
  double get value => (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    return Text("${(value * 100).truncate()}%");
  }
}
