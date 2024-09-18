import 'package:flutter/material.dart';

class PrivacyPolicyDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Privacy Policy"),
          content: const SingleChildScrollView(
            child: Text("Privacy Policy\n\n"
                "1. Introduction\n\n"
                "We are committed to protecting the privacy of users of the anonymous chat friend application (\"Closure\"). "
                "This Privacy Policy explains how we collect, use, and protect your personal information when you use our Application.\n\n"
                "2. Information We Collect\n\n"
                "2.1 Usage Information: We may collect information about how you use the Application, including your interactions with Application features, activity logs, and other technical information such as IP address, device type, and operating system.\n\n"
                "2.2 Anonymous Information: Given the anonymous nature of the Application, we do not collect personally identifiable information such as names, addresses, or phone numbers.\n\n"
                "3. Use of Information\n\n"
                "3.1 Service Improvement: The information we collect is used to enhance the performance and user experience of the Application, fix bugs, and develop new features.\n\n"
                "3.2 Security: We use the information to maintain the security of the Application and to prevent unlawful or harmful actions by users.\n\n"
                "4. Sharing Information\n\n"
                "4.1 Third Parties: We do not sell, rent, or trade users' personal information to third parties.\n\n"
                "4.2 Legal Compliance: We may disclose information if required by law or if we believe that such action is necessary to comply with legal processes, protect our rights, or ensure the safety of users.\n\n"
                "5. Information Security\n\n"
                "We implement appropriate security measures to protect information from unauthorized access, alteration, disclosure, or destruction. However, no method of data transmission over the internet or electronic storage is 100% secure.\n\n"
                "6. User Rights\n\n"
                "6.1 Access and Update: You have the right to access and update the information we have about you. Given the anonymous nature of the Application, this right may be limited.\n\n"
                "6.2 Deletion: You can request the deletion of your data at any time by contacting us through the contact information provided in the Application.\n\n"
                "7. Changes to the Privacy Policy\n\n"
                "We may update this Privacy Policy from time to time. Changes will be effective immediately upon the posting of the updated Privacy Policy in the Application. We will notify you through the Application or other means if significant changes occur.\n\n"
                "8. Contact Us\n\n"
                "If you have any questions or concerns about this Privacy Policy, you can contact us via email at [your email] or through the contact feature in the Application.\n\n"
                "9. Consent\n\n"
                "By using the Application, you consent to the collection and use of information in accordance with this Privacy Policy.\n\n"
                "10. Effective Date\n\n"
                "This Privacy Policy is effective as of [07-31-2024]."),
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
