import 'package:finplan/helper/dbhelper.dart';
import 'package:finplan/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finplan/providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String developerName = "Muhammad Faris Hadi Mulyo";
  String developerNim = "2141764150";

  final DbHelper dbHelper = DbHelper();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get user data
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Ubah Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password Saat Ini"),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: "Password Baru",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(_obscureText
                        ? Icons.visibility
                        : Icons.visibility_off)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              child: const Text("Simpan Password Baru"),
            ),
            const SizedBox(height: 40),
            const Text(
              "Developer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/profile.jpeg'), // Gantilah dengan path gambar Anda
              radius: 50,
            ),
            const SizedBox(height: 10),
            Text(developerName),
            Text(developerNim),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.email!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
