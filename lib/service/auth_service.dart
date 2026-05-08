class AuthService {
  Future<String?> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 4));
    return "rerere";
  }
}
