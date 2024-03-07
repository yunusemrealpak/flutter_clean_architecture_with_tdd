import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_with_email_and_password_params.g.dart';

@JsonSerializable(createFieldMap: false)
final class SignInWithEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });

  const SignInWithEmailAndPasswordParams.test()
      : email = '_test_email',
        password = '_test_password';

  Map<String, dynamic> toJson() => _$SignInWithEmailAndPasswordParamsToJson(this);

  @override
  List<Object> get props => [email, password];
}
