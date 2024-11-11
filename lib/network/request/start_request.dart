class StartRequest {
  String? uid;
  String? cname;
  ClientRequestStart? clientRequest;

  StartRequest({this.uid, this.cname, this.clientRequest});

  StartRequest.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    cname = json['cname'];
    clientRequest = json['clientRequest'] != null
        ? new ClientRequestStart.fromJson(json['clientRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['cname'] = this.cname;
    if (this.clientRequest != null) {
      data['clientRequest'] = this.clientRequest!.toJson();
    }
    return data;
  }
}

class ClientRequestStart {
  String? token;
  RecordingConfig? recordingConfig;
  StorageConfig? storageConfig;

  ClientRequestStart({this.token, this.recordingConfig, this.storageConfig});

  ClientRequestStart.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    recordingConfig = json['recordingConfig'] != null
        ? new RecordingConfig.fromJson(json['recordingConfig'])
        : null;
    storageConfig = json['storageConfig'] != null
        ? new StorageConfig.fromJson(json['storageConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.recordingConfig != null) {
      data['recordingConfig'] = this.recordingConfig!.toJson();
    }
    if (this.storageConfig != null) {
      data['storageConfig'] = this.storageConfig!.toJson();
    }
    return data;
  }
}

class RecordingConfig {
  int? maxIdleTime;
  int? streamTypes;
  int? audioProfile;
  int? channelType;
  int? videoStreamType;
  TranscodingConfig? transcodingConfig;
  List<String>? subscribeVideoUids;
  List<String>? subscribeAudioUids;
  int? subscribeUidGroup;

  RecordingConfig(
      {this.maxIdleTime,
        this.streamTypes,
        this.audioProfile,
        this.channelType,
        this.videoStreamType,
        this.transcodingConfig,
        this.subscribeVideoUids,
        this.subscribeAudioUids,
        this.subscribeUidGroup});

  RecordingConfig.fromJson(Map<String, dynamic> json) {
    maxIdleTime = json['maxIdleTime'];
    streamTypes = json['streamTypes'];
    audioProfile = json['audioProfile'];
    channelType = json['channelType'];
    videoStreamType = json['videoStreamType'];
    transcodingConfig = json['transcodingConfig'] != null
        ? new TranscodingConfig.fromJson(json['transcodingConfig'])
        : null;
    subscribeVideoUids = json['subscribeVideoUids'].cast<String>();
    subscribeAudioUids = json['subscribeAudioUids'].cast<String>();
    subscribeUidGroup = json['subscribeUidGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxIdleTime'] = this.maxIdleTime;
    data['streamTypes'] = this.streamTypes;
    data['audioProfile'] = this.audioProfile;
    data['channelType'] = this.channelType;
    data['videoStreamType'] = this.videoStreamType;
    if (this.transcodingConfig != null) {
      data['transcodingConfig'] = this.transcodingConfig!.toJson();
    }
    data['subscribeVideoUids'] = this.subscribeVideoUids;
    data['subscribeAudioUids'] = this.subscribeAudioUids;
    data['subscribeUidGroup'] = this.subscribeUidGroup;
    return data;
  }
}

class TranscodingConfig {
  int? height;
  int? width;
  int? bitrate;
  int? fps;
  int? mixedVideoLayout;
  String? backgroundColor;

  TranscodingConfig(
      {this.height,
        this.width,
        this.bitrate,
        this.fps,
        this.mixedVideoLayout,
        this.backgroundColor});

  TranscodingConfig.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    bitrate = json['bitrate'];
    fps = json['fps'];
    mixedVideoLayout = json['mixedVideoLayout'];
    backgroundColor = json['backgroundColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    data['bitrate'] = this.bitrate;
    data['fps'] = this.fps;
    data['mixedVideoLayout'] = this.mixedVideoLayout;
    data['backgroundColor'] = this.backgroundColor;
    return data;
  }
}

class StorageConfig {
  int? vendor;
  int? region;
  String? bucket;
  String? accessKey;
  String? secretKey;
  List<String>? fileNamePrefix;

  StorageConfig(
      {this.vendor,
        this.region,
        this.bucket,
        this.accessKey,
        this.secretKey,
        this.fileNamePrefix});

  StorageConfig.fromJson(Map<String, dynamic> json) {
    vendor = json['vendor'];
    region = json['region'];
    bucket = json['bucket'];
    accessKey = json['accessKey'];
    secretKey = json['secretKey'];
    fileNamePrefix = json['fileNamePrefix'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor'] = this.vendor;
    data['region'] = this.region;
    data['bucket'] = this.bucket;
    data['accessKey'] = this.accessKey;
    data['secretKey'] = this.secretKey;
    data['fileNamePrefix'] = this.fileNamePrefix;
    return data;
  }
}
