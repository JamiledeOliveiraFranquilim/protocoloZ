import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class DeviceMediaRepository {
  DeviceMediaRepository(this.client);
  final SupabaseClient client;
  final ImagePicker picker = ImagePicker();
  Future<File?> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source, imageQuality: 82, maxWidth: 1600);
    return picked == null ? null : File(picked.path);
  }
  Future<String> upload({required File file, required String bucket, required String path}) async {
    final ext = file.path.split('.').last.toLowerCase();
    await client.storage.from(bucket).upload(path, file, fileOptions: FileOptions(upsert: true, contentType: ext == 'png' ? 'image/png' : 'image/jpeg'));
    return client.storage.from(bucket).getPublicUrl(path);
  }
}
