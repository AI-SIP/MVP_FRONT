import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Service/AuthService.dart';
import '../Service/UserService.dart';
import '../main.dart'; // MyHomePage 임포트

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final UserService userService = UserService();

  Future<Map<String, dynamic>> getUserInfo(AuthService authService) async {
    if (authService.isLoggedIn) {
      return await userService.getUserInfo();
    } else {
      return {};
    }
  }

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
                await Provider.of<AuthService>(context, listen: false)
                    .signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage()), // MyHomePage로 이동
                );
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
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return FutureBuilder<Map<String, dynamic>>(
          future: getUserInfo(authService),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || !authService.isLoggedIn) {
                print('Error: ${snapshot.error}');
                return const Center(child: Text('로그인 해주세요!'));
              } else if (snapshot.hasData && authService.isLoggedIn) {
                return Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data!['userName']}님 환영합니다!',
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '로그인 한 계정: ${snapshot.data!['userEmail']}',
                            style: const TextStyle(
                                color: Colors.green, fontSize: 16),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () => _showLogoutDialog(context),
                            child: const Text(
                              '로그아웃',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
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
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}