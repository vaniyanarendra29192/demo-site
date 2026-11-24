import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final Color? backgroundColor;
  final Widget? drawer;

  const AppScaffold(
      {this.body,
      this.appBar,
      this.bottomNavigationBar,
      this.extendBody = false,
      this.backgroundColor,
      this.drawer,
      super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor,
      extendBody: widget.extendBody,
      drawer: widget.drawer,
    );
  }
}
