import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_test_app/network/request/aquire_request.dart';
import 'package:live_stream_test_app/network/request/start_request.dart';
import 'package:live_stream_test_app/network/request/stop_request.dart';
import 'package:live_stream_test_app/network/response/acquire_response.dart';
import 'package:live_stream_test_app/network/response/query_response.dart';
import 'package:live_stream_test_app/network/response/start_response.dart';
import 'package:live_stream_test_app/network/response/stop_response.dart';
import 'package:live_stream_test_app/network/service/api_agent.dart';
import 'package:live_stream_test_app/utils/app_id.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  /// dependency
  final ApiAgent _apiAgent = ApiAgent();
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  AcquireResponse? acquireResponse;
  String? acquireError;
  StartResponse? startResponse;
  String? startError;
  QueryResponse? queryResponse;
  String? queryError;
  StopResponse? stopResponse;
  String? stopError;
  int index = 0;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: APPID,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.enableAudio();
    await _engine.joinChannel(
      token: TOKEN,
      channelId: CHANNEL,
      uid: UID,
      options: const ChannelMediaOptions(),
    );
  }

  void onStartRecording() async {
    acquireResponse = null;
    startResponse = null;
    acquireError = null;
    startError = null;
    index = 1;
    var acRequest = AcquireRequest(
      cname: CHANNEL,
      uid: UID.toString(),
      clientRequest: ClientRequestAcquire(
        scene: 0,
        resourceExpiredHour: 24,
      ),
    );
    await _apiAgent.acquire(APPID, acRequest).then((res) async {
      acquireResponse = res;
      var startRequest = StartRequest(
        uid: UID.toString(),
        cname: CHANNEL,
        clientRequest: ClientRequestStart(
          token: TOKEN,
          recordingConfig: RecordingConfig(
            maxIdleTime: 86400,
            streamTypes: 2,
            audioProfile: 1,
            channelType: 1,
            videoStreamType: 0,
            transcodingConfig: TranscodingConfig(
              height: 640,
              width: 360,
              bitrate: 500,
              fps: 15,
              mixedVideoLayout: 1,
              backgroundColor: '#FF0000',
            ),
            subscribeVideoUids: ["123", "456"],
            subscribeAudioUids: ["123", "456"],
            subscribeUidGroup: 0,
          ),
          storageConfig: StorageConfig(
            vendor: 1,
            region: 2,
          /// b
            fileNamePrefix: ["directory1", "directory2"],
          ),
        ),
      );
      await _apiAgent
          .start(APPID, res.resourceId ?? "", startRequest)
          .then((stRes) {
        setState(() {
          startResponse = stRes;
        });
      }).onError((e, st) {
        setState(() {
          startError = e.toString();
        });
      });
    }).onError((e, st) {
      setState(() {
        acquireError = e.toString();
      });
    });
  }

  void onQuery() async {
    queryResponse = null;
    queryError = null;
    index = 2;
    await _apiAgent
        .query(APPID, startResponse?.resourceId ?? "", startResponse?.sid ?? "")
        .then((res) {
      setState(() {
        queryResponse = res;
      });
    }).onError((e, st) {
      setState(() {
        queryError = e.toString();
      });
    });
  }

  void onStop() async {
    stopResponse = null;
    stopError = null;
    index = 3;
    var req = StopRequest(
      cname: CHANNEL,
      uid: UID.toString(),
      clientRequest: ClientRequestStop(
        asyncStop: false,
      ),
    );
    await _apiAgent
        .stop(APPID, queryResponse?.resourceId ?? "", queryResponse?.sid ?? "",
            req)
        .then((response) {
      setState(() {
        stopResponse = response;
      });
    }).onError((e, st) {
      setState(() {
        stopError = e.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              onStartRecording();
            },
            child: const Text("Record"),
          ),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton(
            onPressed: () {
              onQuery();
            },
            child: const Text("Query"),
          ),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton(
            onPressed: () {
              onStop();
            },
            child: const Text("End"),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Center(
          //   child: _remoteVideo(),
          // ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Center(
              child: _localUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              width: 70,
              color: Colors.white,
              child: const Center(
                child: Text(
                  "0",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: startResponse != null && index == 1,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                        "Start recording api success\nHere is sid ==>${startResponse?.sid}"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: startError != null && index == 1,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "Start recording api failed\n$startError",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: queryResponse != null && index == 2,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                        "Query api success\nHere is query data ==>$queryResponse"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: queryError != null && index == 2,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "Query api failed\n$queryError",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: stopResponse != null && index == 3,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                        "Start recording api success\nHere is sid ==>${startResponse?.sid}"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: stopError != null && index == 3,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "Stop recording api failed\n$stopError",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: CHANNEL),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
