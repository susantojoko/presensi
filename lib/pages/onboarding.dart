import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'login.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'Selamat Datang',
      description: 'Selamat datang di aplikasi Absensi kami!',
      image: 'assets/animasi/animasi6.json',
    ),
    OnboardingItem(
      title: 'Fitur Pertama',
      description: 'Fitur pertama yang hebat di aplikasi ini adalah mudah digunakan. ada beberapa menu seperti menuabsen dan riwayat absen',
      image: 'assets/animasi/animasi5.json',
    ),
    OnboardingItem(
      title: 'Mulai Sekarang',
      description: 'Sekarang Anda siap untuk mulai menggunakan aplikasi kami.',
      image: 'assets/animasi/animasi4.json',
    ),
  ];

  final _pageControllerNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background3.png'), //background
            fit: BoxFit.cover,
          ),
       ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(_onboardingItems[index]);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: CirclePageIndicator(
                  selectedDotColor: Colors.blue,
                  dotColor: Colors.grey,
                  itemCount: _onboardingItems.length,
                  currentPageNotifier: _pageControllerNotifier,
                ),
              ),
            ),
            SizedBox(height: 20),
            _currentPage == _onboardingItems.length - 1
                ? Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                     color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        },
                        child: Text('Selesai', style: TextStyle(fontSize: 20),),
                      ),
                  ),
                )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        },
                        child: Text('Lewati'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Text('Berikutnya'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageControllerNotifier.value = _pageController.page!.round();
    });
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  OnboardingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          item.image,
          height: 200,
        ),
        SizedBox(height: 20),
        Text(
          item.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
