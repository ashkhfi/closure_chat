import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataState = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'Closure',
              //       style: TextStyle(
              //         fontSize: 24, // Ukuran teks
              //         fontWeight: FontWeight.bold, // Teks tebal
              //       ),
              //     ),
              //     const SizedBox(width: 10), // Tambahkan jarak antara teks dan gambar
              //     Image.asset(
              //       'assets/love.png',
              //       width: 30,
              //       height: 30,
              //     ),
              //   ],
              // ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: userDataState.when(
        data: (user) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0), // Pindahkan ke atas 10%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Closure',
                        style: TextStyle(
                          fontSize: 30, // Ukuran teks
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Tambahkan jarak antara teks dan gambar
                      Image.asset(
                        'assets/love.png',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:
                          20), // Tambahkan jarak antara teks dan foto profil
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.imageUrl.isNotEmpty ? user.imageUrl : '',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 100),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(text: 'Share your '),
                        TextSpan(
                          text: 'username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' and get '),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'receive',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text: 'messages.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' from your friends'),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height:
                          20), // Tambahkan jarak antara username dan teks baru
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 30, // Ukuran teks sama dengan 'Closure'
                      fontWeight: FontWeight.bold, // Teks tebal
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Tambahkan jarak antara username dan tombol
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF8595F), // Warna tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Sisi oval
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15), // Ukuran tombol
                    ),
                    onPressed: () {
                      // final username = user.isNotEmpty ? _userData[0]['username'] : '';
                      // Clipboard.setData(ClipboardData(text: username));
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Username copied to clipboard')),
                      // );
                    },
                    child: const Text(
                      'Copy Username',
                      style: TextStyle(
                        color: Colors.white, // Warna hint text
                        fontSize: 20, // Ukuran teks sama dengan username
                        fontWeight: FontWeight.bold, // Teks tebal
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
