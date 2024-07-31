import 'package:flutter/material.dart';
import 'package:mvp_front/Screen/HomeScreen.dart';
import 'package:provider/provider.dart';
import '../Service/AuthService.dart';
import '../main.dart'; // MyHomePage 임포트

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthService>(context, listen: false).signOut();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회원 탈퇴'),
          content: Text('정말 회원 탈퇴 하시겠습니까? 이 작업은 되돌릴 수 없습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthService>(context, listen: false).deleteAccount();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (authService.isLoggedIn) ...[
                Text(
                  '${authService.userName}님 환영합니다!',
                  style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'font1',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  '로그인 한 계정: ${authService.userEmail}',
                  style: const TextStyle(
                      color: Colors.green, fontFamily: 'font1', fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () => _showLogoutDialog(context),
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                ),
                const SizedBox(height: 20), // 버튼 간 간격 추가
                ElevatedButton(
                  onPressed: () => _showDeleteAccountDialog(context),
                  child: const Text(
                    '회원 탈퇴',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                ),
              ] else ...[
                const Text('로그인 해주세요!',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'font1',
                        fontSize: 24,
                        fontWeight: FontWeight.bold))
              ],
            ],
          ),
        ),
      ),
    );
  }
}