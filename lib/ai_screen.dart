
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';


class AudiosCallWithThicherScreen extends StatefulWidget {

  const AudiosCallWithThicherScreen({super.key});
  @override
  State<AudiosCallWithThicherScreen> createState() => _AudiosCallWithThicherScreenState();
}
/// ✅ Tutor Model
class Tutor {
  final int id;
  final String name;

  Tutor({required this.id, required this.name});
}

/// ✅ Language Model
class Language {
  final int id;
  final String name;

  Language({required this.id, required this.name});
}

class _AudiosCallWithThicherScreenState extends State<AudiosCallWithThicherScreen> {
  static const String domain = "https://zetumartai.thesyndicates.team";
  static const String generateSessionUrl = "$domain/api/ai/generate-session";
  String userText = ""; // ✅ Add this
  final String _ = "";
  String aiBuffer = "";
  bool isAiResponding = false;

  bool isTextVisible = true; // your existing variable
  final String model = "gpt-realtime-mini";
  final String voice = "alloy";

  RTCPeerConnection? pc;
  RTCDataChannel? dc;
  MediaStream? localStream;
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  bool loading = true;
  bool connected = false;
  bool isMicOn = true;

  String? ephemeralToken;

  /// ✅ Tutors
  List<Tutor> tutors = [
    Tutor(id: 1, name: "Maria"),
    Tutor(id: 2, name: "John"),
    Tutor(id: 3, name: "Alice"),
  ];


  /// ✅ Languages
  List<Language> languages = [
    Language(id: 1, name: "English"),
    Language(id: 2, name: "Somali"),
    Language(id: 54, name: "Bangla"),
    Language(id: 4, name: "Hindi"),
  ];

  Tutor? selectedTutor;
  Language? selectedLanguage;

  /// ✅ Logger
  void log(String message, {String type = "INFO"}) {
    final prefix = {
      "INFO": "ℹ️",
      "SUCCESS": "✅",
      "ERROR": "❌",
      "AI": "🤖",
      "MIC": "🎤",
      "API": "🌐",
      "WEBRTC": "🔗",
    }[type] ?? "ℹ️";

    debugPrint("[$prefix][$type] $message");
  }

  String selectedName = 'Maria';
  String selectedCountry = 'English';
  final int totalSeconds = 4 * 60; // 4 minutes
  int remainingSeconds = 4 * 60;
  Timer? lessonTimer;
  bool isMicActive = false;

  bool isAnimating = false;
  final FlutterTts _flutterTts = FlutterTts();
  Future<void> _init() async {
    await _remoteRenderer.initialize();
    _start();
  }


