import 'package:flutter/material.dart';

class SrahTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  //TODO add validator and other [TextFormField] fields

  const SrahTextFormField({Key key, this.controller, this.labelText, this.icon})
      : super(key: key);

  @override
  _SrahTextFormFieldState createState() => _SrahTextFormFieldState();
}

class _SrahTextFormFieldState extends State<SrahTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration.collapsed(hintText: '').copyWith(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.icon),
          filled: true,
          fillColor: Color(0xf9ac0e3)),
    );
  }

  @override
  void dispose() {
    widget?.controller?.dispose();
    super.dispose();
  }
}
