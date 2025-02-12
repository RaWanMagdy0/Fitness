import 'api_result.dart';

Future<Result<T>> executeApiCall<T>(
  Future<T> Function() apiCall,
) async {
  try {
    var result = await apiCall.call();
    return Success(data: result);
  } on Exception catch (e) {
    return Fail(exception: e);
  }
}
