/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String label, IconData prefixIcon) =>
    InputDecoration.collapsed(hintText: '').copyWith(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        border: UnderlineInputBorder(),
        fillColor: Color(0xffECECEC));

