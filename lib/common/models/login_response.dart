class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int status;
  final List<String> role;
  final List<dynamic> permissions;
  final int expiresIn;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.role,
    required this.permissions,
    required this.expiresIn,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      status: json['status'] ?? 0,
      role: (json['role'] as List?)?.map((e) => e.toString()).toList() ?? [],
      permissions: json['permissions'] ?? [],
      expiresIn: json['expires_in'] ?? 0,
    );
  }
}
