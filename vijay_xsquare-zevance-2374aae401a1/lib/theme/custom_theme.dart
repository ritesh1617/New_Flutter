import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

class _CustomTheme extends InheritedWidget {
  final CustomThemeState? data;

  _CustomTheme({
    this.data,
    Key? key,
    Widget? child,
  }) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget? child;
  final AppThemeKeys? initialThemeKey;

  const CustomTheme({
    Key? key,
    this.initialThemeKey,
    this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => new CustomThemeState();

  static ThemeData of(BuildContext context) {
    _CustomTheme inherited =
    (context.dependOnInheritedWidgetOfExactType<
        _CustomTheme>() as _CustomTheme);
    return inherited.data!.theme;
  }

  static CustomThemeState? instanceOf(BuildContext context) {
    _CustomTheme inherited =
    (context.dependOnInheritedWidgetOfExactType<
        _CustomTheme>() as _CustomTheme);
    return inherited.data;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData? _theme;

  ThemeData get theme => _theme!;

  @override
  void initState() {
    _theme = AppThemes.getThemeFromKey(widget.initialThemeKey!);
    super.initState();
  }

  void changeTheme(AppThemeKeys themeKey) {
    setState(() {
      _theme = AppThemes.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}

