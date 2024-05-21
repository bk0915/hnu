import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'noticePage.dart';

class myPage extends StatefulWidget{
  @override
  _myPage createState() => _myPage();
}

class _myPage extends State<myPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 최상단 appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              Container(
                width: 165,
                child: Image.asset('assets/images/logo.jpg'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/images/notice_icon.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              // 동작 처리
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => noticePage()),
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/menu_icon.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              // 동작 처리
            },
          ),
        ],

      ),

      // 프로필 정보
      body: Container(),

      // 바텀바 구성
      // 홈버튼(플로팅버튼)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 65,
        height: 65,
        margin: EdgeInsets.only(top: 30), // 아래로 이동시키기 위한 마진 설정
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          tooltip: 'Increment',
          shape: const CircleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                child: Image.asset(
                  'assets/images/homebutton_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 1), // 텍스트와 이미지 사이의 간격 조정
              Text(
                '홈',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      // 바텀바
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // 지도로 이동
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/map_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '지도',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // 배차표로 이동
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/BusRoute_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '노선정보',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                      ),
                    ),
                  ],
                ),
              ),
              // 중앙에 여백
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  // 마이페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myPage()),
                  );
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/myPage_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '내 정보',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // 설정으로 이동
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/setting_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '설정',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}