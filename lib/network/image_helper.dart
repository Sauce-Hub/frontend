library;

const String _storageBaseUrl =
    'https://backend-production-3bbb.up.railway.app/storage/';

String buildImageUrl(String? path) {
  if (path == null || path.isEmpty) {
    return '';
  }

  if (path.startsWith('http://') ||
      path.startsWith('https://')) {
    return path;
  }

  final cleanPath =
  path.startsWith('/') ? path.substring(1) : path;

  return '$_storageBaseUrl$cleanPath';
}