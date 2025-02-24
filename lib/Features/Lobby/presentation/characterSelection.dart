import 'package:flutter/material.dart';

class CharacterSelectionScreen extends StatefulWidget {
  @override
  _CharacterSelectionScreenState createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late PageController _pageController;



  final List<Map<String, String>> _characters = [
    {'name': 'Mask Dude', 'image': 'assets/images/Environment/Characters/Mask_Dude/Idle_(32x32).png'},
    {'name': 'Ninja Frog', 'image': 'assets/images/Environment/Characters/Ninja_Frog/Idle_(32x32).png'},
    {'name': 'Pink Man', 'image': 'assets/images/Environment/Characters/Pink_Man/Idle_(32x32).png'},
    {'name': 'Virtual Guy', 'image': 'assets/images/Environment/Characters/Virtual_Guy/Idle_(32x32).png'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _pageController = PageController(viewportFraction: 0.3, initialPage: _selectedIndex);
  }

  void _changeCharacter(int direction) {
    setState(() {
      _selectedIndex = (_selectedIndex + direction) % _characters.length;
      if (_selectedIndex < 0) _selectedIndex = _characters.length - 1;
      _controller.reset();
      _controller.forward();
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Hình nền
            Positioned.fill(
              child: Image.asset(
                'assets/images/Environment/Characters/Desappearing_(96x96).png',
                fit: BoxFit.cover, // Lấp đầy màn hình
              ),
            ),

            Column(
              children: [
                // Nút quay lại
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.orange, size: 40),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10),
                // Hiển thị hình nhân vật đã chọn (to hơn nhưng không gây tràn)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        _characters[_selectedIndex]['name']!,
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        _characters[_selectedIndex]['image']!,
                        height: 300, // Giảm từ 400px xuống 300px để tránh tràn
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Khu vực danh sách nhân vật + nút điều hướng
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_left, color: Colors.white, size: 80),
                            onPressed: () => _changeCharacter(-1),
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.6, // Mở rộng vùng hiển thị
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              itemCount: _characters.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    _pageController.animateToPage(
                                      index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selectedIndex == index ? Colors.yellow : Colors.transparent,
                                        width: 5,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Image.asset(_characters[index]['image']!, height: 60),
                                  ),
                                );
                              },
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.arrow_right, color: Colors.white, size: 80),
                            onPressed: () => _changeCharacter(1),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Nút Bắt đầu
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, _characters[_selectedIndex]['name']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Bắt đầu',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Giao diện xu
            Positioned(
              top: 20,
              right: 20,
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.yellow, size: 28),
                  SizedBox(width: 5),
                  Text('1000', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
