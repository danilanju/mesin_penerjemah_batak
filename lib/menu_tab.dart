import 'package:flutter/material.dart';

import 'Tab/tab_info.dart';
import 'Tab/tab_listkata.dart';
import 'Tab/tab_terjemah.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();
    print("rebuilt");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Penerjemah', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Color.fromARGB(255, 216, 222, 255),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Bagian TabBar
            TabBar(
              indicatorColor: Colors.deepPurpleAccent.shade700,
              tabs: [
                // Loop untuk membuat Tab dengan ikon dinamis
                for (var icon in [
                  Icons.translate,
                  Icons.library_books,
                  Icons.info,
                ])
                  Tab(
                    icon: Icon(icon, color: Colors.deepPurpleAccent.shade700),
                  ),
              ],
            ),
            // Bagian TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  TabTerjemah(textController: _textController),
                  TabList(),
                  TabInfo()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
