import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key? key,
      required TextEditingController controller,
      required String? Function(String? value) validator,
      required String hintText,
      bool obscureText = false})
      : _controller = controller,
        _validator = validator,
        _hintText = hintText,
        _obscureText = obscureText,
        super(key: key);

  final TextEditingController _controller;
  final String? Function(String? value) _validator;
  final String _hintText;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              validator: _validator,
              obscureText: _obscureText,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: _hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
