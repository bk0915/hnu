// 패키지 관리
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
// 페이지 import
import 'busReservation.dart';
import 'noticePage.dart';
import 'myPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController();
  // 드래그 시트가 열려 있는지 여부를 저장하는 변수
  bool isSheetOpen = false;

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
      body: Stack(
        children: [
          // 버튼을 누르지 않아도 드래그시트 닫는 기능 추가
          GestureDetector(
            onTap: () {
              setState(() {
                isSheetOpen = false;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F0F0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 프로필 사진
                      Container(
                        height: 190,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              width: 139,
                              height: 152,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/profile.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 운행 정보 Text
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '운행 정보',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '시간 안내',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // QR 버튼
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              // 버튼 클릭 시 드래그 시트 동작
                              setState(() {
                                isSheetOpen = !isSheetOpen;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'QR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // 버스 예약 버튼
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5), // 좌우 padding 값 설정
                    child: ElevatedButton(
                      onPressed: () {
                        // 버튼 클릭 시 예약 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BusReservation()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.red, width: 1),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bus_alert,
                            color: Colors.grey,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '버스 예약',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // 슬라이드 뷰
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5), // 좌우 여백 설정
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView(
                          controller: controller,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Page 1'),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Page 2'),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Page 3'),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.red,
                              spacing: 12,
                              radius: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // QR 코드 드래그 시트
          isSheetOpen
              ? DraggableSheetPage()
              : SizedBox(), // 아무것도 표시되지 않게 함
        ],
      ),

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

class DraggableSheetPage extends StatefulWidget {
  @override
  _DraggableSheetPageState createState() => _DraggableSheetPageState();
}

class _DraggableSheetPageState extends State<DraggableSheetPage> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)), // 상단에만 곡률을 부여
            border: Border( // 테두리
              top: BorderSide(color: Colors.grey, width: 2.0),
              left: BorderSide(color: Colors.grey, width: 2.0),
              right: BorderSide(color: Colors.grey, width: 2.0),
            ),
          ),
          // 드래그시트 내용 추가
          child: Column(
            children: [
              SizedBox(height: 12),
              QrImageView(
                data: 'QR 코드 데이터', // 여기에 QR 코드를 생성할 데이터 입력
                version: QrVersions.auto,
                size: 180,
              ),
              SizedBox(height: 12),

              // 하단에 정보 출력
              Expanded(
                child: Column(
                  children: [
                    // 출발지 및 목적지
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.red, // Set the color of the top border
                            width: 2.0, // Set the width of the top border
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '출발지',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 5), // Add space between the two texts
                                Text(
                                  '경로1',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward,
                            size: 50,
                          ),
                          SizedBox(width: 20),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '목적지',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 5), // Add space between the two texts
                                Text(
                                  '경로2',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 출발시간과 좌석번호
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey, // Set the color of the top border
                            width: 1.0, // Set the width of the top border
                          ),
                          bottom: BorderSide(
                            color: Colors.grey, // Set the color of the bottom border
                            width: 1.0, // Set the width of the bottom border
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0), // Add margin to the container
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '출발시간',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Add space between the two texts
                                  Text(
                                    '08:00',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '도착시간',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Add space between the two texts
                                  Text(
                                    '10:00',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0), // Add margin to the container
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '좌석번호',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Add space between the two texts
                                  Text(
                                    '15',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 예매취소 버튼
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0), // Optional: add border radius for rounded corners
                      ),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child: Text(
                          '예매취소',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ),
            ],
          ),
        );
      },
    );
  }
}
