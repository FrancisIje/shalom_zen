import 'dart:io';

abstract class StorageProvider {
  Future<String> uploadFile(File file);
  Future<void> deleteFile(String filePath);
}
