import 'package:closure/views/chat_list_view.dart';
import 'package:closure/views/home_view.dart';
import 'package:closure/views/profil_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  final int initialPageIndex;

  const MainView({super.key, this.initialPageIndex = 0});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  late int _currentIndex;
  final List<Widget> _children = [
    const HomeView(),
    const ChatListView(),
    const ProfilView()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentIndex = widget.initialPageIndex;
    // setLogin();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/timeline.png',
                width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/chat.png', width: 24, height: 24),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/profil.png', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
