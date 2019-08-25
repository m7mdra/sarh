import 'package:flutter/material.dart';

class SarhProgressBar extends StatelessWidget {
  final bool circular;

  const SarhProgressBar({Key key, this.circular = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: circular
            ? CircularProgressIndicator(backgroundColor: Color(0xff21eae3))
            : Padding(
                padding: const EdgeInsets.all(16),
                child:
                    LinearProgressIndicator(backgroundColor: Color(0xff21eae3)),
              ),
      ),
    );
  }
}
