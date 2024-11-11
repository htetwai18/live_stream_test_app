class ApiConstants {
  static acquire(String appId) =>
      'https://api.agora.io/v1/apps/$appId/cloud_recording/acquire';
  static start(String appId, String resourceId) =>
      'https://api.agora.io/v1/apps/$appId/cloud_recording/resourceid/$resourceId/mode/mix/start';
  static query(String appId, String resourceId, String sid) =>
      'https://api.agora.io/v1/apps/$appId/cloud_recording/resourceid/$resourceId/sid/$sid/mode/mix/query';
  static stop(String appId, String resourceId, String sid) =>
      'http://api.agora.io/v1/apps/$appId/cloud_recording/resourceid/$resourceId/sid/$sid/mode/mix/stop';
}
