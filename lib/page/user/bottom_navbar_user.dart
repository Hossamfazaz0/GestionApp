part of '../pages.dart';

class BottomNavigationBarUserScreen extends StatefulWidget {
  const BottomNavigationBarUserScreen({Key? key}) : super(key: key);
  @override
  _BottomNavigationBarUserScreenState createState() =>
      _BottomNavigationBarUserScreenState();
}

class _BottomNavigationBarUserScreenState extends State {
  int _selectedIndex = 1;

  final _buildScreens = [
    const MainPage(),
    const ProfileUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildScreens[_selectedIndex],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        currentIndex: _selectedIndex,
        elevation: 4,
        padding: const EdgeInsets.all(12),
        snakeViewColor: AppTheme.primaryColor,
        selectedItemColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        snakeShape: SnakeShape.circle,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Personne',
          ),

        ],
      ),
    );
  }
}
