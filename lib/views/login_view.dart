import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/provider.dart';
import '../widgets/dialog/privacy_policy_cialog.dart';
import '../widgets/dialog/term_service_dialog.dart';
import 'main_view.dart';
import 'home_view.dart';

class loginView extends ConsumerWidget {
  const loginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider);
    

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: authNotifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: Image.asset('assets/love.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Closure',
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Bringing Friends Closer",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    IntrinsicWidth(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(authNotifierProvider.notifier)
                                .signInWithGoogle()
                                .then((_) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainView(),
                                ),
                              );
                            }).catchError((error) {
                              // Tangani error di sini
                              print('Error during Google Sign-In: $error');
                            });
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xFFF8595F)),
                          ),
                          child: const Text(
                            "Continue with Google",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "By creating an account, you agree with our",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => TermsOfServiceDialog.show,
                          child: const Text(
                            "Term of Service",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                        ),
                        const Text(
                          " and ",
                          style: TextStyle(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () => PrivacyPolicyDialog.show,
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
