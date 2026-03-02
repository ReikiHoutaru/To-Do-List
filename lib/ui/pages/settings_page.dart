import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.psychology),
            title: Text("API Key AI"),
            subtitle: Text("Konfigurasi API Gemini/OpenAI"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Tema Aplikasi"),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          const ListTile(
            leading: Icon(Icons.data_usage),
            title: Text("Sinkronisasi Data"),
            subtitle: Text("Cloud Sync"),
          ),
        ],
      ),
    );
  }
}