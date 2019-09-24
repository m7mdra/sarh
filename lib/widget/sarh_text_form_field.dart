import 'package:flutter/material.dart';

class SrahTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final FocusNode focusNode;


  const SrahTextFormField(
      {Key key,
      this.controller,
      this.labelText,
      this.icon,
      this.validator,
      this.obscureText = false,
      this.focusNode})
      : super(key: key);

  @override
  _SrahTextFormFieldState createState() => _SrahTextFormFieldState();
}

class _SrahTextFormFieldState extends State<SrahTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: buildInputDecoration().copyWith(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.icon),
          filled: true,
          fillColor: Color(0xffECECEC)),
    );
  }

  InputDecoration buildInputDecoration() =>
      InputDecoration.collapsed(hintText: '').copyWith(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.icon),
          filled: true,
          fillColor: Color(0xffECECEC));

  @override
  void dispose() {
    widget?.controller?.dispose();
    super.dispose();
  }
}
