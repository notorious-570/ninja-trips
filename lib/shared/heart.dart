import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  Animation<double>? _sizeAnimation;
  late AnimationController _controller;
  Animation? _colorAnimation;
  late Animation<double> _curve;
  bool isFav = false;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // TODO: implement initState
    super.initState();
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    );
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_curve); //animate(_controller)
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_curve); //animate(_controller)
    _controller.addListener(() {
      print(_controller.value);
      print(_colorAnimation?.value);
    });
    _controller.addStatusListener((status) {
      // print('status: $status');
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller
        .dispose(); // background me chalna nahi chaiye, resources free kardo if not needed in background
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation?.value,
            size: _sizeAnimation?.value,
          ),
          onPressed: () {
            isFav ? _controller.reverse() : _controller.forward();
          },
        );
      },
    );
  }
}
