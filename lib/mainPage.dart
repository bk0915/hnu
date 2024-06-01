// 패키지 관리
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

// 페이지 import
import 'busReservation.dart';
import 'noticePage.dart';
import 'myPage.dart';
import 'loginPage.dart';
import 'settingPage.dart';

class MainPage extends StatefulWidget {
  static Map<String, dynamic>? reservationData;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController();
  // 드래그 시트가 열려 있는지 여부를 저장하는 변수
  bool isSheetOpen = false;
  int userId = LoginPage.user_id;
  String Url() {
    return 'http://180.64.40.88:8211/resource/img/$userId';
  }

  @override
  void initState() {
    super.initState();
    _loadReservationData();
  }

  // 유저 정보를 reservationData에 저장
  Future<void> _loadReservationData() async {
    try {
      var result = await RequestInformation().getReservation(userId);
      setState(() {
        MainPage.reservationData = result;
        print(MainPage.reservationData);
      });
    } catch (e) {
      print(e);
    }
  }

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
                      // 프로필
                      Container(
                        height: 190,
                        child: Row(
                          children: [
                            // 사진
                            Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                              width: 139,
                              height: 152,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(Url()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 운행 정보 Text
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 목적지 정보 출력
                                  Text(
                                    MainPage.reservationData?['name'] != null
                                        ? '${MainPage.reservationData?['name']}'
                                        : '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    MainPage.reservationData?['route'] != null
                                        ? '노선: ${MainPage.reservationData?['route']}(${MainPage.reservationData?['type']})'
                                        : '예약 정보 없음',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    MainPage.reservationData?['end_point'] != null
                                        ? '목적지: ${MainPage.reservationData?['end_point']}'
                                        : '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    softWrap: true,
                                  ),
                                  // 정거장 이름
                                  SizedBox(height: 10),
                                  // 시간 정보 출력
                                  Text(
                                    MainPage.reservationData?['date'] != null
                                        ? '예약일: ${MainPage.reservationData?['date']}'
                                        : '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
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
                            onPressed: (){
                              _loadReservationData();
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
                      '노선',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // 커뮤니티로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => noticePage()),
                  );
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/board_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '커뮤니티',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
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
  String date = MainPage.reservationData?['date'];
  int SeatNumber = MainPage.reservationData?['seatNumber'];
  String endPoint = MainPage.reservationData?['end_point'];
  String type = MainPage.reservationData?['type'];

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
                data: '데이터',
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
                      height: 110,
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
                          // 출발지 컨테이너
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 출발지 텍스트
                                Text(
                                  '[ 출발지 ]',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 5),
                                // 출발지 내용
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    type == '등교' ? '한남대학교' : endPoint,
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
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
                          // 목적지 컨테이너
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 목적지 텍스트
                                Text(
                                  '[ 목적지 ]',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 5),
                                // 목적지 내용
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Text(
                                    type == '등교' ? endPoint : '한남대학교',
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
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
                                    '[ 출발일 ]',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Add space between the two texts
                                  Text(
                                    date.isNotEmpty ? date : ' ',
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
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0), // Add margin to the container
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '[ 좌석번호 ]',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Add space between the two texts
                                  Text(
                                    SeatNumber != 0 ? SeatNumber.toString() : ' ',
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
                      height: 45,
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RequestInformation {
  Future<Map<String, dynamic>> getReservation(int userId) async {
    final String baseUrl = "http://180.64.40.88:8211/reservation/user-information";

    // 쿼리 파라미터를 URL에 추가
    final uriWithParams = Uri.parse(baseUrl).replace(
      queryParameters: {
        'userId': userId.toString()
      },
    );

    // GET 요청 보내기
    final response = await http.get(uriWithParams);
    //print('Sending GET request to $uriWithParams');

    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      print(jsonResponse);

      // 초기화
      String type = '';
      String route = ''; // 초기화한 route 변수 추가
      String busId = '';
      int seatNumber = -1;
      String endPoint = '';
      bool isChecked = false;
      String date = '';
      String name = '';

      // 데이터 추출 및 처리
      if (jsonResponse != null) {
        var seat = jsonResponse['seat'];
        if (seat != null) {
          var seatId = seat['id'];
          var bus = seat['bus'];
          if (seatId != null) {
            busId = seatId['busId'].toString();
            seatNumber = seatId['seatNumber'];
            type = seatId['type'];
          }
          if (bus != null) {
            route = bus['endPoint']; // route 값을 버스의 endPoint로 설정
          }
        }
        endPoint = jsonResponse['endPoint'] ?? ''; // 최상위 endPoint 값 설정
        date = jsonResponse['date'] ?? '';
        isChecked = jsonResponse['checked'] ?? false;
        var user = jsonResponse['user'];
        if (user != null) {
          name = user['name'] ?? '';
        }
      }

      // null 값 처리
      if (busId.isEmpty || type.isEmpty || seatNumber == -1 || endPoint.isEmpty || date.isEmpty) {
        print('Null이므로 빈 맵을 반환');
        return {}; // 빈 맵 반환
      }

      // 결과 출력
      print('Bus ID: $busId, Type: $type, Seat Number: $seatNumber, End Point: $endPoint, Route: $route, Name: $name, Date: $date, Is Checked: $isChecked');

      // 결과 반환
      return {
        'type': type,
        'busId': busId,
        'seatNumber': seatNumber,
        'end_point': endPoint,
        'route': route,
        'name': name,
        'is_checked': isChecked,
        'date': date,
      };

    }

    else {
      print('실패 ${response.statusCode}');
      throw Exception('Failed to load reservations');
    }
  }
}