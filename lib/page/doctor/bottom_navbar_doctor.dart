part of '../pages.dart';

class BottomNavigationBarDoctor extends StatefulWidget {
  const BottomNavigationBarDoctor({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarDoctorState createState() =>
      _BottomNavigationBarDoctorState();
}

class _BottomNavigationBarDoctorState extends State {
  int _selectedIndex = 1;

  final _buildScreens = [

    const MainPageDoctor(),
    const DoctorProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: 'Profil',
          ),

        ],
      ),
    );
  }
}
