import 'package:flutter/material.dart';
import 'user_info.dart';
import 'dart:async'; // Timer를 사용하기 위해 import
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WASP',
      theme: ThemeData(
        primaryColor: const Color(0xFFEE8F00),
        scaffoldBackgroundColor: Colors.white, // 기본 배경색을 흰색으로 설정
      ),
      home: const SplashScreen(), // SplashScreen을 home으로 설정
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3초 후에 GreetingScreen으로 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GreetingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFEE8F00), // 스플래시 화면 배경색
      body: Center(
        child: Text(
          '장수말벗',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // 텍스트 색상
          ),
        ),
      ),
    );
  }
}

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  GreetingScreenState createState() => GreetingScreenState();
}

class GreetingScreenState extends State<GreetingScreen> {
  @override
  void initState() {
    super.initState();
    // 애니메이션이 끝난 후 NameSetScreen으로 이동
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NameSetScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '환영합니다\n지금부터 당신의 말벗에게\n이름을 지어줄 거에요!',
              textStyle: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // 텍스트를 가운데 정렬
              speed: const Duration(milliseconds: 95),
            ),
          ],
          totalRepeatCount: 1,
        ),
      ),
    );
  }
}

class NameSetScreen extends StatelessWidget {
  const NameSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0), // 상하좌우 40의 여백
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140.0,
              height: 140.0,
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE), // 배경색 설정
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 20.0), // 동그라미와 텍스트 사이의 간격
            const Text(
              '말벗의 애칭을\n정해주세요',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // 텍스트 색상 설정
                height: 1.25, // 줄 간격 설정
              ),
              textAlign: TextAlign.center, // 텍스트를 가운데 정렬
            ),
            const SizedBox(height: 20.0),
            const Text(
              '추후 환경설정에서 다시 정할 수 있어요.',
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFF828282), // 텍스트 색상 설정
              ),
              textAlign: TextAlign.center, // 텍스트를 가운데 정렬
            ),
            const SizedBox(height: 50.0), // 텍스트와 TextField 사이의 간격
            const NameTextField(), // NameTextField 사용
            const SizedBox(height: 20.0), // 텍스트와 버튼 사이의 간격
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE8F00), // 배경색 주황색 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0, // 수직 여백
                  horizontal: 191.0, // 수평 여백
                ),
              ),
              child: const Text(
                '확인',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // 볼드체 설정
                  color: Colors.white, // 텍스트 색상 흰색 설정
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

class NameTextField extends StatefulWidget {
  const NameTextField({super.key});

  @override
  NameTextFieldState createState() => NameTextFieldState();
}

class NameTextFieldState extends State<NameTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // 배경색 설정
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
          borderSide: const BorderSide(
            color: Color(0xFFEE8F00), // 기본 테두리 색상 설정
            width: 2.0, // 기본 테두리 굵기 설정
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
          borderSide: const BorderSide(
            color: Color(0xFFEE8F00), // 활성화된 상태의 테두리 색상
            width: 2.0, // 활성화된 상태의 테두리 굵기 설정
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
          borderSide: const BorderSide(
            color: Color(0xFFEE8F00), // 포커스된 상태의 테두리 색상
            width: 2.0, // 포커스된 상태의 테두리 굵기 설정
          ),
        ),
        hintText: focusNode.hasFocus ? '' : '장수말벗',
        hintStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold, // 볼드체 설정
          color: Color(0xFFA6A6A6), // 힌트 텍스트 색상 설정
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 28.0, // 수직 여백
          horizontal: 35.0, // 수평 여백
        ),
      ),
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold, // 볼드체 설정
      ),
      textAlign: TextAlign.center, // 텍스트 가운데 정렬
    );
  }
}
