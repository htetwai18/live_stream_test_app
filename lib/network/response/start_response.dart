class StartResponse {
  String? cname;
  String? uid;
  String? resourceId;
  String? sid;

  StartResponse({this.cname, this.uid, this.resourceId, this.sid});

  StartResponse.fromJson(Map<String, dynamic> json) {
    cname = json['cname'];
    uid = json['uid'];
    resourceId = json['resourceId'];
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cname'] = this.cname;
    data['uid'] = this.uid;
    data['resourceId'] = this.resourceId;
    data['sid'] = this.sid;
    return data;
  }
}
