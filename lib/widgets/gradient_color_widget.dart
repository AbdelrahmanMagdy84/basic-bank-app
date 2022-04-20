import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  Widget childWidget;
  GradientWidget(this.childWidget, {Key? key}) : super(key: key);
  static LinearGradient linearGradientBuilder(BuildContext context,{double opacity=1}) =>
      LinearGradient(
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary.withOpacity(opacity)
        ],
        begin: const FractionalOffset(0, 1),
        end: const FractionalOffset(0, 0.5),
        stops:const [0.0, 1.0],
        tileMode: TileMode.clamp,
      );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          GradientWidget.linearGradientBuilder(context,opacity: 1).createShader(bounds),
      child: childWidget,
    );
  }
}
