import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomInput extends StatefulWidget {
  final String? label;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? errorText;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;

  const CustomInput(
      {Key? key,
      this.label,
      required this.controller,
      required this.inputType,
      this.errorText,
      this.enabled = true,
      this.validator,
      this.focusNode})
      : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _focused = false;
  bool _onError = false;
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus == true;
      });
    }
  }

  bool get _filled => widget.controller.value.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: _controller,
        style: Theme.of(context).textTheme.bodyText2,
        keyboardType: widget.inputType,
        focusNode: _focusNode,
        validator: (String? value) {
          if (widget.validator != null) {
            String? error = widget.validator!(value);
            setState(() {
              _onError = error != null;
            });
            return error;
          } else {
            return null;
          }
        },
        cursorColor: !_onError
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.error,
        decoration: InputDecoration(
            labelText: widget.label,
            errorMaxLines: 5,
            errorText: widget.errorText,
            counterText: '',
            labelStyle: _onError && (_filled || _focused)
                ? Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.error)
                : (_focused
                    ? Theme.of(context).primaryTextTheme.subtitle2
                    : Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Theme.of(context).primaryColor)),
            filled: !widget.enabled,
            fillColor: !widget.enabled
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor),
      ),
    );
  }
}
