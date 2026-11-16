import 'package:flutter/material.dart';

void main() {
  runApp(const CampusExplorerApp());
}

const Color navy = Color(0xFF14213D);
const Color blue = Color(0xFF304B78);
const Color orange = Color(0xFFFCA311);
const Color pageBg = Color(0xFFF5F7FB);

class Facility {
  final String name;
  final String description;
  final IconData icon;

  const Facility(this.name, this.description, this.icon);
}

const List<Facility> facilities = [
  Facility(
    'Central Library',
    'Books, research and peaceful study areas.',
    Icons.local_library,
  ),
  Facility(
    'Computer Laboratory',
    'Modern computers and programming facilities.',
    Icons.computer,
  ),
  Facility(
    'Science Laboratory',
    'Practical experiments and scientific research.',
    Icons.science,
  ),
  Facility(
    'Sports Complex',
    'Indoor and outdoor sports activities.',
    Icons.sports_basketball,
  ),
  Facility(
    'Student Cafeteria',
    'Meals, snacks and refreshments.',
    Icons.restaurant,
  ),
  Facility(
    'University Auditorium',
    'Events, seminars and university ceremonies.',
    Icons.theater_comedy,
  ),
  Facility(
    'Medical Centre',
    'Basic healthcare and medical assistance.',
    Icons.medical_services,
  ),
  Facility(
    'Parking Area',
    'Dedicated vehicle parking facilities.',
    Icons.local_parking,
  ),
  Facility(
    'Administration Block',
    'Student and administrative services.',
    Icons.business,
  ),
  Facility(
    'Student Common Room',
    'Relaxation and social activities.',
    Icons.groups,
  ),
];

class CampusExplorerApp extends StatelessWidget {
  const CampusExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Explorer',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: navy,
          primary: navy,
          secondary: orange,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,

      body: Center(
        child: AnimatedBuilder(
          animation: _controller,

          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 115,
                width: 115,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.school_rounded, size: 65, color: navy),
              ),

              const SizedBox(height: 22),

