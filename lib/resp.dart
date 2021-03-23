class Resp {
  final bool success;
  final String ecode;
  final List<dynamic> data;

  Resp({this.success, this.ecode, this.data});

  factory Resp.fromJson(Map<String, dynamic> json) {
    return Resp(
        success: json['success'], ecode: json['ecode'], data: json['data']);
  }
}