  Future<void> _start() async {
    if (connected) {
      log("Already connected", type: "INFO");
      return;
    }

    setState(() {
      loading = true;
      connected = false;
    });

    await Permission.microphone.request();

    try {
      ephemeralToken = await _getToken();
      await _connect(ephemeralToken!);

      setState(() => connected = true);
      log("Connected successfully", type: "SUCCESS");
    } catch (e) {
      log("INIT ERROR: $e", type: "ERROR");
    } finally {
      setState(() => loading = false);
    }
  }



  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);

    await _flutterTts.speak(text);
  }

  Future<void> _connect(String token) async {
    log("Creating PeerConnection...", type: "WEBRTC");

    pc = await createPeerConnection({"iceServers": []});

    dc = await pc!.createDataChannel("oai-events", RTCDataChannelInit());

    dc!.onDataChannelState = (state) {
      log("DataChannel: $state", type: "WEBRTC");

      if (state == RTCDataChannelState.RTCDataChannelOpen) {
        dc!.send(RTCDataChannelMessage(jsonEncode({
          "type": "session.update",
          "session": {
            "voice": voice,
            "turn_detection": {
              "type": "server_vad",
              "silence_duration_ms": 800,
              "create_response": true
            }
          }
        })));
      }
    };





    dc!.onMessage = (msg) {
      try {
        final data = jsonDecode(msg.text);

        /// 🎤 USER TRANSCRIPTION
        if (data["type"] ==
            "conversation.item.input_audio_transcription.completed") {

          final text = (data["transcript"] ?? "").trim();
          if (text.isEmpty) return;

          log("USER: $text", type: "MIC");

          setState(() {
            userText = "User: $text";
          });

          /// ✅ Add user message to conversation
          dc?.send(RTCDataChannelMessage(jsonEncode({
            "type": "conversation.item.create",
            "item": {
              "type": "message",
              "role": "user",
              "content": [
                {
                  "type": "input_text",
                  "text": text
                }
              ]
            }
          })));

          /// ✅ Prevent multiple AI calls
          if (!isAiResponding) {
            isAiResponding = true;

            /// ✅ Trigger AI response (NO input here)
            dc?.send(RTCDataChannelMessage(jsonEncode({
              "type": "response.create"
            })));
          } else {
            log("AI already responding, skipping...", type: "INFO");
          }
        }

        /// 🤖 AI STREAMING
        if (data["type"] == "response.output_text.delta") {
          final delta = data["delta"] ?? "";
          aiBuffer += delta;

          log("AI STREAM: $delta", type: "AI");

          setState(() {
            userText = "AI: $aiBuffer";
          });
        }

        /// 🤖 AI DONE
        if (data["type"] == "response.output_text.done") {
          final finalAi = aiBuffer.trim();

          if (finalAi.isNotEmpty) {
            log("AI: $finalAi", type: "AI");

            setState(() {
              userText = "AI: $finalAi";
            });

            speak(finalAi);
          }

          aiBuffer = "";
          isAiResponding = false; // ✅ RESET
        }

        /// ❌ ERROR HANDLING
        if (data["type"] == "error") {
          log("AI ERROR: ${data["error"]}", type: "ERROR");

          isAiResponding = false; // ✅ RESET on error
        }

      } catch (e) {
        log("Parse error: $e", type: "ERROR");
      }
    };


    pc!.onTrack = (event) {
      if (event.track.kind == 'audio') {
        _remoteRenderer.srcObject = event.streams[0];
      }
    };

    /// 🎤 Mic
    localStream = await navigator.mediaDevices.getUserMedia({
      "audio": true,
      "video": false,
    });

    for (final t in localStream!.getAudioTracks()) {
      await pc!.addTrack(t, localStream!);
    }

    final offer = await pc!.createOffer({"offerToReceiveAudio": 1});
    await pc!.setLocalDescription(offer);

    final res = await http.post(
      Uri.parse("https://api.openai.com/v1/realtime?model=$model"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/sdp",
        "OpenAI-Beta": "realtime=v1",
      },
      body: offer.sdp,
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception("SDP failed");
    }

    await pc!.setRemoteDescription(
      RTCSessionDescription(res.body, "answer"),
    );

    log("WebRTC connected", type: "SUCCESS");
  }



  void triggerAI() {
    if (dc == null) return;

    if (isAiResponding) {
      log("AI busy...", type: "INFO");
      return;
    }

    isAiResponding = true;

    dc!.send(RTCDataChannelMessage(jsonEncode({
      "type": "response.create"
    })));
  }

  Future<String> _getToken() async {
    log("Requesting session...", type: "API");

    try {
      final res = await http.post(
        Uri.parse(generateSessionUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "model": model,
          "voice": voice,
          "silence_duration_ms": 800,
          "transcription": true,
          "transcription_model": "gpt-4o-mini-transcribe",

          /// ✅ ensure NOT null
          "tutor_id": selectedTutor?.id ?? 1,
          "language_id": selectedLanguage?.id ?? 1,
        }),
      );

      log("Status: ${res.statusCode}", type: "API");
      log("Response: ${res.body}", type: "API");

      if (res.statusCode < 200 || res.statusCode >= 300) {
        throw Exception("Laravel API failed: ${res.body}");
      }

      final data = jsonDecode(res.body);

      // ✅ safe extraction
      final token = data["data"]?["client_secret"];

      if (token == null || token.toString().isEmpty) {
        throw Exception("Token missing in response");
      }

      return token.toString();
    } catch (e) {
      log("❌ Token Error: $e", type: "ERROR");
      rethrow;
    }
  }
  Future<void> startAiSession() async {
    log("Starting AI session...", type: "AI");

    if (dc != null &&
        dc!.state == RTCDataChannelState.RTCDataChannelOpen) {

      dc!.send(RTCDataChannelMessage(jsonEncode({
        "type": "response.create"
      })));

    } else {
      log("DataChannel not ready", type: "ERROR");
    }
  }

  @override
  void initState() {
    super.initState();
    // aiRxObj.aiFun(
    //   tutor_id: selectedTutor!.id,
    //   language_id: selectedLanguage!.id,
    // );
    super.initState();
    selectedTutor = tutors.first;
    selectedLanguage = languages.first;
    _init();
    startTimer();
  }

  void startTimer() {
    lessonTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        lessonTimer?.cancel();
      }
    });
  }

  void stopTimer() {
    lessonTimer?.cancel();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  double get progress => remainingSeconds / totalSeconds;

  void toggleMic() async {
    if (!isMicActive) {
      /// ✅ TURN ON AI + MIC
      setState(() {
        isMicActive = true;
      });

      startTimer();

      _toggleMicEnable(true);

      /// ✅ Ensure AI is connected before starting session
      if (pc == null || dc == null) {
        await _start(); // connect WebRTC if not connected
      }

      await startAiSession();

    } else {
      /// ❌ TURN OFF AI + MIC
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return StopRecordingBottomSheet(
            onYes: () async {
              stopTimer();

              _toggleMicEnable(false);

              /// ✅ FULL AI STOP
              await _disconnect();

              setState(() {
                isMicActive = false;
              });

              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);

            },
          );
        },
      );
    }
  }

  void _toggleMicEnable(bool enable) {
    if (localStream == null) return;

    for (var t in localStream!.getAudioTracks()) {
      t.enabled = enable;
    }

    setState(() => isMicOn = enable);

    log(enable ? "Mic ON" : "Mic OFF", type: "MIC");
  }

  bool isTapped = false; // tap state
  bool _isTapped2 = false; // tap state
  bool isTapped3 = false;






  Future<void> _disconnect() async {
    log("Disconnecting...", type: "WEBRTC");

    try {
      dc?.close();
      await pc?.close();
      localStream?.getTracks().forEach((t) => t.stop());
      _remoteRenderer.srcObject = null;
    } catch (_) {}

    dc = null;
    pc = null;
    localStream = null;

    setState(() => connected = false);
  }

  @override
  void dispose() {
    lessonTimer?.cancel();
    _disconnect();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 2,
        actions: const [
          SizedBox(height: 16,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                GestureDetector(
                  onTap: () {

                  },
                  child: Image.asset('assets/icons/clasow.png', height: 40),
                ),
              ],
            ),
          SizedBox(height: 18,),

            /// Dropdown Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      final selected = await showMenu<Tutor>(
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                        items: tutors.map((tutor) {
                          return PopupMenuItem<Tutor>(
                            value: tutor,
                            child: Text(tutor.name),
                          );
                        }).toList(),
                      );

                      if (selected != null) {
                        setState(() {
                          selectedTutor = selected;
                          selectedName = selected.name; // UI text only
                        });

                        log("Tutor changed: ${selected.name}");

                        /// 🔥 restart AI with new tutor
                        await _disconnect();
                        await _start();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A75F),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/User.svg'),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              selectedName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SvgPicture.asset('assets/icons/Alt Arrow Down.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 55),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final selected = await showMenu<Language>(
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                        items: languages.map((lang) {
                          return PopupMenuItem<Language>(
                            value: lang,
                            child: Text(lang.name),
                          );
                        }).toList(),
                      );

                      if (selected != null) {
                        setState(() {
                          selectedLanguage = selected;
                          selectedCountry = selected.name; // UI text
                        });

                        log("Language changed: ${selected.name}");

                        /// 🔥 restart AI with new language
                        await _disconnect();
                        await _start();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A75F),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              selectedCountry,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset('assets/icons/Alt Arrow Down.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

 SizedBox(height: 14,),

            /// Main content with flexible height
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 11,
                    color: CupertinoColors.activeBlue.withOpacity(0.1),
                    shape: const CircleBorder(),
                    child: Center(
                      child: Image.asset('assets/images/AvterImage.png',fit: BoxFit.cover,width: 263.46,
                        height: 263.46,),
                    ),
                  ),

                  SizedBox(height: 14,),

                  CircularPercentIndicator(
                    radius: 90,
                    lineWidth: 10.0,
                    percent: progress,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.white12,
                    progressColor: const Color(0xFF00A75F),
                    center: Text(
                      formatTime(remainingSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
           SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTextVisible = !isTextVisible;
                      });
                    },
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        child: isTextVisible
                            ? Text(
                          userText.isEmpty
                              ? "Listening..."
                              : userText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFBBBBBF),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        )
                            : SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isTapped2 = !_isTapped2;
                });

                if (_isTapped2) {

                } else {

                }
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: _isTapped2 ? Colors.red : const Color(0xFF00A75F),
                child: Image.asset(
                  'assets/icons/Volume Loud.png',
                  height: 30,
                ),
              ),
            ),

            GestureDetector(
              onTap: toggleMic,
              child: Image.asset(
                isMicActive
                    ? 'assets/images/readMichImage.png'
                    : 'assets/icons/mickcw.png',
                height: 60,
                isAntiAlias: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isTextVisible = !isTextVisible;
                });
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: isTextVisible ?  const Color(0xFF00A75F) : Colors.red,
                child: Image.asset(
                  isTextVisible
                      ? 'assets/icons/subTitleIcon.png'
                      : 'assets/icons/subTitleIcon.png',
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


class StopRecordingBottomSheet extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onCancel;

  const StopRecordingBottomSheet({
    super.key,
    required this.onYes,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Stop Recording?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// ❌ Cancel
              ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text("Cancel"),
              ),

              /// ✅ Yes / Stop
              ElevatedButton(
                onPressed: onYes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text("Stop"),
              ),
            ],
          )
        ],
      ),
    );
  }
}