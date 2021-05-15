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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Page not found!",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 24,
              ),
              TextButton.icon(
                onPressed: () => NavigatorService().goBack(),
                icon: Icon(Icons.arrow_left),
                label: Text(
                  "Go back",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
