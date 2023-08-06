import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';

class PlayerControl extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final bool isPlaying;

  const PlayerControl({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            splashRadius: 25.r,
            iconSize: 25.r,
            onPressed: onPrevious,
            icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
          ),
          GestureDetector(
            onTap: onPlayPause,
            child: Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: mainGold),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 32.r,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            splashRadius: 25.r,
            iconSize: 25.r,
            onPressed: onNext,
            icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class SpecialForm extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool obscure;
  final bool autoValidate;
  final FocusNode? focus;
  final bool autoFocus;
  final Function? onChange;
  final Function? onActionPressed;
  final Function? onValidate;
  final Function? onSave;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool readOnly;
  final int maxLines;
  final double width;
  final double height;

  const SpecialForm({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    this.fillColor,
    this.borderColor,
    this.padding,
    this.hintStyle,
    this.focus,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscure = false,
    this.autoValidate = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.none,
    this.onActionPressed,
    this.onChange,
    this.onValidate,
    this.style,
    this.onSave,
    this.radius,
    this.hint,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        style: style ?? context.textTheme.bodyMedium,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        maxLines: maxLines,
        focusNode: focus,
        autofocus: autoFocus,
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        textInputAction: action,
        readOnly: readOnly,
        onEditingComplete: () => onActionPressed!(controller.text),
        cursorColor: mainGold,
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          contentPadding:
              padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          prefixIcon: prefix,
          suffixIcon: suffix,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? offWhite,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? offWhite,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? offWhite,
            ),
          ),
          hintText: hint,
          hintStyle: hintStyle ??
              context.textTheme.labelMedium!
                  .copyWith(fontWeight: FontWeight.w200),
        ),
        onChanged: (value) {
          if (onChange == null) return;
          onChange!(value);
        },
        validator: (value) {
          if (onValidate == null) return null;
          return onValidate!(value);
        },
        onSaved: (value) {
          if (onSave == null) return;
          onSave!(value);
        },
      ),
    );
  }
}

class Holder {
  final String content;
  bool selected;

  Holder({required this.content, this.selected = false});
}


class ComboBox extends StatefulWidget {
  final String hint;
  final List<String> items;
  final Widget? prefix;
  final Function? onChanged;
  final double width;
  final double? height;
  final Function? onValidate;
  final String? initial;

  const ComboBox(
      {Key? key,
        this.hint = "",
        required this.items,
        this.height,
        required this.width,
        this.onValidate,
        this.prefix,
        this.initial,
        this.onChanged,
      })
      : super(key: key);

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  String? _selection;

  @override
  void initState() {
    super.initState();
    _selection = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: DropdownButtonFormField<String>(
        hint: Text(widget.hint,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w200)),
        value: _selection,
        style: context.textTheme.bodySmall,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          hintStyle: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontWeight: FontWeight.w200),
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          filled: true,
          prefixIcon: widget.prefix,
          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: theme),
              borderRadius: BorderRadius.circular(6.r)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: theme),
              borderRadius: BorderRadius.circular(6.r)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: theme),
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        validator: (val) {
          if (widget.onValidate == null) return null;
          return widget.onValidate!(val);
        },
        items: widget.items
            .map(
              (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ),
        )
            .toList(),
        onChanged: (item) {
          if (widget.onChanged != null) {
            widget.onChanged!(item);
          }
        },
      ),
    );
  }
}


class Copyright extends StatelessWidget {
  const Copyright({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.copyright, color: Colors.grey, size: 16.r),
        SizedBox(width: 3.w),
        Text("${DateTime.now().year}. Playbucks. All rights reserved",
            style: context
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

