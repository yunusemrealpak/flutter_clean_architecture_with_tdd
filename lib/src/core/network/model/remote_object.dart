abstract class RemoteObject<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
