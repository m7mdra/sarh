import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String label, IconData prefixIcon) =>
    InputDecoration.collapsed(hintText: '').copyWith(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Color(0xffECECEC));
