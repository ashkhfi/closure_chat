import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/love.png',
                width: 30,
                height: 30,
              ),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: const ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // await UserController.signOut();
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool('login', false);
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => const LoginPage(),
          // ));
        },
        child: const Text("Logout"),
      ),
    );
  }
}