import 'package:facechat/constants/constants_value.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/constants_colors.dart';
import '../../../utils/local_utils.dart';

class FaceChatScreen extends StatefulWidget {
  final String chatId;
  const FaceChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  State<FaceChatScreen> createState() => _FaceChatScreenState();
}

class _FaceChatScreenState extends State<FaceChatScreen> {
  int? _remoteUid;
  bool _isJoined = false;
  late RtcEngine _agoraEngine;
  final ClientRoleType _roleType = ClientRoleType.clientRoleBroadcaster;

  Future<void> initialize() async {
    await [Permission.microphone, Permission.camera].request();

    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine.initialize(
      const RtcEngineContext(appId: kAgoraAppId),
    );

    await _agoraEngine.enableVideo();

    _agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(context, message: '000이 참가했습니다.');
          setState(() => _isJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage(context, message: '$remoteUid유저가 참가했습니다.');
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage(context, message: '$remoteUid유저가 참가했습니다.');
          setState(() => _remoteUid = null);
        },
      ),
    );
  }
  
  void join()async{
    await _agoraEngine.startPreview();
    
    ChannelMediaOptions options = ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kFontGray800Color,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: AgoraVideoView(
              controller: VideoViewController(
                  rtcEngine: _agoraEngine, canvas: VideoCanvas(uid: 0)),
            ),
          ),
        ],
      ),
    );
  }
}
