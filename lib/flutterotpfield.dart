library flutterotpfield;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterOtpField extends StatefulWidget {
  /// Length of the otp boxes (required)
  final int inputFieldLength;
  /// Height of the single otp field (optional)
  ///
  /// Default value is 50
  final double inputFieldHeight;
  /// Width of the single otp field (optional)
  ///
  /// Default value is 50
  final double inputFieldWidth;
  /// Height of the otp widget (optional)
  ///
  /// Default value is 50
  final double otpWidgetHeight;
  /// Space between two otp fields (optional)
  ///
  /// Default value is 5
  final double spaceBetweenFields;
  /// Focus of the first otp field (optional)
  ///
  /// Default value is true
  final bool autoFocus;
  /// Callback function. When single field value is changed, you'll receive value in the [onValueChange].
  final ValueChanged<String> onValueChange;
  /// Callback function. When all otp fields are filled, you'll receive otp value in the [onCompleted].
  final ValueChanged<String> onCompleted;
  /// Input decoration for the otp field (optional)
  final InputDecoration inputDecoration;
  /// Color of the cursor (optional)
  ///
  /// Default color is [Colors.black]
  final Color cursorColor;
  /// ScrollPhysics for otp widget (optional)
  ///
  /// Default value is [NeverScrollableScrollPhysics]
  ///
  /// It is recommended that when [inputFieldLength] is grater then 8 then you should use [AlwaysScrollableScrollPhysics]
  final ScrollPhysics scrollPhysics;

  const FlutterOtpField(
      {super.key,
        required this.inputFieldLength,
        this.inputFieldHeight = 50,
        this.inputFieldWidth = 50,
        this.otpWidgetHeight = 50,
        this.spaceBetweenFields = 5,
        this.autoFocus = true,
        required this.onValueChange,
        required this.onCompleted,
        this.inputDecoration = const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        this.cursorColor = Colors.black,
        this.scrollPhysics = const NeverScrollableScrollPhysics()});

  @override
  State<StatefulWidget> createState() => _FlutterOtpField();
}

class _FlutterOtpField extends State<FlutterOtpField> {
  List<TextEditingController> controller = [];
  List<FocusNode> focusNodes = [];
  List<FocusNode> focusNodes1 = [];

  void initControllers(int size) {
    for (int i = 0; i < size; i++) {
      controller.add(TextEditingController(text: ""));
      focusNodes.add(FocusNode());
      focusNodes1.add(FocusNode());
    }
  }

  @override
  void initState() {
    super.initState();
    initControllers(widget.inputFieldLength);
    if (widget.autoFocus) {
      focusNodes[0].requestFocus();
    }
  }

  void checkAllTextFieldsCompleted() {
    bool isFieldsCompleted = true;
    String otpText = "";
    for (int i = 0; i < widget.inputFieldLength; i++) {
      if (controller[i].text.isNotEmpty) {
        otpText += controller[i].text.toString();
      } else {
        isFieldsCompleted = false;
      }
    }
    if (isFieldsCompleted) {
      widget.onCompleted(otpText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.otpWidgetHeight,
        child: ListView.separated(
          shrinkWrap: true,
          physics: widget.scrollPhysics,
          itemCount: widget.inputFieldLength,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return otpField(position, widget.inputFieldLength);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: widget.spaceBetweenFields,
            );
          },
        ));
    // child: Row(
    //   mainAxisAlignment: (widget.adjustSpaceBetween) ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     for (int i = 0; i < widget.inputFieldLength; i++) ...[
    //       otpField(i, widget.inputFieldLength),
    //       if(!widget.adjustSpaceBetween && i < widget.inputFieldLength - 1)
    //         SizedBox(width: widget.spaceBetweenFields <= 0 ? 5 : widget.spaceBetweenFields,)
    //     ]
    //   ],
    // ));
  }

  Widget otpField(int index, int boxSize) {
    return SizedBox(
        height: widget.inputFieldHeight,
        width: widget.inputFieldWidth,
        child: RawKeyboardListener(
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              if (event.data.logicalKey.keyLabel == "Backspace") {
                if (index > 0) {
                  focusNodes[index - 1].requestFocus();
                }
              } else {
                if (controller[index].text.length == 1) {
                  if (index < boxSize - 1) {
                    if (event.character.toString().isNumeric) {
                      focusNodes[index + 1].requestFocus();
                      controller[index + 1].text = event.character.toString();
                      widget.onValueChange(event.character.toString());
                      checkAllTextFieldsCompleted();
                    }
                  }
                }
              }
            }
          },
          focusNode: focusNodes1[index],
          child: TextFormField(
            textAlign: TextAlign.center,
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            controller: controller[index],
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 1,
            onChanged: (value) {
              if (value.isNumeric) {
                if (index < boxSize - 1) {
                  focusNodes[index + 1].requestFocus();
                  widget.onValueChange(value);
                }
              }
              checkAllTextFieldsCompleted();
            },
            cursorColor: Colors.black,
            decoration: widget.inputDecoration,
          ),
        ));
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}