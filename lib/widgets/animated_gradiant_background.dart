import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.colors = const [
      Color.fromARGB(255, 78, 61, 61),
      Color.fromARGB(255, 105, 82, 64),
      Color.fromARGB(255, 95, 75, 67),
      Color.fromARGB(255, 83, 70, 70),
    ],
    this.duration = const Duration(seconds: 7),
  });

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0.0, // Fijo en x
                -1.0 + (1 * _animationController.value), // Varía de -1 a 1 en y
              ),
              end: Alignment(
                0.0, // Fijo en x
                1.5 + (1 * _animationController.value), // Varía de 0 a 2 en y
              ),
              colors: const [
                Color.fromARGB(255, 78, 61, 61),
                Color.fromARGB(255, 105, 82, 64),
                Color.fromARGB(255, 95, 75, 67),
                Color.fromARGB(255, 83, 70, 70),
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}