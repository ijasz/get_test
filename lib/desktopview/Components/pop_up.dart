import 'package:flutter/material.dart';

void main() {}

class MyPage extends StatelessWidget {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            key: _key,
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(child: Text('0'), value: 0),
                PopupMenuItem(child: Text('1'), value: 1),
              ];
            },
          ),
        ],
      ),
      body: RaisedButton(
        onPressed: () => _key.currentState.showButtonMenu(),
        child: Text('Open/Close menu'),
      ),
    );
  }
}
