import 'package:agora_uikit/agora_uikit.dart';
import 'package:facechat/constants/constants_value.dart';
import 'package:facechat/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants_colors.dart';
import '../../../utils/local_utils.dart';

class FaceChatScreen extends StatefulWidget {
  final String chatId;
  final String rtcToken;
  const FaceChatScreen({Key? key, required this.chatId, required this.rtcToken})
      : super(key: key);

  @override
  State<FaceChatScreen> createState() => _FaceChatScreenState();
}

class _FaceChatScreenState extends State<FaceChatScreen> {
  late AgoraClient _client;

  @override
  void initState() {
    super.initState();
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: kAgoraAppId,
        channelName: widget.chatId,
        tempToken: widget.rtcToken,
      ),
    );
    _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: _client,
            layoutType: Layout.oneToOne,
            renderModeType: RenderModeType.renderModeFit,
          ),
          AgoraVideoButtons(
            client: _client,
            enabledButtons: const [
              BuiltInButtons.toggleCamera,
              BuiltInButtons.callEnd,
              BuiltInButtons.toggleMic,
            ],
          ),
        ],
      ),
    );
  }
}
