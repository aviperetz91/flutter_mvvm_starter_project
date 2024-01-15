enum Status { initial, loading, completed, error }

class ApiResponse<T> {
  Status status;
  T? data;
  int? errorCode;
  String? errorMessage;

  ApiResponse.initial() : status = Status.initial;

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.errorCode, this.errorMessage) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $errorMessage \n Data : $data";
  }
}
