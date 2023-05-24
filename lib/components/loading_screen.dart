import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key, this.message = ''}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    Widget messageChild = Container();

    if (message != null && message.isNotEmpty) {
      messageChild = Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          message + '...',
        ),
      );
    }
    final double height = 800;
    final double width = 450;

    return Container(
      height: height,
      width: width,
      color: Colors.white38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[const CircularProgressIndicator(), messageChild],
        ),
      ),
    );
  }
}
