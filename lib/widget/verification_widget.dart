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
import 'package:flutter/services.dart';

import '../size_config.dart';

typedef VoidCallback OnChange(String value);
typedef VoidCallback OnCodeChange(String value);
typedef VoidCallback OnComplete(bool completed);

class VerificationCodeWidget extends StatefulWidget {
  final int count;
  final InputDecoration cellsInputDecoration;
  final TextStyle cellsTextStyle;
  final OnCodeChange onCodeChange;
  final OnComplete onComplete;
  final bool obscureText;

  const VerificationCodeWidget(this.count,
      {Key key,
      this.onCodeChange,
      this.onComplete,
      this.cellsInputDecoration,
      this.cellsTextStyle,
      this.obscureText})
      : super(key: key);

  @override
  VerificationCodeWidgetState createState() => VerificationCodeWidgetState();
}

class VerificationCodeWidgetState extends State<VerificationCodeWidget> {
  final List<FocusNode> _nodes = [];
  final List<TextEditingController> _textEditingControllers = [];
  final List<CodeDigitWidget> _digitWidgets = [];
  int _count;

  void clearCells() {
    _textEditingControllers.forEach((controller) => controller.clear());
    FocusScope.of(context).requestFocus(_nodes[0]);
  }

  String get codes {
    try {
      return _textEditingControllers
          .map((controller) => controller.text)
          .where((code) => code.isNotEmpty)
          .reduce((first, second) {
        return first + second;
      });
    } catch (_) {
      return '';
    }
  }

  void _generate() {
    for (var i = 0; i < _count; i++) {
      var controller = TextEditingController();
      var node = FocusNode();
      _nodes.add(node);
      _textEditingControllers.add(controller);
      _digitWidgets.add(CodeDigitWidget(
        key: UniqueKey(),
        cellSize: Size(50, 45),
        focusNode: node,

        textEditingController: controller,
        // ignore: missing_return
        onChange: (value) {
          widget.onCodeChange(_textEditingControllers
              .map((controller) => controller.text)
              .where((code) => code.isNotEmpty)
              .reduce((first, second) {
            return first + second;
          }));
          if (value.isEmpty) {
            var node = _nodes[i - 1];

            FocusScope.of(context).requestFocus(node);
          } else {
            var node = _nodes[i + 1];
            FocusScope.of(context).requestFocus(node);
          }
        },
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _count = widget.count;
    _generate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _digitWidgets,
      ),
    );
  }
}

class CodeDigitWidget extends StatelessWidget {
  final FocusNode focusNode;
  final OnChange onChange;
  final bool obscureText;
  final TextEditingController textEditingController;
  final double marginBetweenCells;
  final Size cellSize;
  final InputDecoration cellsInputDecoration;
  final TextStyle cellsTextStyle;

  final _defaultInputBorder = const InputDecoration(
      counterText: '',
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))));

  const CodeDigitWidget({
    Key key,
    this.focusNode,
    this.onChange,
    this.obscureText,
    this.textEditingController,
    this.marginBetweenCells,
    this.cellSize,
    this.cellsInputDecoration,
    this.cellsTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 12.5,
      height: SizeConfig.blockSizeHorizontal * 14.5,
      alignment: Alignment.center,
      margin: EdgeInsets.all(marginBetweenCells ?? 4),
      child: TextField(
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1)
        ],
        textAlign: TextAlign.center,
        key: key,
        focusNode: focusNode,
        controller: textEditingController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onChanged: onChange,
        maxLength: 1,
        obscureText: obscureText ?? false,
        style: Theme.of(context).textTheme.title,
        maxLengthEnforced: true,
        decoration: cellsInputDecoration ?? _defaultInputBorder,
        enableInteractiveSelection: false,
      ),
    );
  }
}
