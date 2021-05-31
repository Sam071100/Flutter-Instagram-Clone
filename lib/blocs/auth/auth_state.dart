part of 'auth_bloc.dart';

// AuthState will be managing the users authentication in our app
enum AuthStatus { unkwown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final auth.User user;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.status = AuthStatus.unkwown,
  });

  factory AuthState.unknown() => const AuthState();

  factory AuthState.authenticated({@required auth.User user}) {
    return AuthState(user: user, status: AuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);
  @override
  bool get stringify => true; // Print out the authSattes
  @override
  List<Object> get props => [user, status];
}
