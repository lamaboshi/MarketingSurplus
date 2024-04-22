import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final String? value;
  final String? label;
  final int? minLines;
  final double? width;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextEditingController? controller;
  final bool? isNumberFormat;
  const TextFieldWidget(
      {this.value,
      this.label,
      required this.onChanged,
      required this.textInputType,
      this.focusedBorder,
      this.enabledBorder,
      this.width,
      this.controller,
      this.minLines,
      this.isNumberFormat = false,
      Key? key})
      : super(key: key);
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(
          text: widget.value,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: widget.width,
        child: TextFormField(
          key: Key(widget.label!),
          focusNode: FocusNode(),
          controller: _controller,
          keyboardType: widget.textInputType,
          textAlignVertical: TextAlignVertical.center,
          minLines: widget.minLines,
          maxLines: (widget.minLines ?? 0) + 1,
          inputFormatters: widget.isNumberFormat!
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            // focusedBorder: const UnderlineInputBorder(
            //     borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            label: Text(widget.label!),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