              const Text(
                'CAMPUS EXPLORER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Discover • Explore • Experience',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? null
          : AppBar(
              title: Text(
                _currentIndex == 1
                    ? 'Campus Directory'
                    : 'About Campus Explorer',
              ),
            ),

      drawer: Drawer(
        backgroundColor: Colors.white,

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [navy, blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              accountName: Text(
                'Campus Explorer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              accountEmail: Text('Discover your campus differently'),

              currentAccountPicture: CircleAvatar(
                backgroundColor: orange,
                child: Icon(Icons.school, color: navy, size: 35),
              ),
            ),

            _drawerItem(icon: Icons.home, title: 'Home', index: 0),

            _drawerItem(
              icon: Icons.explore,
              title: 'Explore Facilities',
              index: 1,
            ),

            _drawerItem(
              icon: Icons.info_outline,
              title: 'About Application',
              index: 2,
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('Close Menu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: const [HomeScreen(), FacilityListScreen(), AboutScreen()],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: navy,
        selectedItemColor: orange,
        unselectedItemColor: Colors.white60,

        onTap: _changePage,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      selected: _currentIndex == index,
      selectedColor: orange,
      leading: Icon(icon),
      title: Text(title),

      onTap: () {
        Navigator.pop(context);
        _changePage(index);
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 190,
          pinned: true,
          backgroundColor: navy,
          foregroundColor: Colors.white,

          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Campus Explorer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [navy, blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: const Center(
                child: Icon(
                  Icons.account_balance_rounded,
                  size: 90,
                  color: Colors.white30,
                ),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Explorer!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Everything you need to discover campus life.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Featured Experience',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                const FeaturedCard(),

                const SizedBox(height: 25),

                const Text(
                  'Explore Campus',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final facility = facilities[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

              child: Card(
                elevation: 2,

                child: ListTile(
                  leading: Hero(
                    tag: 'facility_${facility.name}',
                    child: CircleAvatar(
                      backgroundColor: orange.withOpacity(0.2),
                      child: Icon(facility.icon, color: navy),
                    ),
                  ),

                  title: Text(
                    facility.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(facility.description),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FacilityDetailsScreen(facility: facility),
                      ),
                    );
                  },
                ),
              ),
            );
          }, childCount: 4),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

class FeaturedCard extends StatefulWidget {
  const FeaturedCard({super.key});

  @override
  State<FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<FeaturedCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,

        height: _expanded ? 175 : 130,
        width: double.infinity,

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: _expanded ? orange : navy,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.auto_awesome,
              color: _expanded ? navy : orange,
              size: 28,
            ),

            const SizedBox(height: 10),

            Text(
              _expanded
                  ? 'Your Campus, Your Journey!'
                  : 'Discover Something New',

              style: TextStyle(
                color: _expanded ? navy : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            if (_expanded)
              const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Text(
                  'Tap again to return to the original view.',
                  style: TextStyle(color: navy, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FacilityListScreen extends StatelessWidget {
  const FacilityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Explore 10 Campus Facilities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: facilities.length,

            itemBuilder: (context, index) {
              final facility = facilities[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),

                  leading: Hero(
                    tag: 'facility_${facility.name}',
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: orange.withOpacity(0.2),
                      child: Icon(facility.icon, color: navy),
                    ),
                  ),

                  title: Text(
                    facility.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(facility.description),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FacilityDetailsScreen(facility: facility),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FacilityDetailsScreen extends StatelessWidget {
  final Facility facility;

  const FacilityDetailsScreen({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(facility.name)),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'facility_${facility.name}',

                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: orange.withOpacity(0.2),

                  child: Icon(facility.icon, size: 65, color: navy),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                facility.name,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                facility.description,
                textAlign: TextAlign.center,

                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 35),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Directory'),

                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _showFirst = true;
  bool _showFooter = true;

  final List<Map<String, dynamic>> features = [
    {'name': 'Learning', 'icon': Icons.school, 'color': Color(0xFFE3F2FD)},
    {'name': 'Technology', 'icon': Icons.computer, 'color': Color(0xFFE8F5E9)},
    {'name': 'Research', 'icon': Icons.biotech, 'color': Color(0xFFFFF3E0)},
    {'name': 'Sports', 'icon': Icons.sports, 'color': Color(0xFFFCE4EC)},
    {'name': 'Community', 'icon': Icons.groups, 'color': Color(0xFFEDE7F6)},
    {'name': 'Innovation', 'icon': Icons.lightbulb, 'color': Color(0xFFFFF9C4)},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Our Application',

            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Campus Explorer helps students discover '
            'university facilities and campus activities '
            'through a simple and organized interface.',

            style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.6),
          ),

          const SizedBox(height: 22),

          GestureDetector(
            onTap: () {
              setState(() {
                _showFirst = !_showFirst;
              });
            },

            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              sizeCurve: Curves.bounceOut,

              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,

              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: const Text(
                  'OUR VISION\nTap to discover more',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              secondChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: const Text(
                  'Making campus exploration easier '
                  'and more enjoyable for every student.',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'What You Can Discover',

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 15),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: features.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),

            itemBuilder: (context, index) {
              final item = features[index];

              return Card(
                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: item['color'] as Color,

                      child: Icon(
                        item['icon'] as IconData,
                        size: 32,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      item['name'] as String,

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 22),

          Center(
            child: Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _showFooter ? 1.0 : 0.2,

                  child: const Column(
                    children: [
                      Icon(Icons.school, size: 38, color: navy),

                      SizedBox(height: 8),

                      Text(
                        'Campus Explorer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: navy,
                          fontSize: 17,
                        ),
                      ),

                      Text(
                        'Discover your campus differently.',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _showFooter = !_showFooter;
                    });
                  },
                  child: const Text('Toggle Visibility'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
