class ApiException implements Exception{
  String header;
  String msg;
  ApiException({required this.header,required this.msg});
  String toString(){
    return "$header:$msg" ;
  }
}
class UnauthorisedException extends ApiException{
  UnauthorisedException(String msg)
  : super(header: 'UnAuthorisedException',msg: msg);
}
class FetchhDataException extends ApiException{
  FetchhDataException (String msg)
      : super(header: 'DataExcepion',msg: msg);
}
class BadRequestException extends ApiException{
  BadRequestException(String msg)
      : super(header: 'BadRequestException',msg: msg);
}
class InvalidInputException extends ApiException{
  InvalidInputException(String msg)
      : super(header: 'InvalidInputException ',msg: msg);
}
