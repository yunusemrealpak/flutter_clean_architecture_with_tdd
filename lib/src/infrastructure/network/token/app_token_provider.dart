import 'package:injectable/injectable.dart';

import '../../../core/network/token/token_provider.dart';

@Injectable(as: ITokenProvider)
class AppTokenProvider implements ITokenProvider {
  @override
  Future<String?> getToken() async {
    // Proje özelinde, token'ı local storage / secure storage'dan çekin
    // Basit bir sabit değer döndürelim (örnek)
    return 'sample_token_123';
  }

  @override
  Future<void> clearToken() async {
    // Token'ı silme işlemi (varsa)
  }
}
