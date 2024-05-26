import 'package:flutter/material.dart';
import 'dart:convert'; // JSON 데이터 처리를 위한 패키지
import 'package:http/http.dart' as http; // HTTP 요청을 위한 패키지
import 'mainPage.dart';

<<<<<<< HEAD
class LoginPage extends StatelessWidget {
  int id = 0; // 입력된 아이디
  String password = ''; // 입력된 비밀번호

  Future<void> _login(BuildContext context, int id, String password) async {
    // 로그인 정보를 JSON으로 저장DDD
=======
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

  // id에 접근할 수 있는 getter 메서드 추가
  int get userId => _LoginPageState()._id;
}

class _LoginPageState extends State<LoginPage> {
  int _id = 2; // 입력된 아이디
  String password = ''; // 입력된 비밀번호

  Future<void> _login(BuildContext context, int id, String password) async {
    // 로그인 정보를 JSON으로 저장
>>>>>>> origin/master
    Map<String, dynamic> loginData = {
      'id': id,
      'password': password,
    };

    // JSON 데이터로 변환
    String jsonData = jsonEncode(loginData);

    // POST 요청 보내기
    final response = await http.post(
      Uri.parse('http://180.64.40.88:8211/login'),
      headers: <String, String>{
        'Content-Type': 'application/json', // 파일 타입을 JSON으로 명시
      },
      body: jsonData,
    );

    // 응답 처리
    if (response.statusCode == 200) {
      // 로그인 성공 시 MainPage로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      // 로그인 실패 시 에러 메시지 출력
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('서버로부터 응답을 받지 못했습니다. 상태 코드: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  onChanged: (value) {
<<<<<<< HEAD
                    id = int.parse(value); // 아이디 입력값 저장
=======
                    setState(() {
                      _id = int.parse(value); // 아이디 입력값 저장
                    });
>>>>>>> origin/master
                  },
                  decoration: InputDecoration(
                    hintText: '아이디',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  onChanged: (value) {
<<<<<<< HEAD
                    password = value; // 비밀번호 입력값 저장
=======
                    setState(() {
                      password = value; // 비밀번호 입력값 저장
                    });
>>>>>>> origin/master
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 330,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
<<<<<<< HEAD
                    _login(context, id, password); // 로그인 함수 호출
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
=======
                    _login(context, _id, password); // 로그인 함수 호출
>>>>>>> origin/master
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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

<<<<<<< HEAD

=======
>>>>>>> origin/master
