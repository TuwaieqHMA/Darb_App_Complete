import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeaderTextField extends StatelessWidget {
  const HeaderTextField({
    super.key,
    required this.controller, required this.headerText, this.headerColor = whiteColor, this.borderColor = signatureTealColor, this.hintText, this.hintTextDircetion, this.isEnabled = true, this.isReadOnly = false, this.textDirection, this.isObscured = false, this.inputFormatters, this.onChange, this.onTap, this.keyboardType, this.maxLength,
  });

  final TextEditingController controller;
  final String headerText;
  final Color? headerColor;
  final String? hintText;
  final TextDirection? hintTextDircetion;
  final Color? borderColor;
  final TextDirection? textDirection;
  final bool? isEnabled;
  final bool? isReadOnly;
  final bool? isObscured;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChange;
  final Function()? onTap;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
              color: headerColor,
              fontSize: 24,
              fontFamily: inukFont,
              fontWeight: FontWeight.w500),
        ),
        height8,
        TextField(
          enabled: isEnabled,
          readOnly: isReadOnly!,
          controller: controller,
          style: const TextStyle(fontFamily: inukFont),
          keyboardType: keyboardType,
          decoration: InputDecoration(
              fillColor: whiteColor,
              filled: true,
              hintText: hintText,
              hintTextDirection: hintTextDircetion,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                    color: borderColor!,
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: lightBlueColor,
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: fadedBlueColor,
                      width: 4,
                      strokeAlign:
                          BorderSide.strokeAlignOutside))),
          textDirection: textDirection,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          obscureText: isObscured!,
          onChanged: onChange,
          onTap: onTap,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}
