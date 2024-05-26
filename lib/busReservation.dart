import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// 다른 페이지 import
import 'mainPage.dart';
import 'noticePage.dart';
import 'myPage.dart';
import 'loginPage.dart' as loginPage;

class BusReservation extends StatefulWidget {
  @override
  _BusReservation createState() => _BusReservation();
}

class _BusReservation extends State<BusReservation> {
  final controller = PageController();
  // 드래그 시트가 열려 있는지 여부를 저장하는 변수
  bool isSheetOpen = false;

  // 등하교 정보를 저장dd
  String tripType = '등교'; // 초기값을 '등교'로 설정

  // 목적지 정보를 선택했는지 확인
  bool isFirstSelected = true;
  List<bool> isSecondSelected = [true, false, false, false];
  List<bool> isThirdSelected = List.generate(17, (_) => false);

  // 정거장 리스트
  List<List<String>> stationLists = [
    // 도안
    ['가수원 파출소 승강장', '린풀하우스 승강장', '수목토 승강장', '목원대 네거리 승강장', '트리플시티 9단지 정거장',
    '청학동 양푼이 동태찌개 도로변', '유성온천역 2번 출구 버스 승강장', '갈마1동주민센터 버스 승강장', '탄방동 SK브로드밴드 승강장',
    '시청역7번출구 버스 승강장', '국화아파트 승강장'],
    // 세종, 노은
    ['세종소방서', '센트럴A 905동 도로 옆', '범지기마을112동 옆', '가락마을2003동 건너편', '푸르지오A1020동 뒤편',
    ' 도램마을 803동 버스승강장', '청사북쪽 지선승강장', '청사남쪽 지선승강장', '나성동 버스승강장', '첫마을 지선 승강장',
    '시외버스터미널', '반석역 승강장', '극동방송국 승강장', '노은역 승강장', '온천2동 주민센터 승강장', '월평중 버스승강장',
    '정부청사역 버스승강장'],
    // 계룡, 진잠
    ['성원A 승강장', '계룡시외버스 터미널', '계룡고등학교 맞은편', '두계사 입구', '진잠4거리 SK주유소 앞', '건양대병원 4거리',
    '가수원 육교', '정림동 세영프라자', '도마 e편한 세상 버스승강장', '유천시장 입구', '서대전 네거리', '오룡역 7번출구'],
    // 가오, 판암
    ['가오동네거리 새마을금고', '판암역 전자랜드', '신흥동 시외버스 매표소 건너', '대동역 5번출구', '대전역 대한통운']
  ];
  // 버스 ID 리스트
  List<String> busIdList = ['1154','1155','1156','1157'];

