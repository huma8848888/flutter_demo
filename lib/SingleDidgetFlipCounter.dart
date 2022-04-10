import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final Curve curve;
  final Size size;
  final Color color;
  final double begin = 0.0;


  SingleDigitFlipCounter({
    Key? key,
    required this.value,
    required this.duration,
    required this.curve,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<num>(begin: begin, end: value),
      duration: duration,
      curve: curve,
      builder: (_, num value, __) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        final w = size.width;
        final h = size.height;

        return SizedBox(
          width: w,
          height: h,
          child: Container(
            color: Colors.amber,
            child: Stack(
              children: <Widget>[
                _buildSingleDigit(
                  digit: whole % 10,
                  offset: h * decimal,
                  opacity: (1 - decimal).toDouble(),
                ),
                _buildSingleDigit(
                  digit: (whole + 1) % 10,
                  offset: h * (decimal - 1),
                  opacity: decimal.toDouble(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({
    required int digit,
    required double offset,
    required double opacity,
  }) {
    // Try to avoid using the `Opacity` widget when possible, for performance.
    final child;
    if (color.opacity == 1) {
      // If the text style does not involve transparency, we can modify
      // the text color directly.
      child = Text(
        '$digit',
        style: TextStyle(color: color.withOpacity(opacity.clamp(0, 1))),
      );
    } else {
      // Otherwise, we have to use the `Opacity` widget.
      child = Opacity(
        opacity: opacity.clamp(0, 1),
        child: Text('$digit'),
      );
    }
    return Positioned(
      bottom: offset,
      child: child,
    );
  }
}
