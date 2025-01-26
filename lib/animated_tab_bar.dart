import 'package:flutter/material.dart';

class AnimatedTabBar extends StatefulWidget {
   const AnimatedTabBar({super.key});

  @override
  AnimatedTabBarState createState() => AnimatedTabBarState();
}

class AnimatedTabBarState extends State<AnimatedTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _pages = [
     const Center(child: Text('Home', style: TextStyle(fontSize: 24))),
     const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
     const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.person,
  ];

  final List<String> _labels = [
    'Home',
    'Search',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: _pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:  const EdgeInsets.only(bottom: 20),
              child: AnimatedTabBarWidget(
                icons: _icons,
                labels: _labels,
                tabController: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTabBarWidget extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final TabController tabController;

   const AnimatedTabBarWidget({
    required this.icons,
    required this.labels,
    required this.tabController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset:  const Offset(0, 4),
          ),
        ],
      ),
      padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(icons.length, (index) {
          return GestureDetector(
            onTap: () {
              tabController.animateTo(
                index,
                duration:  const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                bool isSelected = tabController.index == index;
                return AnimatedContainer(
                  duration:  const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ?  const Color(0xFF1B8FED) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icons[index],
                        color: isSelected ? Colors.white :  const Color.fromARGB(255, 8, 0, 0),
                        size: isSelected ? 26 : 22,
                      ),
                      if (isSelected)  const SizedBox(width: 8),
                      if (isSelected)
                        Text(
                          labels[index],
                          style:  const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}