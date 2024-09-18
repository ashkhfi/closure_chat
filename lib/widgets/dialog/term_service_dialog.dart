import 'package:flutter/material.dart';

class TermsOfServiceDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms of Service"),
          content: const SingleChildScrollView(
            child: Text(
              "1. Introduction\n"
              "Welcome to Closure. By accessing or using our App, you agree to be bound by these Terms of Service (\"Terms\"). If you do not agree to these Terms, please do not use the App.\n\n"
              "2. Description of Service\n"
              "The App provides a platform for anonymous chatting with friends. Users can send and receive messages without revealing their identities.\n\n"
              "3. User Accounts\n"
              "To use the App, you may need to create an account. You agree to provide accurate and complete information when creating your account and to keep this information up-to-date. You are responsible for maintaining the confidentiality of your account and password and for all activities that occur under your account.\n\n"
              "4. Privacy Policy\n"
              "Our Privacy Policy explains how we collect, use, and protect your personal information. By using the App, you consent to the collection and use of your information as described in the Privacy Policy.\n\n"
              "5. User Conduct\n"
              "You agree not to use the App to:\n"
              "- Harass, threaten, or harm another person.\n"
              "- Transmit any content that is illegal, offensive, or otherwise objectionable.\n"
              "- Impersonate any person or entity or falsely state or otherwise misrepresent your affiliation with a person or entity.\n"
              "- Collect or store personal data about other users without their express permission.\n"
              "- Engage in any activity that disrupts or interferes with the App.\n\n"
              "6. Content\n"
              "You are responsible for the content you send through the App. We do not endorse, support, represent, or guarantee the completeness, truthfulness, accuracy, or reliability of any content.\n\n"
              "7. Termination\n"
              "We reserve the right to terminate or suspend your account and access to the App at our sole discretion, without notice and liability, for any reason, including if you breach these Terms.\n\n"
              "8. Intellectual Property\n"
              "All intellectual property rights in the App, including but not limited to software, text, images, and logos, are owned by us or our licensors. You agree not to copy, distribute, or create derivative works based on the App without our prior written consent.\n\n"
              "9. Disclaimer of Warranties\n"
              "The App is provided on an \"as is\" and \"as available\" basis. We make no warranties, express or implied, regarding the App, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement.\n\n"
              "10. Limitation of Liability\n"
              "In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from (a) your use or inability to use the App; (b) any unauthorized access to or use of our servers and/or any personal information stored therein; (c) any interruption or cessation of transmission to or from the App; (d) any bugs, viruses, trojan horses, or the like that may be transmitted to or through our App by any third party; or (e) any errors or omissions in any content or for any loss or damage incurred as a result of the use of any content posted, emailed, transmitted, or otherwise made available through the App, whether based on warranty, contract, tort (including negligence), or any other legal theory, whether or not we have been informed of the possibility of such damage.\n\n"
              "11. Changes to Terms\n"
              "We reserve the right to modify these Terms at any time. Your continued use of the App following the posting of any changes to the Terms constitutes acceptance of those changes.\n\n"
              "12. Governing Law\n"
              "These Terms shall be governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.\n\n"
              "13. Contact Information\n"
              "If you have any questions about these Terms, please contact us at Firmansyahvevo2@gmail.com",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
