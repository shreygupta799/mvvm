import 'package:mvvm/data/response/status.dart';

class ApiRespose<T> {
  Status? status;
  T? data;
  String? message;

  ApiRespose(this.status, this.data, this.message);

  ApiRespose.loading() : status = Status.LOADING;
  ApiRespose.completed() : status = Status.COMPLETED;
  ApiRespose.error() : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
