import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:user_managment/config/palette.dart';

class Particle{
  Animatable tween;
  AnimationProgress progress;

  Particle(Duration time){
    final random = Random();
    final x  = (100) * random.nextDouble() * (random.nextBool() ? 1 : -1);
    final y = (100) * random.nextDouble() * (random.nextBool() ? 1 : -1);

    tween = MultiTrackTween([
      Track("x").add(Duration(milliseconds: 700),Tween(begin: 0.0,end: x)),
      Track("y").add(Duration(milliseconds: 700),Tween(begin: 0.0,end: y)),
      Track("scale").add(Duration(milliseconds: 700),Tween(begin: 1.0,end: 0.0)),
    ]);

    progress = AnimationProgress(
      startTime: time, duration: Duration(milliseconds: 900)
    );

  }
  T getRandomElement<T>(list){
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
  buildWidget(Duration time){
    var iconsList = [Icons.lock,Icons.check,Icons.vpn_key_outlined];
    var colorsList = [Palette.lightGrey,Palette.red,Colors.greenAccent];
    final animation = tween.transform(
      progress.progress(time));
    IconData icon = getRandomElement(iconsList);
    Color color = getRandomElement(colorsList);

      return Positioned.fill(
        left: animation["x"],
        top: animation["y"],
        child: Transform.scale(
          scale: animation["scale"],
          child: Icon(
            icon,
            size: 40,
            color: color,
          ),
        ),

    );
  }
}