  // GET 호출 내용 출력
<<<<<<< HEAD
  void _requestSeat(String busId) async {
    try {
      Map<String, dynamic> printData = await RequestSeat().getReservation(busId);
      print('Bus ID: ${printData['busId']}');
      print('Type: ${printData['type'] ? '등교' : '하교'}');
      print('Seat Numbers: ${printData['seatNumbers']}');
    } catch (e) {
      print(e);
=======
  Future<Map<String, dynamic>> _requestSeat(String busId, String tripType) async {
    try {
      Map<String, dynamic> reservationData = await RequestSeat().getReservation(busId, tripType);
      print('Bus ID: ${reservationData['busId']}');
      print('Type: ${reservationData['type'] ? '등교' : '하교'}');
      print('Seat Numbers: ${reservationData['seatNumbers']}');
      return reservationData;
    } catch (e) {
      print(e);
      throw Exception('Failed to get reservation data');
>>>>>>> origin/master
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 최상단 appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

      // 예약 화면
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 등교 혹은 하교를 체크할 수 있는 부분
            SizedBox(height: 30),
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 등교, 하교 체크박스
            InkWell(
              onTap: () {
                setState(() {
                  tripType = '등교';
                });
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tripType == '등교' ? Colors.black : Colors.grey,
                ),
                child: Icon(Icons.check, color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Text(
              '등교',
              style: TextStyle(
                color: tripType == '등교' ? Colors.black : Colors.grey,
                fontSize: 30,
              ),
            ),
            SizedBox(width: 80),
            InkWell(
              onTap: () {
                setState(() {
                  tripType = '하교';
                });
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tripType == '하교' ? Colors.black : Colors.grey,
                ),
                child: Icon(Icons.check, color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Text(
              '하교',
              style: TextStyle(
                color: tripType == '하교' ? Colors.black : Colors.grey,
                fontSize: 30,
              ),
            ),
          ],
        ),
            SizedBox(height: 30),

            // 출발지와 목적지 정보
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tripType == '등교' ? '출발지를\n선택하세요' : '한남대학교',
                style: TextStyle(
                  fontSize: 28,
                  color: tripType == '등교' ? Colors.grey : Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_right,
                size: 56,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                tripType == '등교' ? '한남대학교' : '목적지를\n선택하세요',
                style: TextStyle(
                  fontSize: 28,
                  color: tripType == '등교' ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
            SizedBox(height: 20),

            // 목적지 설정
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2, color: Colors.red), // 상단 테두리 추가
                  ),
                ),
                child: Row(
                  children: [
                    // 시내, 시외 선택 버튼
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey, // 우측에 회색 경계선 추가
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (){
                              // 클릭 시 동작처리
                              setState(() {
                                isFirstSelected = true;
                              });
                            },
                            child: Row(
                              children: [
                                // 선택 시 체크 표시
                                isFirstSelected ? Icon(Icons.check, color: Colors.black) : SizedBox(width: 22),
                                Text(
                                  '시내',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isFirstSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              // 클릭 시 동작처리
                              setState(() {
                                isFirstSelected = false;
                              });
                            },
                            child: Row(
                              children: [
                                isFirstSelected ? SizedBox(width: 22) : Icon(Icons.check, color: Colors.black),
                                Text(
                                  '시외',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isFirstSelected ? Colors.grey : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 노선 선택
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey, // 우측에 회색 경계선 추가
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < isSecondSelected.length; i++)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  // 선택된 항목의 인덱스를 업데이트하고 다른 항목들은 선택 해제
                                  for (var j = 0; j < isSecondSelected.length; j++) {
                                    if (j == i) {
                                      isSecondSelected[j] = true;
                                    } else {
                                      isSecondSelected[j] = false;
                                    }
                                  }
                                });
                              },
                              child: Text(
                                isFirstSelected
                                    ? ['도안', '세종, 노은', '계룡, 진잠', '가오, 판암'][i]
                                    : i == 0 ? '천안, 청주' : '',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isSecondSelected[i] ? Colors.black : Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // 목적지 설정
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var i = 0; i < isSecondSelected.length; i++)
                              if (isSecondSelected[i])
                                for (var j = 0; j < stationLists[i].length; j++)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        // 선택된 항목의 인덱스를 업데이트하고 다른 항목들은 선택 해제
                                        for (var k = 0; k < isThirdSelected.length; k++) {
                                          isThirdSelected[k] = (k == j && !isThirdSelected[k]);
                                        }
                                      });

                                      if (isThirdSelected[j]) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Text(
                                                '\n${stationLists[i][j]}을/를 선택하시겠습니까?',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
<<<<<<< HEAD
                                                onPressed: () {
                                                  // 잔여 좌석 요청
                                                  _requestSeat(busIdList[i]);

                                                  // 좌석 선택으로 이동
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => SeatSelector()),
                                                  );
                                                },
                                                child: Text('확인'),
                                              ),
=======
                                                onPressed: () async {
                                                  try {
                                                    Map<String, dynamic> reservationData = await _requestSeat(busIdList[i],tripType);

                                                    // 받은 데이터 사용
                                                    String receivedBusId = reservationData['busId'];
                                                    bool receivedType = reservationData['type'];
                                                    List<bool> receivedSeatNumbers = reservationData['seatNumbers'];

                                                    // 좌석 선택으로 이동
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => SeatSelector(
                                                        receivedSeatNumbers: receivedSeatNumbers,
                                                        busId: receivedBusId,
                                                        type: receivedType ? '등교':'하교',
                                                      )),
                                                    );
                                                  } catch (e) {
                                                    // 예외 처리
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => BusReservation()),
                                                    );
                                                  }
                                                },
                                                child: Text('확인'),
                                              ),

>>>>>>> origin/master
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    // "취소" 버튼을 눌렀을 때 선택된 값을 다시 false로 설정
                                                    isThirdSelected[j] = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('취소'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      stationLists[i][j],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isThirdSelected[j] ? Colors.black : Colors.grey, // 선택되었을 때 글씨 색상 변경
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                          ],
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

<<<<<<< HEAD
class SeatSelector extends StatefulWidget{
=======
class SeatSelector extends StatefulWidget {
  final List<bool> receivedSeatNumbers;
  final String busId;
  final String type;

  SeatSelector({
    required this.receivedSeatNumbers,
    required this.busId,
    required this.type,
  });

>>>>>>> origin/master
  @override
  _SeatSelector createState() => _SeatSelector();
}

class _SeatSelector extends State<SeatSelector> {
<<<<<<< HEAD
  List<bool> _selectedSeats = List.generate(45, (_) => false); // 45개의 좌석 상태를 관리하는 리스트
=======
  late List<bool> _selectedSeats;

  @override
  void initState() {
    super.initState();
    _selectedSeats = widget.receivedSeatNumbers;
  }
>>>>>>> origin/master

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
<<<<<<< HEAD

      ),

=======
      ),
