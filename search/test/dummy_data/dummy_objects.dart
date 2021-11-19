import 'package:flutter/material.dart';

class FakeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListTile(
      key: Key('fake_tile'),
      onTap: () {
        Navigator.pushNamed(context, '/second');
      },
      title: Text('This is Fake'),
      leading: Icon(Icons.check),
    ));
  }
}

class FakeTargetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListTile(
      key: Key('fake_second_tile'),
      onTap: () {
        Navigator.pop(context);
      },
      title: Text('This is Fake'),
      leading: Icon(Icons.check),
    ));
  }
}
