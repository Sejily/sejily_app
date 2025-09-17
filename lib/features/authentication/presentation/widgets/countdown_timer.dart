import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.initialTime,
    this.onTimerEnd,
    this.onTick,
  });

  final int initialTime;
  final VoidCallback? onTimerEnd;
  final ValueChanged<int>? onTick;

  @override
  State<CountdownTimer> createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late int _timeLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.initialTime;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _timeLeft > 0) {
        setState(() => _timeLeft--);
        widget.onTick?.call(_timeLeft);
      } else {
        timer.cancel();
        widget.onTimerEnd?.call();
      }
    });
  }

  void restart() {
    setState(() => _timeLeft = widget.initialTime);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _timeLeft > 0;
    return Text(
      '${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}',
      style: AppTextStyles.medium18.copyWith(
        color: isActive ? AppColors.darkBlue : AppColors.grayShade500,
      ),
    );
  }
}
