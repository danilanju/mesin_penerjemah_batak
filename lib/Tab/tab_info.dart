import 'package:flutter/material.dart';

class TabInfo extends StatelessWidget {
  const TabInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text('Prototipe Aplikasi Penerjemah Bahasa'),
          Text('Developer : Danil Anju Trisakti S'),
          Text('Email : danieltrisakti12@gmail.com'),
        ],
      ),
    );
  }
}
