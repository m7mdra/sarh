// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO(dragostis): Missing functionality:
//   * mobile horizontal mode with adding/removing steps
//   * alternative labeling
//   * stepper feedback in the case of high-latency interactions

/// The state of a [WeeStep] which is used to control the style of the circle and
/// text.
///
/// See also:
///
///  * [WeeStep]
enum StepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

/// A material step used in [WeeStepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
///
/// See also:
///
///  * [WeeStepper]
///  * <https://material.io/archive/guidelines/components/steppers.html>
@immutable
class WeeStep {
  /// Creates a step for a [WeeStepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  const WeeStep({
    @required this.content,
  });

  /// The content of the step that appears below the [title] and [subtitle].
  ///
  /// Below the content, every step has a 'continue' and 'cancel' button.
  final Widget content;
}

/// A material stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
///
/// The widget is a flexible wrapper. A parent class should pass [currentStep]
/// to this widget based on some logic triggered by the three callbacks that it
/// provides.
///
/// See also:
///
///  * [WeeStep]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class WeeStepper extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const WeeStepper({
    Key key,
    @required this.steps,
    this.physics,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onPrevious,
    this.nextEnabled = true,
  })  : assert(steps != null),
        assert(currentStep != null),
        super(key: key);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<WeeStep> steps;
  final bool nextEnabled;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics physics;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int> onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback onPrevious;

  @override
  _WeeStepperState createState() => _WeeStepperState();
}

class _WeeStepperState extends State<WeeStepper> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  Widget _buildVerticalControls() {
    Color cancelColor;

    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    assert(cancelColor != null);

    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: widget.onPrevious,
              textColor: cancelColor,
              textTheme: ButtonTextTheme.normal,
              child: Text('Previous'),
            ),
            Chip(
              padding: const EdgeInsetsDirectional.only(
                  start: 16, end: 16, top: 4, bottom: 4),
              label: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '${widget.currentStep + 1}', style: counterTheme),
                  TextSpan(text: '/', style: slashTheme),
                  TextSpan(text: '${widget.steps.length}', style: counterTheme),
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton(
              onPressed: widget.nextEnabled ? widget.onStepContinue : null,
              textTheme: ButtonTextTheme.primary,
              child: Text(widget.currentStep + 1 == widget.steps.length
                  ? 'Finish'
                  : 'Next'),
            ),
          ],
        ),
      ),
    );
  }

  get counterTheme => TextStyle(
        fontWeight: FontWeight.w200,
      );

  get slashTheme =>
      TextStyle(fontWeight: FontWeight.w200, fontStyle: FontStyle.italic);

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.steps.length; i += 1) {
      children.add(
        InkResponse(
          onTap: () {
            if (widget.onStepTapped != null) widget.onStepTapped(i);
          },
        ),
      );

      if (!_isLast(i)) {
        children.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
        );
      }
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                vsync: this,
                child: widget.steps[widget.currentStep].content,
              ),
            ],
          ),
        ),
        _buildVerticalControls()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.ancestorWidgetOfExactType(WeeStepper) != null)
        throw FlutterError(
            'Steppers must not be nested. The material specification advises '
            'that one should avoid embedding steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      return true;
    }());
    return _buildHorizontal();
  }
}
