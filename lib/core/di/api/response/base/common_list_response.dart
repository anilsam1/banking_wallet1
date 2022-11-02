import 'package:flutter_demo_structure/core/di/api/response/base/base_response.dart';

class CommonListResponse<T> with BaseResponse<T> {
  CommonListResponse({data, message, code});

  /// We require a second parameter to be a Function, and we'll trigger
  /// this function for serializing results property
  factory CommonListResponse.fromJson(
          Map<String, dynamic> json, Function fromJson) =>
      CommonListResponse<T>().parseJson(json, fromJson);

  @override
  List<T> get dataModel {
    return data as List<T>;
  }
}