>>>>>>> origin/master
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int row = 0; row < 10; row++) // 처음 10줄 생성
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeat(row * 4), // 왼쪽 첫 번째 좌석
                _buildSeat(row * 4 + 1), // 왼쪽 두 번째 좌석
                SizedBox(width: 40), // 가운데 빈 공간
                _buildSeat(row * 4 + 2), // 오른쪽 첫 번째 좌석
                _buildSeat(row * 4 + 3), // 오른쪽 두 번째 좌석
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int col = 0; col < 5; col++) // 마지막 줄은 5개 좌석
                _buildSeat(40 + col),
            ],
          ),
        ],
      ),
<<<<<<< HEAD

=======
>>>>>>> origin/master
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

  Widget _buildSeat(int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              '\n${index + 1}번 좌석을 선택하시겠습니까?',
              style: TextStyle(fontSize: 18),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSeats[index] = true; // 확인을 누르면 해당 좌석을 선택으로 변경
                  });

                  // 첫 번째 다이얼로그를 닫기 전에 확인 메시지 다이얼로그를 보여줌
                  Navigator.of(context).pop(); // 첫 번째 다이얼로그 닫기

<<<<<<< HEAD
=======
                  // sendSeat 호출
                  sendSeat().makeReservation(widget.type, int.parse(widget.busId), index + 1);

>>>>>>> origin/master
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        '\n예약이 완료되었습니다',
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // 메인페이지로 다시 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          },
                          child: Text('확인'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('확인'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
            ],
          ),
        ).then((confirmed) {
          if (!confirmed) { // 확인이 아닌 경우 선택이 되지 않도록 설정
            setState(() {
              _selectedSeats[index] = false;
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Opacity(
          opacity: _selectedSeats[index] ? 0.5 : 1.0, // 선택된 좌석의 투명도 설정
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/seat.png', // 좌석 이미지 경로
                width: 40,
                height: 40,
              ),
              Text(
                '${index + 1}', // 좌석 번호
                style: TextStyle(
                  color: _selectedSeats[index] ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

<<<<<<< HEAD
// 좌석 정보를 요청
class RequestSeat {
  Future<Map<String, dynamic>> getReservation(String busNumber) async {
=======

// 좌석 정보를 요청
class RequestSeat {
  Future<Map<String, dynamic>> getReservation(String busNumber, String tripType) async {
>>>>>>> origin/master
    final String baseUrl = "http://180.64.40.88:8211/reservation/available-seats";

    // 쿼리 파라미터를 URL에 추가
    final uriWithParams = Uri.parse(baseUrl).replace(
      queryParameters: {
<<<<<<< HEAD
        'busNumber': busNumber,
=======
        'busId': busNumber,
        'type': tripType
>>>>>>> origin/master
      },
    );

    // GET 요청 보내기
    final response = await http.get(uriWithParams);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      // 초기화
      String busId = '';
      bool type = false;
      List<bool> seatNumbers = List.filled(45, false);

      // 데이터 추출 및 처리
      for (var item in jsonResponse) {
        busId = item['id']['busId'].toString();
        type = item['bus']['type'] == '등교';
        int seatNumber = item['id']['seatNumber'] - 1; // 좌석 번호는 1부터 시작하므로 인덱스는 -1
        seatNumbers[seatNumber] = true; // 해당 좌석 번호의 인덱스만 true로 설정
      }

      // 결과 반환
      return {
        'busId': busId,
        'type': type,
        'seatNumbers': seatNumbers,
      };
    } else {
      print('실패 ${response.statusCode}');
      throw Exception('Failed to load reservations');
    }
  }
}

// 예약 정보를 전송
class sendSeat {
<<<<<<< HEAD
  Future<void> makeReservation(String type, int busId, int seatNumber, DateTime reservationTime) async {
    final String baseUrl = "http://180.64.40.88:8211/reservation";
    int studentId = loginPage.LoginPage().id;

    // 예약 정보를 JSON 형식으로 변환
    Map<String, dynamic> reservationData = {
      'type' : type,
      'busId': busId,
      'seatNumber': seatNumber,
      'reservationTime': reservationTime.toIso8601String(),
      'studentId': studentId,
=======
  Future<void> makeReservation(String type, int busId, int seatNumber) async {
    final String baseUrl = "http://180.64.40.88:8211/reservation/enroll";
    int studentId = loginPage.LoginPage().userId;
    DateTime reservationTime = DateTime.now(); // 현재 시간 저장

    // 예약 정보를 JSON 형식으로 변환
    Map<String, dynamic> reservationData = {
      'user_id': studentId,
      'type' : type,
      'bus_id': busId,
      'seat_number': seatNumber,
      'date': reservationTime.toIso8601String(),
>>>>>>> origin/master
    };

    // JSON 데이터로 변환
    String jsonData = jsonEncode(reservationData);

    // POST 요청 보내기
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    // 응답 처리
<<<<<<< HEAD
    //
=======
>>>>>>> origin/master
    if (response.statusCode == 200) {
      print('Reservation successful');
    } else {
      print('Reservation failed with status code: ${response.statusCode}');
      throw Exception('Failed to make reservation');
    }
  }
}