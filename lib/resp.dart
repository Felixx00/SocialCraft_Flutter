class Resp {
  final bool success;
  final String ecode;
  final Map<String, dynamic> data;
  final List <dynamic> list;

  Resp({this.success, this.ecode, this.data, this.list});

  factory Resp.fromJson(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        data: json['data'],
      );
    } else {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        data: null,
      );
    }
  }
  factory Resp.fromJson2(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        list: json['data'],
      );
    } else {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        list: null,
      );
    }
  }
  factory Resp.modificar(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        data: null,
      );
    } else {
      return Resp(
        success: json['success'],
        ecode: json['ecode'],
        data: null,
      );
    }
  }
}
