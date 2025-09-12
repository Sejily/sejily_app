import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class GoogleDriveService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveReadonlyScope, 'email'],
    clientId:
        '497464249440-nak09g227c1du1ltntrqlbj6b3nm32b3.apps.googleusercontent.com',
  );

  GoogleSignInAccount? _currentUser;

  Future<bool> signIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
      return _currentUser != null;
    } catch (e) {
      print('Google Sign-In error: $e');
      return false;
    }
  }

  Future<List<drive.File>> listFiles() async {
    if (_currentUser == null) return [];

    final authHeaders = await _currentUser!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);

    final fileList = await driveApi.files.list(
      pageSize: 50,
      $fields: "files(id,name,mimeType,size)",
    );

    return fileList.files ?? [];
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
