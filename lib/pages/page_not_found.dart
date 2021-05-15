import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("Page not found!"),
              ElevatedButton(
                  onPressed: () => NavigatorService().goBack(),
                  child: Text("Go back"))
            ],
          ),
        ),
      ),
    );
  }
}
