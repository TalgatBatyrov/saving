import 'dart:math';

import 'package:flutter/material.dart';

class SavingItem extends StatefulWidget {
  final String title;
  final int value;

  const SavingItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<SavingItem> createState() => _SavingItemState();
}

class _SavingItemState extends State<SavingItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            _controller.isAnimating
                ? _controller.stop()
                : _controller.repeat(reverse: true);
            setState(() {});
          },
          child: SizedBox(
            width: 70,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.rotate(
                alignment: Alignment.center,
                angle: _animation.value,
                // transform: Matrix4.identity()..rotateY(_animation.value),
                child: Card(
                  color:
                      !_controller.isAnimating ? Colors.green[400] : Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.value}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
