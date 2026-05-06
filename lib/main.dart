// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:permission_handler/permission_handler.dart';
// //
// // void main() {
// //   runApp(const QuranApp());
// // }
// //
// // class QuranApp extends StatelessWidget {
// //   const QuranApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Quran Reciter',
// //       theme: ThemeData(
// //         primarySwatch: Colors.green,
// //         textTheme: TextTheme(
// //           bodyLarge: GoogleFonts.amiri(fontSize: 30),
// //         ),
// //       ),
// //       home: const SurahFatihahScreen(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }
// //
// // class SurahFatihahScreen extends StatefulWidget {
// //   const SurahFatihahScreen({super.key});
// //
// //   @override
// //   State<SurahFatihahScreen> createState() => _SurahFatihahScreenState();
// // }
// //
// // class _SurahFatihahScreenState extends State<SurahFatihahScreen> {
// //   // সুরা ফাতিহার আয়াত (শব্দে শব্দে বিভক্ত করার জন্য)
// //   final List<String> ayat = [
// //     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
// //     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
// //     'الرَّحْمَٰنِ الرَّحِيمِ',
// //     'مَالِكِ يَوْمِ الدِّينِ',
// //     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
// //     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
// //     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
// //   ];
// //
// //   final List<String> translations = [
// //     'পরম করুণাময় অতি দয়ালু আল্লাহর নামে শুরু করছি।',
// //     'সমস্ত প্রশংসা আল্লাহর জন্য, যিনি সকল সৃষ্টির রব।',
// //     'পরম করুণাময়, অতি দয়ালু।',
// //     'বিচার দিবসের মালিক।',
// //     'আমরা শুধু তোমারই ইবাদত করি এবং শুধু তোমার কাছেই সাহায্য চাই।',
// //     'আমাদের সরল পথ দেখাও।',
// //     'সেই পথ যাদের প্রতি তুমি অনুগ্রহ করেছ, যারা তোমার গজবের শিকার নয় এবং যারা পথভ্রষ্ট নয়।',
// //   ];
// //
// //   late List<String> allWords;
// //   late List<bool> visible;
// //   late List<bool> isWrong;
// //
// //   final stt.SpeechToText _speech = stt.SpeechToText();
// //   bool _speechReady = false;
// //   bool _isListening = false;
// //   String _spokenText = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     allWords = ayat.expand((a) => a.split(' ')).toList();
// //     visible = List.generate(allWords.length, (_) => false);
// //     isWrong = List.generate(allWords.length, (_) => false);
// //
// //     _initSpeech();
// //   }
// //
// //   Future<void> _initSpeech() async {
// //     try {
// //       bool available = await _speech.initialize(
// //         onStatus: (status) => print('Speech status: $status'),
// //         onError: (error) => print('Speech error: $error'),
// //       );
// //       setState(() {
// //         _speechReady = available;
// //       });
// //       if (available) {
// //         print('Speech initialized successfully');
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Speech ready! Now start reciting.')),
// //         );
// //       } else {
// //         print('Speech initialization failed - device may not support it');
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Speech recognition not available. Check settings or device support.'),
// //             duration: Duration(seconds: 5),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       print('Initialization exception: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e')),
// //       );
// //     }
// //   }
// //
// //   Future<void> _startListening() async {
// //     if (!_speechReady) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Speech not ready. Try again.')),
// //       );
// //       return;
// //     }
// //
// //     if (await Permission.microphone.request().isDenied) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('মাইক্রোফোন অনুমতি দিন')),
// //       );
// //       return;
// //     }
// //
// //     setState(() {
// //       _isListening = true;
// //       _spokenText = '';
// //       visible = List.generate(allWords.length, (_) => false);
// //       isWrong = List.generate(allWords.length, (_) => false);
// //     });
// //
// //     await _speech.listen(
// //       onResult: (result) {
// //         setState(() {
// //           _spokenText = result.recognizedWords;
// //         });
// //         _checkWords(result.recognizedWords);
// //       },
// //       localeId: 'ar_SA',  // আরবি (সৌদি)
// //       partialResults: true,
// //     );
// //   }
// //
// //   void _checkWords(String spoken) {
// //     final spokenWords = spoken.toLowerCase().split(' ');
// //     int pointer = 0;
// //
// //     for (var spokenWord in spokenWords) {
// //       if (pointer >= allWords.length) break;
// //
// //       final target = allWords[pointer].toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
// //       final spokenClean = spokenWord.replaceAll(RegExp(r'[^\w]'), '');
// //
// //       bool match = target.contains(spokenClean) || spokenClean.contains(target) ||
// //           (target.length - spokenClean.length).abs() <= 3;
// //
// //       setState(() {
// //         visible[pointer] = true;
// //         isWrong[pointer] = !match;
// //       });
// //
// //       pointer++;
// //     }
// //   }
// //
// //   Future<void> _stopListening() async {
// //     await _speech.stop();
// //     setState(() => _isListening = false);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int wordIndex = 0;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('সুরা ফাতিহা - পড়া চেকার'),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.end,
// //           children: [
// //             const SizedBox(height: 20),
// //             Center(
// //               child: ElevatedButton.icon(
// //                 onPressed: _isListening ? _stopListening : _startListening,
// //                 icon: Icon(_isListening ? Icons.stop : Icons.mic),
// //                 label: Text(_isListening ? 'বন্ধ করুন' : 'পড়া শুরু করুন'),
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// //                   textStyle: const TextStyle(fontSize: 18),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 30),
// //             ...List.generate(ayat.length, (i) {
// //               final words = ayat[i].split(' ');
// //               return Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   Wrap(
// //                     alignment: WrapAlignment.end,
// //                     spacing: 8,
// //                     runSpacing: 12,
// //                     children: words.map((word) {
// //                       final v = visible[wordIndex];
// //                       final wrong = isWrong[wordIndex];
// //                       wordIndex++;
// //
// //                       return AnimatedOpacity(
// //                         opacity: v ? 1.0 : 0.25,
// //                         duration: const Duration(milliseconds: 400),
// //                         child: Container(
// //                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                           decoration: BoxDecoration(
// //                             color: wrong ? Colors.red.withOpacity(0.3) : null,
// //                             borderRadius: BorderRadius.circular(8),
// //                             border: wrong ? Border.all(color: Colors.red) : null,
// //                           ),
// //                           child: Text(
// //                             word,
// //                             style: TextStyle(
// //                               color: wrong ? Colors.red[900] : Colors.black87,
// //                               fontWeight: wrong ? FontWeight.bold : FontWeight.normal,
// //                             ),
// //                             textDirection: TextDirection.rtl,
// //                           ),
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     translations[i],
// //                     style: const TextStyle(fontSize: 16, color: Colors.grey),
// //                     textAlign: TextAlign.right,
// //                   ),
// //                   const SizedBox(height: 24),
// //                 ],
// //               );
// //             }),
// //             if (_spokenText.isNotEmpty)
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Text(
// //                   'শোনা গেছে: $_spokenText',
// //                   style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:permission_handler/permission_handler.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: VoiceHighlightScreen(),
// //     );
// //   }
// // }
// //
// // class VoiceHighlightScreen extends StatefulWidget {
// //   const VoiceHighlightScreen({super.key});
// //
// //   @override
// //   State<VoiceHighlightScreen> createState() =>
// //       _VoiceHighlightScreenState();
// // }
// //
// // class _VoiceHighlightScreenState extends State<VoiceHighlightScreen> {
// //   final stt.SpeechToText _speech = stt.SpeechToText();
// //   bool _isListening = false;
// //   String _spokenText = "";
// //
// //   List<String> words = ["Flutter", "Dart", "Widget", "State"];
// //   List<bool> isHighlighted = [false, false, false, false];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     requestPermission();
// //   }
// //
// //   Future<void> requestPermission() async {
// //     await Permission.microphone.request();
// //   }
// //
// //   void startListening() async {
// //     bool available = await _speech.initialize();
// //
// //     if (available) {
// //       setState(() => _isListening = true);
// //
// //       _speech.listen(
// //         onResult: (result) {
// //           setState(() {
// //             _spokenText = result.recognizedWords;
// //             checkHighlight();
// //           });
// //         },
// //       );
// //     }
// //   }
// //
// //   void stopListening() {
// //     _speech.stop();
// //     setState(() => _isListening = false);
// //   }
// //
// //   void checkHighlight() {
// //     for (int i = 0; i < words.length; i++) {
// //       if (_spokenText.toLowerCase().contains(words[i].toLowerCase())) {
// //         isHighlighted[i] = true;
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Voice Highlight")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             Wrap(
// //               spacing: 10,
// //               runSpacing: 10,
// //               children: words.asMap().entries.map((entry) {
// //                 int index = entry.key;
// //                 return AnimatedOpacity(
// //                   duration: const Duration(milliseconds: 300),
// //                   opacity: isHighlighted[index] ? 1.0 : 0.3,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                         vertical: 8, horizontal: 12),
// //                     decoration: BoxDecoration(
// //                       color: isHighlighted[index]
// //                           ? Colors.green
// //                           : Colors.grey[300],
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     child: Text(
// //                       entry.value,
// //                       style: const TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //             const SizedBox(height: 40),
// //             FloatingActionButton(
// //               onPressed:
// //               _isListening ? stopListening : startListening,
// //               child:
// //               Icon(_isListening ? Icons.mic : Icons.mic_none),
// //             ),
// //             const SizedBox(height: 20),
// //             Text("You said: $_spokenText"),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BismillahPracticeScreen(),
//   ));
// }
//
// class BismillahPracticeScreen extends StatefulWidget {
//   const BismillahPracticeScreen({super.key});
//
//   @override
//   State<BismillahPracticeScreen> createState() =>
//       _BismillahPracticeScreenState();
// }
//
// class _BismillahPracticeScreenState extends State<BismillahPracticeScreen> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool _isEnglish = true;
//   bool _showArabic = true;
//   bool _isListening = false; // mic status
//
//   final List<String> wordsEnglish = [
//     "In", "the", "name", "of", "Allah", "the", "Most", "Gracious", "the", "Most", "Merciful"
//   ];
//
//   final List<String> wordsArabic = [
//     "بِسْمِ", "اللَّهِ", "الرَّحْمَـٰنِ", "الرَّحِيمِ"
//   ];
//
//   List<double> wordOpacity = [];
//   int _currentWordIndex = 0;
//   int _score = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initWordOpacity();
//   }
//
//   void _initWordOpacity() {
//     final currentWords = _isEnglish ? wordsEnglish : wordsArabic;
//     wordOpacity = List.generate(currentWords.length, (_) => 0.3);
//   }
//
//   Future<void> _checkWord(String spokenWord) async {
//     final currentWords = _isEnglish ? wordsEnglish : wordsArabic;
//     if (_currentWordIndex >= currentWords.length) return;
//
//     String targetWord = currentWords[_currentWordIndex].toLowerCase();
//     double similarity = _stringSimilarity(spokenWord.toLowerCase(), targetWord);
//
//     if (similarity > 0.8) {
//       setState(() {
//         wordOpacity[_currentWordIndex] = 1.0; // correct
//         _currentWordIndex++;
//         _score++;
//       });
//       await _audioPlayer.play(AssetSource('sounds/success.wav'));
//     } else {
//       await _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//       setState(() {
//         wordOpacity[_currentWordIndex] = 1.0; // wrong highlight
//       });
//     }
//   }
//
//   double _stringSimilarity(String s1, String s2) {
//     if (s1 == s2) return 1.0;
//     int matches = 0;
//     int len = s1.length < s2.length ? s1.length : s2.length;
//     for (int i = 0; i < len; i++) {
//       if (s1[i] == s2[i]) matches++;
//     }
//     return matches / (len == 0 ? 1 : len);
//   }
//
//   void reset() {
//     setState(() {
//       _currentWordIndex = 0;
//       _score = 0;
//       _initWordOpacity();
//     });
//   }
//
//   void togglePracticeLanguage() {
//     setState(() {
//       _isEnglish = !_isEnglish;
//       _currentWordIndex = 0;
//       _score = 0;
//       _initWordOpacity();
//     });
//   }
//
//   void toggleArabicVisibility() {
//     setState(() {
//       _showArabic = !_showArabic;
//     });
//   }
//
//   void toggleListening() {
//     setState(() {
//       _isListening = !_isListening;
//       if (_isListening) {
//         // TODO: Add Google Cloud Streaming here later
//         // Example: startStreamingRecognition();
//       } else {
//         // TODO: stop streaming
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentWords = _isEnglish ? wordsEnglish : wordsArabic;
//     double progress = _currentWordIndex / currentWords.length;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bismillahir Rahmanir Rahim Practice"),
//         actions: [
//           TextButton(
//             onPressed: togglePracticeLanguage,
//             child: Text(_isEnglish ? "Arabic" : "English",
//                 style: const TextStyle(color: Colors.white, fontSize: 16)),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             LinearProgressIndicator(
//               value: progress,
//               minHeight: 8,
//               backgroundColor: Colors.grey[300],
//               color: Colors.green,
//             ),
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 8,
//               children: currentWords.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 Color color = Colors.black;
//                 if (idx < _currentWordIndex) {
//                   color = Colors.green;
//                 } else if (idx == _currentWordIndex && wordOpacity[idx] == 1.0) {
//                   color = Colors.red;
//                 }
//                 return Opacity(
//                   opacity: wordOpacity[idx],
//                   child: Text(
//                     entry.value,
//                     style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: color),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             if (_showArabic && !_isEnglish)
//               Wrap(
//                 spacing: 8,
//                 children: wordsArabic
//                     .map((word) => Text(word,
//                     style: const TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)))
//                     .toList(),
//               ),
//             const SizedBox(height: 40),
//             FloatingActionButton(
//               onPressed: toggleListening,
//               child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//                 onPressed: () {
//                   // Simulation for testing without mic
//                   _checkWord("In");
//                 },
//                 child: const Text("Simulate Spoken Word")),
//             const SizedBox(height: 10),
//             Text("Score: $_score / ${currentWords.length}",
//                 style:
//                 const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(onPressed: reset, child: const Text("Reset")),
//                 ElevatedButton(
//                     onPressed: toggleArabicVisibility,
//                     child: Text(_showArabic ? "Hide Arabic" : "Show Arabic")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:string_similarity/string_similarity.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// void main() {
//   runApp(const QuranApp());
// }
//
// class QuranApp extends StatelessWidget {
//   const QuranApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BismillahPracticeScreen(),
//     );
//   }
// }
//
// class BismillahPracticeScreen extends StatefulWidget {
//   const BismillahPracticeScreen({super.key});
//
//   @override
//   State<BismillahPracticeScreen> createState() =>
//       _BismillahPracticeScreenState();
// }
//
// class _BismillahPracticeScreenState extends State<BismillahPracticeScreen> {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   final AudioPlayer _player = AudioPlayer();
//
//   bool _isListening = false;
//   String spokenText = "";
//
//   bool isEnglish = true;
//   bool showArabic = true;
//
//   int currentIndex = 0;
//
//   final List<String> englishWords = [
//     "In",
//     "the",
//     "name",
//     "of",
//     "Allah",
//     "the",
//     "Most",
//     "Gracious",
//     "the",
//     "Most",
//     "Merciful"
//   ];
//
//   final List<String> arabicWords = [
//     "بِسْمِ",
//     "اللَّهِ",
//     "الرَّحْمَٰنِ",
//     "الرَّحِيمِ"
//   ];
//
//   List<bool> correct = [];
//   List<bool> wrong = [];
//
//   @override
//   void initState() {
//     super.initState();
//     initLists();
//   }
//
//   void initLists() {
//     final words = isEnglish ? englishWords : arabicWords;
//
//     correct = List.generate(words.length, (index) => false);
//     wrong = List.generate(words.length, (index) => false);
//
//     currentIndex = 0;
//   }
//
//   Future<void> startListening() async {
//     await Permission.microphone.request();
//
//     bool available = await _speech.initialize();
//
//     if (available) {
//       setState(() {
//         _isListening = true;
//       });
//
//       _speech.listen(
//         localeId: isEnglish ? "en_US" : "ar_SA",
//         partialResults: true,
//         listenMode: stt.ListenMode.dictation,
//         onResult: (result) {
//           setState(() {
//             spokenText = result.recognizedWords;
//           });
//
//           checkWords(spokenText);
//         },
//       );
//     }
//   }
//
//   void stopListening() {
//     _speech.stop();
//     setState(() {
//       _isListening = false;
//     });
//   }
//
//   void checkWords(String spoken) async {
//     final words = isEnglish ? englishWords : arabicWords;
//
//     List<String> spokenWords = spoken.split(" ");
//
//     for (var word in spokenWords) {
//       if (currentIndex >= words.length) return;
//
//       String target = words[currentIndex];
//
//       double similarity =
//       StringSimilarity.compareTwoStrings(word.toLowerCase(), target.toLowerCase());
//
//       if (similarity > 0.7) {
//         setState(() {
//           correct[currentIndex] = true;
//         });
//
//         await _player.play(AssetSource("sounds/success.wav"));
//
//         currentIndex++;
//       } else {
//         setState(() {
//           wrong[currentIndex] = true;
//         });
//
//         await _player.play(AssetSource("sounds/wrong_answer.wav"));
//       }
//     }
//   }
//
//   void toggleLanguage() {
//     setState(() {
//       isEnglish = !isEnglish;
//       initLists();
//     });
//   }
//
//   void toggleArabic() {
//     setState(() {
//       showArabic = !showArabic;
//     });
//   }
//
//   void reset() {
//     setState(() {
//       initLists();
//       spokenText = "";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final words = isEnglish ? englishWords : arabicWords;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bismillahir Rahmanir Rahim Practice"),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: toggleLanguage,
//             child: Text(
//               isEnglish ? "Arabic" : "English",
//               style: const TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: words.asMap().entries.map((entry) {
//                 int index = entry.key;
//
//                 Color color = Colors.black;
//                 double opacity = 0.3;
//
//                 if (correct[index]) {
//                   color = Colors.green;
//                   opacity = 1;
//                 }
//
//                 if (wrong[index]) {
//                   color = Colors.red;
//                   opacity = 1;
//                 }
//
//                 return Opacity(
//                   opacity: opacity,
//                   child: Text(
//                     entry.value,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: color,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             const SizedBox(height: 30),
//
//             if (showArabic && isEnglish)
//               Wrap(
//                 spacing: 10,
//                 children: arabicWords
//                     .map(
//                       (e) => const Text(
//                     "",
//                     style: TextStyle(fontSize: 28),
//                   ),
//                 )
//                     .toList(),
//               ),
//
//             const SizedBox(height: 40),
//
//             FloatingActionButton(
//               onPressed: _isListening ? stopListening : startListening,
//               child: Icon(_isListening ? Icons.stop : Icons.mic),
//             ),
//
//             const SizedBox(height: 20),
//
//             Text(
//               spokenText,
//               style: const TextStyle(fontSize: 16),
//             ),
//
//             const SizedBox(height: 30),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: reset,
//                   child: const Text("Reset"),
//                 ),
//                 ElevatedButton(
//                   onPressed: toggleArabic,
//                   child: Text(showArabic ? "Hide Arabic" : "Show Arabic"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }






// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationTestScreen(),
//   ));
// }
//
// class QuranRecitationTestScreen extends StatefulWidget {
//   const QuranRecitationTestScreen({super.key});
//
//   @override
//   State<QuranRecitationTestScreen> createState() =>
//       _QuranRecitationTestScreenState();
// }
//
// class _QuranRecitationTestScreenState extends State<QuranRecitationTestScreen> {
//   final Record _recorder = Record();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   final String apiKey = "AIzaSyD56wUyZZnNeGXPf8-QYZCyncgaD9Ln-2U";
//
//   bool isRecording = false;
//   String recognizedText = "";
//
//   // Example words for Bismillah practice
//   final List<String> wordsEnglish = [
//     "In", "the", "name", "of", "Allah", "the", "Most", "Gracious", "the", "Most", "Merciful"
//   ];
//
//   final List<String> wordsArabic = [
//     "بِسْمِ", "اللَّهِ", "الرَّحْمَـٰنِ", "الرَّحِيمِ"
//   ];
//
//   List<double> wordOpacity = [];
//   int currentWordIndex = 0;
//   int score = 0;
//   bool showArabic = true;
//   bool isEnglish = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initWordOpacity();
//   }
//
//   void _initWordOpacity() {
//     final currentWords = isEnglish ? wordsEnglish : wordsArabic;
//     wordOpacity = List.generate(currentWords.length, (_) => 0.3);
//   }
//
//   Future<void> startRecording() async {
//     if (!kIsWeb && await _recorder.hasPermission()) {
//       await _recorder.start(
//         encoder: AudioEncoder.wav,
//         sampleRate: 16000,
//         bitRate: 16000,
//       );
//       setState(() => isRecording = true);
//     }
//   }
//
//   Future<void> stopRecording() async {
//     final path = await _recorder.stop();
//     setState(() => isRecording = false);
//     if (path != null) {
//       await _sendToGoogle(path);
//     }
//   }
//
//   Future<void> _sendToGoogle(String path) async {
//     final bytes = await File(path).readAsBytes();
//     final base64Audio = base64Encode(bytes);
//
//     final url =
//         "https://speech.googleapis.com/v1/speech:recognize?key=$apiKey";
//
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "config": {
//             "encoding": "LINEAR16",
//             "sampleRateHertz": 16000,
//             "languageCode": "ar-SA"
//           },
//           "audio": {"content": base64Audio}
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       setState(() {
//         recognizedText = data["results"]?[0]?["alternatives"]?[0]?["transcript"] ??
//             "No speech detected";
//       });
//
//       _checkWords(recognizedText);
//     } catch (e) {
//       if (kDebugMode) print("Error sending to Google: $e");
//       setState(() => recognizedText = "Error: $e");
//     }
//   }
//
//   void _checkWords(String spoken) {
//     final currentWords = isEnglish ? wordsEnglish : wordsArabic;
//     final spokenWords = spoken.toLowerCase().split(' ');
//
//     int pointer = 0;
//     for (var word in spokenWords) {
//       if (pointer >= currentWords.length) break;
//       final target = currentWords[pointer].toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
//       final spokenClean = word.replaceAll(RegExp(r'[^\w]'), '');
//       bool match = target.contains(spokenClean) ||
//           spokenClean.contains(target) ||
//           (target.length - spokenClean.length).abs() <= 2;
//
//       setState(() {
//         wordOpacity[pointer] = 1.0;
//         if (match) score++;
//       });
//
//       pointer++;
//     }
//
//     currentWordIndex = pointer;
//   }
//
//   void reset() {
//     setState(() {
//       currentWordIndex = 0;
//       score = 0;
//       _initWordOpacity();
//       recognizedText = "";
//     });
//   }
//
//   void toggleLanguage() {
//     setState(() {
//       isEnglish = !isEnglish;
//       reset();
//     });
//   }
//
//   void toggleArabicVisibility() {
//     setState(() => showArabic = !showArabic);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentWords = isEnglish ? wordsEnglish : wordsArabic;
//     double progress = currentWordIndex / currentWords.length;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Quran Recitation Test"),
//         actions: [
//           TextButton(
//             onPressed: toggleLanguage,
//             child: Text(isEnglish ? "Arabic" : "English",
//                 style: const TextStyle(color: Colors.white)),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             LinearProgressIndicator(
//               value: progress,
//               minHeight: 8,
//               backgroundColor: Colors.grey[300],
//               color: Colors.green,
//             ),
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 8,
//               children: currentWords.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 Color color = Colors.black;
//                 if (idx < currentWordIndex) color = Colors.green;
//                 return Opacity(
//                   opacity: wordOpacity[idx],
//                   child: Text(
//                     entry.value,
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             if (!isEnglish && showArabic)
//               Wrap(
//                 spacing: 8,
//                 children: wordsArabic
//                     .map((word) => Text(word,
//                     style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)))
//                     .toList(),
//               ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: isRecording ? stopRecording : startRecording,
//               child: Text(isRecording ? "Stop Recording" : "Start Recording"),
//             ),
//             const SizedBox(height: 10),
//             Text("Recognized: $recognizedText"),
//             const SizedBox(height: 10),
//             Text("Score: $score / ${currentWords.length}"),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(onPressed: reset, child: const Text("Reset")),
//                 ElevatedButton(
//                     onPressed: toggleArabicVisibility,
//                     child: Text(showArabic ? "Hide Arabic" : "Show Arabic")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:string_similarity/string_similarity.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen> {
//   final flutterSound = FlutterSoundRecorder();
//   bool isRecording = false;
//   String audioPath = "";
//   String resultText = "";
//
//   final AudioPlayer audioPlayer = AudioPlayer();
//
//   // Google API Key
//   final String apiKey = "AIzaSyD56wUyZZnNeGXPf8-QYZCyncgaD9Ln-2U";
//
//   // Surah Al-Fatihah words
//   final List<String> ayat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمِ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   late List<String> allWords;
//   late List<bool> visible;
//   late List<bool> isWrong;
//   int currentWordIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     allWords = ayat.expand((a) => a.split(' ')).toList();
//     visible = List.generate(allWords.length, (_) => false);
//     isWrong = List.generate(allWords.length, (_) => false);
//     _initRecorder();
//   }
//
//   Future<void> _initRecorder() async {
//     await flutterSound.openRecorder();
//     if (!await Permission.microphone.request().isGranted) {
//       throw Exception("Microphone permission not granted");
//     }
//   }
//
//   Future<void> startRecording() async {
//     audioPath = "${Directory.systemTemp.path}/recitation.wav";
//     await flutterSound.startRecorder(
//       toFile: audioPath,
//       codec: Codec.pcm16WAV,
//       sampleRate: 16000,
//     );
//     setState(() => isRecording = true);
//   }
//
//   Future<void> stopRecording() async {
//     await flutterSound.stopRecorder();
//     setState(() => isRecording = false);
//     await _sendToGoogle(audioPath);
//   }
//
//   Future<void> _sendToGoogle(String path) async {
//     final bytes = await File(path).readAsBytes();
//     final base64Audio = base64Encode(bytes);
//
//     final url =
//         "https://speech.googleapis.com/v1/speech:recognize?key=$apiKey";
//
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "config": {
//           "encoding": "LINEAR16",
//           "sampleRateHertz": 16000,
//           "languageCode": "ar-SA",
//         },
//         "audio": {"content": base64Audio},
//       }),
//     );
//
//     final data = jsonDecode(response.body);
//     final transcript =
//         data["results"]?[0]?["alternatives"]?[0]?["transcript"] ?? "";
//
//     setState(() {
//       resultText = transcript;
//     });
//
//     _checkWords(transcript);
//   }
//
//   void _checkWords(String spoken) {
//     final spokenWords = spoken.split(' ');
//     int pointer = 0;
//
//     for (var spokenWord in spokenWords) {
//       if (pointer >= allWords.length) break;
//
//       final target = allWords[pointer];
//       final similarity = StringSimilarity.compareTwoStrings(
//         target.toLowerCase(),
//         spokenWord.toLowerCase(),
//       );
//
//       setState(() {
//         visible[pointer] = true;
//         isWrong[pointer] = similarity < 0.7;
//       });
//
//       pointer++;
//     }
//   }
//
//   void reset() {
//     setState(() {
//       visible = List.generate(allWords.length, (_) => false);
//       isWrong = List.generate(allWords.length, (_) => false);
//       currentWordIndex = 0;
//       resultText = "";
//     });
//   }
//
//   @override
//   void dispose() {
//     flutterSound.closeRecorder();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int wordIndex = 0;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quran Recitation Checker")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: isRecording ? stopRecording : startRecording,
//                 icon: Icon(isRecording ? Icons.stop : Icons.mic),
//                 label:
//                 Text(isRecording ? "Stop Recording" : "Start Recording"),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ...List.generate(ayat.length, (i) {
//               final words = ayat[i].split(' ');
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Wrap(
//                     alignment: WrapAlignment.end,
//                     spacing: 8,
//                     runSpacing: 12,
//                     children: words.map((word) {
//                       final v = visible[wordIndex];
//                       final wrong = isWrong[wordIndex];
//                       wordIndex++;
//
//                       return AnimatedOpacity(
//                         opacity: v ? 1.0 : 0.25,
//                         duration: const Duration(milliseconds: 400),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color:
//                             wrong ? Colors.red.withOpacity(0.3) : null,
//                             borderRadius: BorderRadius.circular(8),
//                             border: wrong
//                                 ? Border.all(color: Colors.red)
//                                 : null,
//                           ),
//                           child: Text(
//                             word,
//                             style: TextStyle(
//                               color: wrong ? Colors.red[900] : Colors.black87,
//                               fontWeight: wrong
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                             ),
//                             textDirection: TextDirection.rtl,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 8),
//                   const SizedBox(height: 24),
//                 ],
//               );
//             }),
//             const SizedBox(height: 20),
//             if (resultText.isNotEmpty)
//               Text(
//                 "Detected: $resultText",
//                 style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(onPressed: reset, child: const Text("Reset")),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:string_similarity/string_similarity.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen> {
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool isRecording = false;
//   String tempAudioPath = "";
//
//   // তোমার Google API Key (টেস্টের জন্য রাখো, পরে backend-এ সরাও)
//   final String apiKey = "AIzaSyD56wUyZZnNeGXPf8-QYZCyncgaD9Ln-2U";
//
//   // সুরা ফাতিহা (আরবি টেক্সট)
//   final List<String> ayat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   late List<String> allWords;
//   late List<double> opacityList;      // 0.0 to 1.0
//   late List<bool> isWrongList;
//   int currentWordIndex = 0;           // কোন ওয়ার্ড পর্যন্ত ম্যাচ হয়েছে
//
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     allWords = ayat.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(allWords.length, (_) => 0.3); // initial low opacity
//     isWrongList = List.generate(allWords.length, (_) => false);
//     _initRecorder();
//   }
//
//   Future<void> _initRecorder() async {
//     await _recorder.openRecorder();
//     if (await Permission.microphone.request().isDenied) {
//       // Handle denial
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("মাইক্রোফোন পারমিশন দরকার")),
//       );
//     }
//   }
//
//   Future<void> startRecording() async {
//     tempAudioPath = "${Directory.systemTemp.path}/recitation.wav";
//     await _recorder.startRecorder(
//       toFile: tempAudioPath,
//       codec: Codec.pcm16WAV,
//       sampleRate: 16000,
//     );
//
//     setState(() => isRecording = true);
//
//     // প্রতি ২-৩ সেকেন্ডে চেক (simulated real-time)
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
//       if (!isRecording) return;
//       await _sendToGoogle(tempAudioPath);
//     });
//   }
//
//   Future<void> stopRecording() async {
//     await _recorder.stopRecorder();
//     setState(() => isRecording = false);
//     _timer?.cancel();
//     await _sendToGoogle(tempAudioPath); // শেষ চেক
//   }
//
//   Future<void> _sendToGoogle(String path) async {
//     try {
//       final bytes = await File(path).readAsBytes();
//       final base64Audio = base64Encode(bytes);
//
//       final url = "https://speech.googleapis.com/v1/speech:recognize?key=$apiKey";
//
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "config": {
//             "encoding": "LINEAR16",
//             "sampleRateHertz": 16000,
//             "languageCode": "ar-SA",
//             "enableWordTimeOffsets": true, // optional: word level timing
//           },
//           "audio": {"content": base64Audio},
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final transcript = data["results"]?[0]?["alternatives"]?[0]?["transcript"] ?? "";
//         _updateWords(transcript);
//       } else {
//         print("API Error: ${response.body}");
//       }
//     } catch (e) {
//       print("Error sending to Google: $e");
//     }
//   }
//
//   void _updateWords(String spoken) {
//     if (spoken.isEmpty) return;
//
//     final spokenWords = spoken.trim().split(RegExp(r'\s+'));
//     int matchedCount = 0;
//
//     for (var spokenWord in spokenWords) {
//       if (currentWordIndex >= allWords.length) break;
//
//       final target = allWords[currentWordIndex].replaceAll(RegExp(r'[ً ٌ ٍ َ ُ ِّ]'), ''); // হরকত রিমুভ optional
//       final similarity = StringSimilarity.compareTwoStrings(
//         target.toLowerCase(),
//         spokenWord.toLowerCase(),
//       );
//
//       setState(() async {
//         opacityList[currentWordIndex] = 1.0; // visible + fade in
//         isWrongList[currentWordIndex] = similarity < 0.75; // threshold adjust করো
//
//         if (isWrongList[currentWordIndex]) {
//           await _audioPlayer.stop(); // আগের sound থামাও
//           await _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//         }
//       });
//
//       currentWordIndex++;
//       matchedCount++;
//     }
//
//     // অতিরিক্ত spoken words ignore (skip logic পরে অ্যাড করা যাবে)
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(allWords.length, (_) => 0.3);
//       isWrongList = List.generate(allWords.length, (_) => false);
//       currentWordIndex = 0;
//     });
//   }
//
//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     _audioPlayer.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("কুরআন রিয়েল-টাইম রিসাইটেশন"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: isRecording ? stopRecording : startRecording,
//                 icon: Icon(isRecording ? Icons.stop : Icons.mic, size: 32),
//                 label: Text(isRecording ? "থামাও" : "শুরু করো", style: const TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   backgroundColor: isRecording ? Colors.red : Colors.green,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ...List.generate(ayat.length, (ayahIndex) {
//               final words = ayat[ayahIndex].split(' ');
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: Wrap(
//                   alignment: WrapAlignment.end,
//                   spacing: 10,
//                   runSpacing: 12,
//                   children: words.asMap().entries.map((entry) {
//                     final globalIndex = _getGlobalIndex(ayahIndex, entry.key);
//                     final word = entry.value;
//
//                     return AnimatedOpacity(
//                       opacity: opacityList[globalIndex],
//                       duration: const Duration(milliseconds: 600),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 400),
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: isWrongList[globalIndex]
//                               ? Colors.red.withOpacity(0.2)
//                               : opacityList[globalIndex] > 0.5
//                               ? Colors.green.withOpacity(0.15)
//                               : null,
//                           borderRadius: BorderRadius.circular(10),
//                           border: isWrongList[globalIndex]
//                               ? Border.all(color: Colors.red, width: 1.5)
//                               : null,
//                         ),
//                         child: Text(
//                           word,
//                           style: GoogleFonts.amiri(   // আরবি ফন্ট (pubspec-এ google_fonts অ্যাড করো)
//                             fontSize: 26,
//                             color: isWrongList[globalIndex] ? Colors.red[900] : Colors.black87,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               );
//             }),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton(
//                 onPressed: reset,
//                 child: const Text("রিসেট করো"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   int _getGlobalIndex(int ayahIndex, int wordInAyah) {
//     int count = 0;
//     for (int i = 0; i < ayahIndex; i++) {
//       count += ayat[i].split(' ').length;
//     }
//     return count + wordInAyah;
//   }
// }

//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:string_similarity/string_similarity.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen> {
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool isRecording = false;
//   String tempAudioPath = "";
//
//   final String apiKey = "AIzaSyD56wUyZZnNeGXPf8-QYZCyncgaD9Ln-2U"; // টেস্টের জন্য
//
//   String currentMode = 'arabic'; // 'arabic' or 'english'
//
//   // আরবি আয়াত
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   // ইংরেজি word-by-word (সিম্পল ট্রান্সলেশন)
//   final List<String> englishAyat = [
//     'In the name of Allah the Most Gracious the Most Merciful',
//     'All praise is due to Allah Lord of the worlds',
//     'The Most Gracious the Most Merciful',
//     'Master of the Day of Judgment',
//     'You alone we worship and You alone we ask for help',
//     'Guide us to the straight path',
//     'The path of those upon whom You have bestowed favor not of those who have evoked anger or of those who are astray',
//   ];
//
//   late List<String> referenceWords;
//   late List<double> opacityList;
//   late List<bool> isWrongList;
//   int currentWordIndex = 0;
//
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateReferenceWords();
//     _initRecorder();
//   }
//
//   void _updateReferenceWords() {
//     final ayatList = currentMode == 'arabic' ? arabicAyat : englishAyat;
//     referenceWords = ayatList.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(referenceWords.length, (_) => 0.3);
//     isWrongList = List.generate(referenceWords.length, (_) => false);
//     currentWordIndex = 0;
//   }
//
//   Future<void> _initRecorder() async {
//     await _recorder.openRecorder();
//     if (await Permission.microphone.request().isDenied) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("মাইক্রোফোন পারমিশন দরকার")),
//         );
//       }
//     }
//   }
//
//   Future<void> startRecording() async {
//     tempAudioPath = "${Directory.systemTemp.path}/recitation.wav";
//     await _recorder.startRecorder(
//       toFile: tempAudioPath,
//       codec: Codec.pcm16WAV,
//       sampleRate: 16000,
//     );
//
//     setState(() => isRecording = true);
//
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
//       if (!isRecording) return;
//       await _sendToGoogle(tempAudioPath);
//     });
//   }
//
//   Future<void> stopRecording() async {
//     await _recorder.stopRecorder();
//     setState(() => isRecording = false);
//     _timer?.cancel();
//     await _sendToGoogle(tempAudioPath);
//   }
//
//   Future<void> _sendToGoogle(String path) async {
//     try {
//       final bytes = await File(path).readAsBytes();
//       final base64Audio = base64Encode(bytes);
//
//       final url = "https://speech.googleapis.com/v1/speech:recognize?key=$apiKey";
//
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "config": {
//             "encoding": "LINEAR16",
//             "sampleRateHertz": 16000,
//             "languageCode": currentMode == 'arabic' ? "ar-SA" : "en-US",
//           },
//           "audio": {"content": base64Audio},
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final transcript = data["results"]?[0]?["alternatives"]?[0]?["transcript"] ?? "";
//         _updateWords(transcript);
//       } else {
//         print("API Error: ${response.statusCode} - ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   void _updateWords(String spoken) {
//     if (spoken.isEmpty) return;
//
//     final spokenWords = spoken.trim().split(RegExp(r'\s+'));
//     for (var spokenWord in spokenWords) {
//       if (currentWordIndex >= referenceWords.length) break;
//
//       String target = referenceWords[currentWordIndex];
//       if (currentMode == 'arabic') {
//         target = target.replaceAll(RegExp(r'[ًٌٍَُِّْ]'), ''); // হরকত রিমুভ
//       }
//
//       final similarity = StringSimilarity.compareTwoStrings(
//         target.toLowerCase(),
//         spokenWord.toLowerCase(),
//       );
//
//       setState(() {
//         opacityList[currentWordIndex] = 1.0;
//         isWrongList[currentWordIndex] = similarity < 0.75; // 0.75-0.85 এ adjust করো
//
//         if (isWrongList[currentWordIndex]) {
//           _audioPlayer.stop().then((_) {
//             _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//           });
//         }
//       });
//
//       currentWordIndex++;
//     }
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(referenceWords.length, (_) => 0.3);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//       currentWordIndex = 0;
//     });
//   }
//
//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     _audioPlayer.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("কুরআন রিয়েল-টাইম রিসাইটেশন টেস্ট"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'arabic';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'arabic' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("আরবি মোড"),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'english';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'english' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("ইংরেজি মোড"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: isRecording ? stopRecording : startRecording,
//                 icon: Icon(isRecording ? Icons.stop : Icons.mic, size: 32),
//                 label: Text(isRecording ? "থামাও" : "শুরু করো", style: const TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   backgroundColor: isRecording ? Colors.red : Colors.green,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 10,
//               runSpacing: 12,
//               children: referenceWords.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 String word = entry.value;
//
//                 return AnimatedOpacity(
//                   opacity: opacityList[idx],
//                   duration: const Duration(milliseconds: 600),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: isWrongList[idx]
//                           ? Colors.red.withOpacity(0.2)
//                           : opacityList[idx] > 0.5
//                           ? Colors.green.withOpacity(0.15)
//                           : null,
//                       borderRadius: BorderRadius.circular(10),
//                       border: isWrongList[idx] ? Border.all(color: Colors.red, width: 1.5) : null,
//                     ),
//                     child: Text(
//                       word,
//                       style: GoogleFonts.amiri(
//                         fontSize: currentMode == 'arabic' ? 28 : 20,
//                         color: isWrongList[idx] ? Colors.red[900] : Colors.black87,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textDirection: currentMode == 'arabic' ? TextDirection.rtl : TextDirection.ltr,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: reset,
//               child: const Text("রিসেট করো"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:quran_app/profiel/add_skills_screen.dart';
// import 'package:quran_app/profiel/cv_upladon_screen.dart';
// import 'package:quran_app/profiel/plang_sceeen.dart';
// import 'package:quran_app/profiel/profile_one_sceen.dart';
// import 'package:quran_app/profiel/work_exprinces_screen.dart';
// import 'package:quran_app/shope_screen/product_deatils_screen.dart';
// import 'package:quran_app/shope_screen/seat_selat_screen.dart';
// import 'package:quran_app/shope_screen/sope_screen.dart';
// import 'package:quran_app/shope_screen/tick_screen.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:string_similarity/string_similarity.dart';
//
//
// import 'auth/forgot_password_screen.dart';
// import 'bootom_nev_bar.dart';
//
// void main() {
//   runApp(  const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     // home: TicketDownloadScreen(),
//      home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool _speechInitialized = false;
//   bool isListening = false;
//   String transcription = "";
//   String currentMode = 'arabic'; // 'arabic' or 'english'
//
//   // সুরা ফাতিহা - আরবি
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   // ইংরেজি word-by-word ট্রান্সলেশন
//   final List<String> englishAyat = [
//     'In the name of Allah the Most Gracious the Most Merciful',
//     'All praise is due to Allah Lord of the worlds',
//     'The Most Gracious the Most Merciful',
//     'Master of the Day of Judgment',
//     'You alone we worship and You alone we ask for help',
//     'Guide us to the straight path',
//     'The path of those upon whom You have bestowed favor not of those who have evoked anger or of those who are astray',
//   ];
//
//   late List<String> referenceWords;
//   late List<double> opacityList;
//   late List<bool> isWrongList;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateReferenceWords();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _initSpeech();
//   }
//
//   void _updateReferenceWords() {
//     final ayatList = currentMode == 'arabic' ? arabicAyat : englishAyat;
//     referenceWords = ayatList.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(referenceWords.length, (_) => 0.2); // শুরুতে ফ্যাকাশে
//     isWrongList = List.generate(referenceWords.length, (_) => false);
//   }
//
//   Future<void> _initSpeech() async {
//     _speechInitialized = await _speech.initialize(
//       onStatus: (status) => print('Status: $status'),
//       onError: (error) => print('Error: $error'),
//     );
//   }
//
//   Future<void> startListening() async {
//     if (!_speechInitialized) await _initSpeech();
//
//     await _speech.listen(
//       onResult: _onResult,
//       localeId: currentMode == 'arabic' ? 'ar-SA' : 'en-US',
//       partialResults: true,
//       listenFor: const Duration(minutes: 10),
//       pauseFor: const Duration(seconds: 3),
//     );
//
//     setState(() => isListening = true);
//   }
//
//   Future<void> stopListening() async {
//     await _speech.stop();
//     setState(() => isListening = false);
//   }
//
//   void _onResult(SpeechRecognitionResult result) {
//     setState(() {
//       transcription = result.recognizedWords;
//     });
//
//     _processWords(result.recognizedWords);
//   }
//
//   void _processWords(String spoken) {
//     if (spoken.isEmpty) return;
//
//     final spokenWords = spoken.trim().split(RegExp(r'\s+'));
//     isWrongList.fillRange(0, isWrongList.length, false);
//
//     int matched = 0;
//     for (int i = 0; i < referenceWords.length && matched < spokenWords.length; i++) {
//       final target = referenceWords[i].replaceAll(RegExp(r'[ًٌٍَُِّْ]'), '');
//       final similarity = StringSimilarity.compareTwoStrings(
//         target.toLowerCase(),
//         spokenWords[matched].toLowerCase(),
//       );
//
//       setState(() {
//         opacityList[i] = 1.0; // পড়া হলে একদম ক্লিয়ার
//
//         if (similarity < 0.75) {
//           isWrongList[i] = true;
//           _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//           _animationController.forward(from: 0.0); // ভেসে উঠা অ্যানিমেশন
//         } else {
//           matched++; // সঠিক হলে পরের ওয়ার্ডে যাও
//         }
//       });
//     }
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(referenceWords.length, (_) => 0.2);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//       transcription = "";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Surah Fatiha real-time check",style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // মোড সুইচ বাটন
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'arabic';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'arabic' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("Arabic mode",style: TextStyle(color: Colors.white),),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'english';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'english' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("English mode",style: TextStyle(color: Colors.white),),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Text(
//               isListening ? "Listening..." : "Ready",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Listening: $transcription",
//               textDirection: TextDirection.rtl,
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 40),
//             // শুধু টেক্সট (কোনো কনটেইনার নেই)
//             Wrap(
//               alignment: WrapAlignment.end,
//               spacing: 16,
//               runSpacing: 20,
//               children: referenceWords.asMap().entries.map((e) {
//                 int i = e.key;
//                 String word = e.value;
//                 bool isWrong = isWrongList[i];
//
//                 return ScaleTransition(
//                   scale: Tween<double>(begin: 1.0, end: isWrong ? 1.4 : 1.0).animate(
//                     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//                   ),
//                   child: AnimatedOpacity(
//                     opacity: opacityList[i],
//                     duration: const Duration(milliseconds: 600),
//                     child: Text(
//                       "$word ",
//                       style: GoogleFonts.amiri(
//                         fontSize: isWrong ? 36 : 28,
//                         color: isWrong ? Colors.red[900] : Colors.black87,
//                         fontWeight: isWrong ? FontWeight.bold : FontWeight.normal,
//                       ),
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 50),
//
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: reset,
//                 child: const Text("Reset"),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: ElevatedButton.icon(
//         onPressed: isListening ? stopListening : startListening,
//         icon: Icon(isListening ? Icons.stop : Icons.mic, size: 32),
//         label: Text(
//           isListening ? "Stop." : "Start.",
//           style: const TextStyle(fontSize: 18),
//         ),
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//           backgroundColor: isListening ? Colors.red : Colors.orange,
//           foregroundColor: Colors.white,
//         ),
//       ),
//     );
//
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:string_similarity/string_similarity.dart';
//
// void main() {
//   runApp(const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool _speechInitialized = false;
//   bool isListening = false;
//   bool _isRestarting = false;
//   String transcription = "";
//   String currentMode = 'arabic';
//
//   // সুরা ফাতিহা - আরবি
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   // ইংরেজি
//   final List<String> englishAyat = [
//     'In the name of Allah the Most Gracious the Most Merciful',
//     'All praise is due to Allah Lord of the worlds',
//     'The Most Gracious the Most Merciful',
//     'Master of the Day of Judgment',
//     'You alone we worship and You alone we ask for help',
//     'Guide us to the straight path',
//     'The path of those upon whom You have bestowed favor not of those who have evoked anger or of those who are astray',
//   ];
//
//   late List<String> referenceWords;
//   late List<double> opacityList;
//   late List<bool> isWrongList;
//   late AnimationController _animationController;
//   bool _soundPlayed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateReferenceWords();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _initSpeech();
//   }
//
//   void _updateReferenceWords() {
//     final ayatList = currentMode == 'arabic' ? arabicAyat : englishAyat;
//     referenceWords = ayatList.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(referenceWords.length, (_) => 0.2);
//     isWrongList = List.generate(referenceWords.length, (_) => false);
//   }
//
//   Future<void> _initSpeech() async {
//     _speechInitialized = await _speech.initialize(
//       onStatus: (status) {
//         debugPrint('Status: $status');
//         // mic বন্ধ হলে আবার চালু করো
//         if ((status == 'done' || status == 'notListening') && isListening && !_isRestarting) {
//           Future.delayed(const Duration(milliseconds: 300), () {
//             _restartListening();
//           });
//         }
//       },
//       onError: (error) {
//         debugPrint('Error: $error');
//         // error হলেও restart করো
//         if (isListening && !_isRestarting) {
//           Future.delayed(const Duration(milliseconds: 500), () {
//             _restartListening();
//           });
//         }
//       },
//     );
//   }
//
//   // ✅ নতুন restart function — real-time এর জন্য মূল সমাধান
//   Future<void> _restartListening() async {
//     if (!isListening || _isRestarting) return;
//     _isRestarting = true;
//
//     try {
//       await _speech.stop();
//       await Future.delayed(const Duration(milliseconds: 200));
//
//       if (!isListening) {
//         _isRestarting = false;
//         return;
//       }
//
//       await _speech.listen(
//         onResult: _onResult,
//         localeId: currentMode == 'arabic' ? 'ar-SA' : 'en-US',
//         partialResults: true,
//         listenFor: const Duration(seconds: 30),
//         pauseFor: const Duration(seconds: 8),
//       );
//     } catch (e) {
//       debugPrint('Restart error: $e');
//     } finally {
//       _isRestarting = false;
//     }
//   }
//
//   Future<void> startListening() async {
//     if (!_speechInitialized) await _initSpeech();
//
//     setState(() {
//       isListening = true;
//       _isRestarting = false;
//     });
//
//     await _speech.listen(
//       onResult: _onResult,
//       localeId: currentMode == 'arabic' ? 'ar-SA' : 'en-US',
//       partialResults: true,
//       listenFor: const Duration(seconds: 30),
//       pauseFor: const Duration(seconds: 8),
//     );
//   }
//
//   Future<void> stopListening() async {
//     setState(() {
//       isListening = false;
//       _isRestarting = false;
//     });
//     await _speech.stop();
//   }
//
//   void _onResult(SpeechRecognitionResult result) {
//     setState(() {
//       transcription = result.recognizedWords;
//     });
//     _processWords(result.recognizedWords);
//   }
//
//   void _processWords(String spoken) {
//     if (spoken.isEmpty) return;
//
//     final spokenWords = spoken.trim().split(RegExp(r'\s+'));
//
//     // reset করো
//     setState(() {
//       isWrongList.fillRange(0, isWrongList.length, false);
//       _soundPlayed = false;
//     });
//
//     int matched = 0;
//     for (int i = 0; i < referenceWords.length && matched < spokenWords.length; i++) {
//       // Arabic diacritics সম্পূর্ণভাবে remove করো
//       final target = referenceWords[i].replaceAll(
//         RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED]'),
//         '',
//       );
//
//       final similarity = StringSimilarity.compareTwoStrings(
//         target.toLowerCase(),
//         spokenWords[matched].toLowerCase(),
//       );
//
//       setState(() {
//         opacityList[i] = 1.0;
//
//         if (similarity < 0.75) {
//           isWrongList[i] = true;
//           // ✅ একবারই sound বাজবে, বারবার না
//           if (!_soundPlayed) {
//             _soundPlayed = true;
//             _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//             _animationController.forward(from: 0.0);
//           }
//           matched++; // ✅ ভুল হলেও পরের শব্দে যাও
//         } else {
//           matched++;
//         }
//       });
//     }
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(referenceWords.length, (_) => 0.2);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//       transcription = "";
//       _soundPlayed = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Surah Fatiha Real-time Check",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Mode switch
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'arabic';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'arabic' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("Arabic", style: TextStyle(color: Colors.white)),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       currentMode = 'english';
//                       _updateReferenceWords();
//                       reset();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'english' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("English", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // Status indicator
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ✅ লাইভ indicator dot
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isListening ? Colors.red : Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     isListening ? "Listening..." : "Ready",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: isListening ? Colors.red : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Transcription
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 transcription.isEmpty ? "আপনার পড়া এখানে দেখাবে..." : transcription,
//                 textDirection: currentMode == 'arabic' ? TextDirection.rtl : TextDirection.ltr,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: transcription.isEmpty ? Colors.grey : Colors.black87,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // Legend
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(width: 12, height: 12, color: Colors.red[900]),
//                 const SizedBox(width: 6),
//                 const Text("ভুল", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black87),
//                 const SizedBox(width: 6),
//                 const Text("সঠিক", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black26),
//                 const SizedBox(width: 6),
//                 const Text("পড়া হয়নি", style: TextStyle(fontSize: 13)),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // Quran text
//             Wrap(
//               alignment: WrapAlignment.end,
//               spacing: 16,
//               runSpacing: 20,
//               children: referenceWords.asMap().entries.map((e) {
//                 int i = e.key;
//                 String word = e.value;
//                 bool isWrong = isWrongList[i];
//
//                 return ScaleTransition(
//                   scale: Tween<double>(
//                     begin: 1.0,
//                     end: isWrong ? 1.4 : 1.0,
//                   ).animate(CurvedAnimation(
//                     parent: _animationController,
//                     curve: Curves.easeInOut,
//                   )),
//                   child: AnimatedOpacity(
//                     opacity: opacityList[i],
//                     duration: const Duration(milliseconds: 600),
//                     child: Text(
//                       word,
//                       style: GoogleFonts.amiri(
//                         fontSize: isWrong ? 36 : 28,
//                         color: isWrong ? Colors.red[900] : Colors.black87,
//                         fontWeight: isWrong ? FontWeight.bold : FontWeight.normal,
//                       ),
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             const SizedBox(height: 80),
//
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: reset,
//                 icon: const Icon(Icons.refresh),
//                 label: const Text("Reset"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1D0835),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: ElevatedButton.icon(
//         onPressed: isListening ? stopListening : startListening,
//         icon: Icon(isListening ? Icons.stop : Icons.mic, size: 28),
//         label: Text(
//           isListening ? "Stop" : "Start Reciting",
//           style: const TextStyle(fontSize: 16),
//         ),
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//           backgroundColor: isListening ? Colors.red : const Color(0xFF1D0835),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
// }

//
//
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() {
//   runApp(const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//
//   // ✅ এখানে আপনার Gemini API Key দিন
//   static const String _geminiApiKey = 'AIzaSyA59Hp4CmEhIXAmsb9Sb6O7BNrUlcjxTCo';
//
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _speechInitialized = false;
//   bool isListening = false;
//   bool _isRestarting = false;
//   bool _isAnalyzing = false;
//   String transcription = "";
//   String feedbackMessage = "";
//   String currentMode = 'arabic';
//
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   final List<String> englishAyat = [
//     'In the name of Allah the Most Gracious the Most Merciful',
//     'All praise is due to Allah Lord of the worlds',
//     'The Most Gracious the Most Merciful',
//     'Master of the Day of Judgment',
//     'You alone we worship and You alone we ask for help',
//     'Guide us to the straight path',
//     'The path of those upon whom You have bestowed favor not of those who have evoked anger or of those who are astray',
//   ];
//
//   late List<String> referenceWords;
//   late List<double> opacityList;
//   late List<bool> isWrongList;
//   late List<String> wordFeedback;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateReferenceWords();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _initSpeech();
//   }
//
//   void _updateReferenceWords() {
//     final ayatList = currentMode == 'arabic' ? arabicAyat : englishAyat;
//     referenceWords = ayatList.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(referenceWords.length, (_) => 0.2);
//     isWrongList = List.generate(referenceWords.length, (_) => false);
//     wordFeedback = List.generate(referenceWords.length, (_) => '');
//   }
//
//   Future<void> _initSpeech() async {
//     _speechInitialized = await _speech.initialize(
//       onStatus: (status) {
//         debugPrint('Status: $status');
//         if ((status == 'done' || status == 'notListening') && isListening && !_isRestarting) {
//           Future.delayed(const Duration(milliseconds: 300), _restartListening);
//         }
//       },
//       onError: (error) {
//         debugPrint('Error: $error');
//         if (isListening && !_isRestarting) {
//           Future.delayed(const Duration(milliseconds: 500), _restartListening);
//         }
//       },
//     );
//   }
//
//   Future<void> _restartListening() async {
//     if (!isListening || _isRestarting) return;
//     _isRestarting = true;
//     try {
//       await _speech.stop();
//       await Future.delayed(const Duration(milliseconds: 200));
//       if (!isListening) { _isRestarting = false; return; }
//       await _speech.listen(
//         onResult: _onResult,
//         localeId: currentMode == 'arabic' ? 'ar-SA' : 'en-US',
//         partialResults: true,
//         listenFor: const Duration(seconds: 30),
//         pauseFor: const Duration(seconds: 8),
//       );
//     } catch (e) {
//       debugPrint('Restart error: $e');
//     } finally {
//       _isRestarting = false;
//     }
//   }
//
//   Future<void> startListening() async {
//     if (!_speechInitialized) await _initSpeech();
//     setState(() { isListening = true; _isRestarting = false; });
//     await _speech.listen(
//       onResult: _onResult,
//       localeId: currentMode == 'arabic' ? 'ar-SA' : 'en-US',
//       partialResults: true,
//       listenFor: const Duration(seconds: 30),
//       pauseFor: const Duration(seconds: 8),
//     );
//   }
//
//   Future<void> stopListening() async {
//     setState(() { isListening = false; _isRestarting = false; });
//     await _speech.stop();
//   }
//
//   void _onResult(SpeechRecognitionResult result) {
//     setState(() => transcription = result.recognizedWords);
//     // শুধু final result এ Gemini কে call করো
//     if (result.finalResult && transcription.isNotEmpty) {
//       _analyzeWithGemini(transcription);
//     }
//   }
//
//   // ✅ Gemini AI দিয়ে Arabic উচ্চারণ চেক
//   Future<void> _analyzeWithGemini(String spokenText) async {
//     if (_isAnalyzing) return;
//     setState(() => _isAnalyzing = true);
//
//     final fullAyat = arabicAyat.join(' ');
//
//     final prompt = currentMode == 'arabic'
//         ? '''
// আমি সূরা ফাতিহা পড়ছি। মূল আরবি টেক্সট হলো:
// "$fullAyat"
//
// আমি পড়েছি (Speech-to-Text থেকে):
// "$spokenText"
//
// তুমি একজন Quran tajweed expert। এই কাজগুলো করো:
// 1. প্রতিটি শব্দ মিলিয়ে দেখো
// 2. কোন শব্দগুলো ভুল উচ্চারণ হয়েছে সেগুলো চিহ্নিত করো
// 3. JSON format এ উত্তর দাও এভাবে:
// {
//   "wrongWords": ["ভুল শব্দ ১", "ভুল শব্দ ২"],
//   "feedback": "সংক্ষিপ্ত বাংলায় feedback",
//   "score": 85
// }
// শুধু JSON দাও, অন্য কিছু না।
// '''
//         : '''
// Surah Fatiha English transliteration:
// "${englishAyat.join(' ')}"
//
// User recited: "$spokenText"
//
// Compare word by word and return JSON:
// {
//   "wrongWords": ["wrong word 1", "wrong word 2"],
//   "feedback": "Brief feedback in English",
//   "score": 85
// }
// Return JSON only.
// ''';
//
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey',
//         ),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "contents": [
//             {
//               "parts": [
//                 {"text": prompt}
//               ]
//             }
//           ],
//           "generationConfig": {
//             "temperature": 0.1,
//             "maxOutputTokens": 500,
//           }
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
//
//         // JSON parse করো
//         final cleanJson = text.replaceAll('```json', '').replaceAll('```', '').trim();
//         final result = jsonDecode(cleanJson);
//
//         final wrongWords = List<String>.from(result['wrongWords'] ?? []);
//         final feedback = result['feedback'] ?? '';
//         final score = result['score'] ?? 0;
//
//         _applyGeminiFeedback(wrongWords, feedback, score);
//       }
//     } catch (e) {
//       debugPrint('Gemini error: $e');
//       setState(() => feedbackMessage = "AI analysis failed. Check internet.");
//     } finally {
//       setState(() => _isAnalyzing = false);
//     }
//   }
//
//   void _applyGeminiFeedback(List<String> wrongWords, String feedback, int score) {
//     setState(() {
//       feedbackMessage = "Score: $score/100 — $feedback";
//       isWrongList.fillRange(0, isWrongList.length, false);
//
//       for (int i = 0; i < referenceWords.length; i++) {
//         opacityList[i] = 1.0;
//         final word = referenceWords[i].replaceAll(
//           RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED]'),
//           '',
//         );
//         // Gemini যে শব্দগুলো ভুল বলেছে সেগুলো লাল করো
//         for (final wrong in wrongWords) {
//           final cleanWrong = wrong.replaceAll(
//             RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED]'),
//             '',
//           );
//           if (word.contains(cleanWrong) || cleanWrong.contains(word)) {
//             isWrongList[i] = true;
//             if (isWrongList[i]) _animationController.forward(from: 0.0);
//           }
//         }
//       }
//     });
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(referenceWords.length, (_) => 0.2);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//       wordFeedback = List.generate(referenceWords.length, (_) => '');
//       transcription = "";
//       feedbackMessage = "";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Surah Fatiha AI Check", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Mode switch
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => setState(() {
//                     currentMode = 'arabic';
//                     _updateReferenceWords();
//                     reset();
//                   }),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'arabic' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("Arabic", style: TextStyle(color: Colors.white)),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () => setState(() {
//                     currentMode = 'english';
//                     _updateReferenceWords();
//                     reset();
//                   }),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: currentMode == 'english' ? Colors.green : Colors.grey,
//                   ),
//                   child: const Text("English", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // Status
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     width: 12, height: 12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isListening ? Colors.red : Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     _isAnalyzing ? "AI analyzing..." : isListening ? "Listening..." : "Ready",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: _isAnalyzing ? Colors.orange : isListening ? Colors.red : Colors.grey,
//                     ),
//                   ),
//                   if (_isAnalyzing) ...[
//                     const SizedBox(width: 8),
//                     const SizedBox(
//                       width: 14, height: 14,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     ),
//                   ]
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Transcription box
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 transcription.isEmpty ? "আপনার পড়া এখানে দেখাবে..." : transcription,
//                 textDirection: currentMode == 'arabic' ? TextDirection.rtl : TextDirection.ltr,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: transcription.isEmpty ? Colors.grey : Colors.black87,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // ✅ Gemini AI feedback box
//             if (feedbackMessage.isNotEmpty)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: feedbackMessage.contains('Score: 9') || feedbackMessage.contains('Score: 10')
//                       ? Colors.green[50]
//                       : Colors.orange[50],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: feedbackMessage.contains('Score: 9') || feedbackMessage.contains('Score: 10')
//                         ? Colors.green
//                         : Colors.orange,
//                   ),
//                 ),
//                 child: Text(
//                   feedbackMessage,
//                   style: const TextStyle(fontSize: 14),
//                   textDirection: TextDirection.ltr,
//                 ),
//               ),
//
//             const SizedBox(height: 20),
//
//             // Legend
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(width: 12, height: 12, color: Colors.red[900]),
//                 const SizedBox(width: 6),
//                 const Text("ভুল", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black87),
//                 const SizedBox(width: 6),
//                 const Text("সঠিক", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black26),
//                 const SizedBox(width: 6),
//                 const Text("পড়া হয়নি", style: TextStyle(fontSize: 13)),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // Quran text
//             Wrap(
//               alignment: WrapAlignment.end,
//               spacing: 16,
//               runSpacing: 20,
//               children: referenceWords.asMap().entries.map((e) {
//                 int i = e.key;
//                 String word = e.value;
//                 bool isWrong = isWrongList[i];
//
//                 return ScaleTransition(
//                   scale: Tween<double>(begin: 1.0, end: isWrong ? 1.3 : 1.0).animate(
//                     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//                   ),
//                   child: AnimatedOpacity(
//                     opacity: opacityList[i],
//                     duration: const Duration(milliseconds: 600),
//                     child: Text(
//                       word,
//                       style: GoogleFonts.amiri(
//                         fontSize: isWrong ? 34 : 28,
//                         color: isWrong ? Colors.red[900] : Colors.black87,
//                         fontWeight: isWrong ? FontWeight.bold : FontWeight.normal,
//                       ),
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             const SizedBox(height: 80),
//
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: reset,
//                 icon: const Icon(Icons.refresh),
//                 label: const Text("Reset"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1D0835),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: ElevatedButton.icon(
//         onPressed: isListening ? stopListening : startListening,
//         icon: Icon(isListening ? Icons.stop : Icons.mic, size: 28),
//         label: Text(
//           isListening ? "Stop" : "Start Reciting",
//           style: const TextStyle(fontSize: 16),
//         ),
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//           backgroundColor: isListening ? Colors.red : const Color(0xFF1D0835),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }

//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class TajweedResult {
//   final List<String> wrongWords;
//   final String transcribed;
//   final int score;
//   final Map<String, String> rulesFeedback;
//
//   TajweedResult({
//     required this.wrongWords,
//     required this.transcribed,
//     required this.score,
//     required this.rulesFeedback,
//   });
// }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//
//   static const String _geminiApiKey = 'AIzaSyA59Hp4CmEhIXAmsb9Sb6O7BNrUlcjxTCoুুুু';
//
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   bool _recorderInitialized = false;
//   bool isRecording = false;
//   bool _isAnalyzing = false;
//   TajweedResult? _lastResult;
//   String statusMessage = "";
//
//   late AnimationController _animationController;
//
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمَ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   late List<String> referenceWords;
//   late List<double> opacityList;
//   late List<bool> isWrongList;
//   String? _recordedFilePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateReferenceWords();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _initRecorder();
//   }
//
//   void _updateReferenceWords() {
//     referenceWords = arabicAyat.expand((a) => a.split(' ')).toList();
//     opacityList = List.generate(referenceWords.length, (_) => 0.2);
//     isWrongList = List.generate(referenceWords.length, (_) => false);
//   }
//
//   Future<void> _initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (!status.isGranted) {
//       setState(() => statusMessage = "Microphone permission দিন!");
//       return;
//     }
//     await _recorder.openRecorder();
//     setState(() => _recorderInitialized = true);
//   }
//
//   Future<void> startRecording() async {
//     if (!_recorderInitialized) {
//       await _initRecorder();
//       return;
//     }
//     final dir = await getTemporaryDirectory();
//     _recordedFilePath = '${dir.path}/quran_recitation.aac';
//
//     await _recorder.startRecorder(
//       toFile: _recordedFilePath,
//       codec: Codec.aacADTS,
//     );
//
//     setState(() {
//       isRecording = true;
//       _lastResult = null;
//       statusMessage = "";
//       opacityList = List.generate(referenceWords.length, (_) => 0.2);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//     });
//   }
//
//   Future<void> stopRecordingAndAnalyze() async {
//     await _recorder.stopRecorder();
//     setState(() {
//       isRecording = false;
//       _isAnalyzing = true;
//       statusMessage = "Gemini AI analyzing tajweed...";
//     });
//     if (_recordedFilePath != null) {
//       await _analyzeWithGemini(_recordedFilePath!);
//     }
//   }
//
//   Future<void> _analyzeWithGemini(String audioPath) async {
//     try {
//       final audioFile = File(audioPath);
//       if (!await audioFile.exists()) {
//         setState(() {
//           statusMessage = "Audio file পাওয়া যায়নি!";
//           _isAnalyzing = false;
//         });
//         return;
//       }
//
//       final audioBytes = await audioFile.readAsBytes();
//       final audioBase64 = base64Encode(audioBytes);
//       final fullAyat = arabicAyat.join(' ');
//
//       // ✅ Gemini কে detailed tajweed expert হিসেবে prompt করা হচ্ছে
//       const prompt = '''
// You are an expert Quran tajweed teacher. I have recited Surah Al-Fatiha.
//
// The correct Arabic text is:
// "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ الرَّحْمَٰنِ الرَّحِيمَ مَالِكِ يَوْمِ الدِّينِ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
//
// Listen to the audio carefully and analyze these 6 tajweed rules:
//
// 1. MAKHARIJ: Are letters pronounced from correct throat/mouth positions?
// 2. SIFAAT: Are heavy letters (ص ض ط ظ ق) thick and light letters thin?
// 3. MADD: Are long vowels (ا و ي) stretched properly for 2+ counts?
// 4. GHUNNAH: Is nasal sound correct for ن and م rules?
// 5. WAQF: Are stops made at correct places?
// 6. TARTEEL: Is the pace slow and measured, not rushed?
//
// Return ONLY this JSON (no extra text):
// {
//   "transcribed": "what was recited in Arabic",
//   "wrongWords": ["Arabic words with mistakes"],
//   "score": 85,
//   "rules": {
//     "makharij": "feedback on letter pronunciation",
//     "sifaat": "feedback on heavy/light letters",
//     "madd": "feedback on long vowels",
//     "ghunnah": "feedback on nasal sounds",
//     "waqf": "feedback on stopping",
//     "tarteel": "feedback on pace"
//   }
// }
// ''';
//
//       final response = await http.post(
//         Uri.parse(
//           'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey',
//         ),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "contents": [
//             {
//               "parts": [
//                 {
//                   "inline_data": {
//                     "mime_type": "audio/aac",
//                     "data": audioBase64,
//                   }
//                 },
//                 {"text": prompt}
//               ]
//             }
//           ],
//           "generationConfig": {
//             "temperature": 0.1,
//             "maxOutputTokens": 1500,
//           }
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final text =
//         data['candidates'][0]['content']['parts'][0]['text'] as String;
//
//         final cleanJson =
//         text.replaceAll('```json', '').replaceAll('```', '').trim();
//         final result = jsonDecode(cleanJson);
//
//         final wrongWords = List<String>.from(result['wrongWords'] ?? []);
//         final score = (result['score'] ?? 0) as int;
//         final transcribed = result['transcribed'] ?? '';
//         final rules = Map<String, String>.from(
//           (result['rules'] as Map).map(
//                 (k, v) => MapEntry(k.toString(), v.toString()),
//           ),
//         );
//
//         final tajweedResult = TajweedResult(
//           wrongWords: wrongWords,
//           transcribed: transcribed,
//           score: score,
//           rulesFeedback: rules,
//         );
//
//         _applyResult(tajweedResult);
//       } else {
//         final errorData = jsonDecode(response.body);
//         setState(() {
//           statusMessage = "❌ API Error: ${errorData['error']['message']}";
//           _isAnalyzing = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         statusMessage = "❌ Error: $e";
//         _isAnalyzing = false;
//       });
//     }
//   }
//
//   void _applyResult(TajweedResult result) {
//     setState(() {
//       _isAnalyzing = false;
//       _lastResult = result;
//       statusMessage = "";
//
//       isWrongList.fillRange(0, isWrongList.length, false);
//
//       for (int i = 0; i < referenceWords.length; i++) {
//         opacityList[i] = 1.0;
//
//         final cleanRef = _removeHarakat(referenceWords[i]);
//
//         for (final wrong in result.wrongWords) {
//           final cleanWrong = _removeHarakat(wrong);
//           if (cleanRef.isNotEmpty &&
//               cleanWrong.isNotEmpty &&
//               (cleanRef.contains(cleanWrong) || cleanWrong.contains(cleanRef))) {
//             isWrongList[i] = true;
//           }
//         }
//
//         if (isWrongList[i]) {
//           _animationController.forward(from: 0.0);
//         }
//       }
//     });
//   }
//
//   String _removeHarakat(String text) {
//     return text.replaceAll(
//       RegExp(
//           r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED]'),
//       '',
//     );
//   }
//
//   void reset() {
//     setState(() {
//       opacityList = List.generate(referenceWords.length, (_) => 0.2);
//       isWrongList = List.generate(referenceWords.length, (_) => false);
//       _lastResult = null;
//       statusMessage = "";
//     });
//   }
//
//   // Score এর রং
//   Color _scoreColor(int score) {
//     if (score >= 90) return Colors.green;
//     if (score >= 70) return Colors.orange;
//     return Colors.red;
//   }
//
//   String _scoreEmoji(int score) {
//     if (score >= 90) return "🟢";
//     if (score >= 70) return "🟡";
//     return "🔴";
//   }
//
//   // Rule এর icon
//   IconData _ruleIcon(String rule) {
//     switch (rule) {
//       case 'makharij': return Icons.record_voice_over;
//       case 'sifaat': return Icons.tune;
//       case 'madd': return Icons.linear_scale;
//       case 'ghunnah': return Icons.air;
//       case 'waqf': return Icons.pause_circle_outline;
//       case 'tarteel': return Icons.speed;
//       default: return Icons.check_circle_outline;
//     }
//   }
//
//   String _ruleTitle(String rule) {
//     switch (rule) {
//       case 'makharij': return "Makharij — Letter sounds";
//       case 'sifaat': return "Sifaat — Heavy/Light letters";
//       case 'madd': return "Madd — Long vowels";
//       case 'ghunnah': return "Ghunnah — Nasal sounds";
//       case 'waqf': return "Waqf — Stopping rules";
//       case 'tarteel': return "Tarteel — Pace";
//       default: return rule;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Surah Fatiha Tajweed AI",
//             style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//
//             // ── Status bar ──
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     width: 14, height: 14,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isRecording
//                           ? Colors.red
//                           : _isAnalyzing
//                           ? Colors.orange
//                           : Colors.green,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     isRecording
//                         ? "Recording... (Stop when done)"
//                         : _isAnalyzing
//                         ? "AI Analyzing Tajweed..."
//                         : "Ready to recite",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: isRecording
//                           ? Colors.red
//                           : _isAnalyzing
//                           ? Colors.orange
//                           : Colors.green,
//                     ),
//                   ),
//                   if (_isAnalyzing) ...[
//                     const SizedBox(width: 8),
//                     const SizedBox(
//                       width: 14, height: 14,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     ),
//                   ]
//                 ],
//               ),
//             ),
//
//             if (statusMessage.isNotEmpty) ...[
//               const SizedBox(height: 8),
//               Center(
//                 child: Text(statusMessage,
//                     style: const TextStyle(color: Colors.red, fontSize: 13)),
//               ),
//             ],
//
//             const SizedBox(height: 20),
//
//             // ── Score card ──
//             if (_lastResult != null) ...[
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 32, vertical: 16),
//                   decoration: BoxDecoration(
//                     color: _scoreColor(_lastResult!.score).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                         color: _scoreColor(_lastResult!.score), width: 2),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "${_scoreEmoji(_lastResult!.score)} ${_lastResult!.score}/100",
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: _scoreColor(_lastResult!.score),
//                         ),
//                       ),
//                       Text(
//                         _lastResult!.score >= 90
//                             ? "Excellent recitation!"
//                             : _lastResult!.score >= 70
//                             ? "Good, keep practicing"
//                             : "Needs improvement",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: _scoreColor(_lastResult!.score),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//
//             // ── Legend ──
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(width: 12, height: 12, color: Colors.red[900]),
//                 const SizedBox(width: 6),
//                 const Text("ভুল", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black87),
//                 const SizedBox(width: 6),
//                 const Text("সঠিক", style: TextStyle(fontSize: 13)),
//                 const SizedBox(width: 20),
//                 Container(width: 12, height: 12, color: Colors.black26),
//                 const SizedBox(width: 6),
//                 const Text("পড়া হয়নি", style: TextStyle(fontSize: 13)),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // ── Quran text ──
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8F4EC),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: const Color(0xFFD4A853), width: 1),
//               ),
//               child: Wrap(
//                 alignment: WrapAlignment.end,
//                 spacing: 12,
//                 runSpacing: 16,
//                 children: referenceWords.asMap().entries.map((e) {
//                   int i = e.key;
//                   String word = e.value;
//                   bool isWrong = isWrongList[i];
//
//                   return ScaleTransition(
//                     scale: Tween<double>(
//                       begin: 1.0,
//                       end: isWrong ? 1.3 : 1.0,
//                     ).animate(CurvedAnimation(
//                       parent: _animationController,
//                       curve: Curves.easeInOut,
//                     )),
//                     child: AnimatedOpacity(
//                       opacity: opacityList[i],
//                       duration: const Duration(milliseconds: 600),
//                       child: Container(
//                         padding: isWrong
//                             ? const EdgeInsets.symmetric(
//                             horizontal: 6, vertical: 2)
//                             : EdgeInsets.zero,
//                         decoration: isWrong
//                             ? BoxDecoration(
//                           color: Colors.red[50],
//                           borderRadius: BorderRadius.circular(6),
//                           border: Border.all(color: Colors.red[300]!),
//                         )
//                             : null,
//                         child: Text(
//                           word,
//                           style: GoogleFonts.amiri(
//                             fontSize: isWrong ? 32 : 28,
//                             color:
//                             isWrong ? Colors.red[900] : Colors.black87,
//                             fontWeight: isWrong
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // ── 6 Tajweed Rules Feedback ──
//             if (_lastResult != null &&
//                 _lastResult!.rulesFeedback.isNotEmpty) ...[
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Tajweed Analysis",
//                   style: TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ..._lastResult!.rulesFeedback.entries.map((entry) {
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.grey[200]!),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(
//                         _ruleIcon(entry.key),
//                         color: const Color(0xFF1D0835),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               _ruleTitle(entry.key),
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF1D0835),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               entry.value,
//                               style: const TextStyle(
//                                   fontSize: 13, color: Colors.black87),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//               const SizedBox(height: 16),
//             ],
//
//             // ── Transcribed ──
//             if (_lastResult != null &&
//                 _lastResult!.transcribed.isNotEmpty) ...[
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Gemini শুনেছে:",
//                         style:
//                         TextStyle(fontSize: 12, color: Colors.grey)),
//                     const SizedBox(height: 4),
//                     Text(
//                       _lastResult!.transcribed,
//                       style: GoogleFonts.amiri(fontSize: 18),
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//
//             // ── Reset button ──
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: reset,
//                 icon: const Icon(Icons.refresh),
//                 label: const Text("Reset"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1D0835),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 30, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//
//       // ── Record FAB ──
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: _isAnalyzing
//           ? Container(
//         padding: const EdgeInsets.symmetric(
//             horizontal: 24, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.orange,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: const Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 18, height: 18,
//               child: CircularProgressIndicator(
//                   color: Colors.white, strokeWidth: 2),
//             ),
//             SizedBox(width: 10),
//             Text("AI Analyzing...",
//                 style:
//                 TextStyle(color: Colors.white, fontSize: 16)),
//           ],
//         ),
//       )
//           : ElevatedButton.icon(
//         onPressed:
//         isRecording ? stopRecordingAndAnalyze : startRecording,
//         icon: Icon(isRecording ? Icons.stop : Icons.mic, size: 28),
//         label: Text(
//           isRecording ? "Stop & Check" : "Start Reciting",
//           style: const TextStyle(fontSize: 16),
//         ),
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 40, vertical: 16),
//           backgroundColor:
//           isRecording ? Colors.red : const Color(0xFF1D0835),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30)),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     _animationController.dispose();
//     super.dispose();
//   }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:audioplayers/audioplayers.dart'; // সাউন্ডের জন্য
//
// void main() {
//   runApp(const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// class TajweedResult {
//   final List<String> wrongWords;
//   final String transcribed;
//   final int score;
//   final Map<String, String> rulesFeedback;
//
//   TajweedResult({
//     required this.wrongWords,
//     required this.transcribed,
//     required this.score,
//     required this.rulesFeedback,
//   });
// }
//
// enum WordState { unread, correct, wrong, current }
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//
//   static const String _geminiApiKey = 'YOUR_GEMINI_KEY';
//   static const String _whisperApiKey = ' Zp5vdXs0eWfcA';
//   static const int _chunkIntervalSeconds = 5;
//
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final AudioPlayer _audioPlayer = AudioPlayer(); // সাউন্ড প্লেয়ার
//
//   bool _recorderInitialized = false;
//   bool isRecording = false;
//   String statusMessage = "";
//   String? _recordedFilePath;
//
//   Timer? _chunkTimer;
//   int _currentWordIndex = 0;
//
//   // সঠিক সূরা ফাতিহা লিস্ট
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمِ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   late List<String> referenceWords;
//   late List<WordState> wordStates;
//
//   @override
//   void initState() {
//     super.initState();
//     _buildWordList();
//     _initRecorder();
//   }
//
//   void _buildWordList() {
//     referenceWords = [];
//     for (var ayah in arabicAyat) {
//       referenceWords.addAll(ayah.split(' '));
//     }
//     wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
//   }
//
//   Future<void> _initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status.isGranted) {
//       await _recorder.openRecorder();
//       setState(() => _recorderInitialized = true);
//     }
//   }
//
//   // ভুল হলে সাউন্ড বাজানোর ফাংশন
//   void _playErrorSound() async {
//     try {
//       await _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//     } catch (e) {
//       debugPrint("Sound error: $e");
//     }
//   }
//
//   Future<void> startRecording() async {
//     if (!_recorderInitialized) return;
//
//     final dir = await getTemporaryDirectory();
//     _recordedFilePath = '${dir.path}/full_recitation.m4a';
//
//     await _recorder.startRecorder(
//       toFile: _recordedFilePath,
//       codec: Codec.aacMP4,
//       sampleRate: 16000,
//       numChannels: 1,
//     );
//
//     setState(() {
//       isRecording = true;
//       _currentWordIndex = 0;
//       wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
//       if (wordStates.isNotEmpty) wordStates[0] = WordState.current;
//       statusMessage = "Reciting...";
//     });
//
//     _chunkTimer = Timer.periodic(const Duration(seconds: _chunkIntervalSeconds), (_) => _analyzeChunkRealtime());
//   }
//
//   Future<void> _analyzeChunkRealtime() async {
//     if (!isRecording || _recordedFilePath == null) return;
//
//     try {
//       final oldPath = _recordedFilePath!;
//       await _recorder.stopRecorder();
//
//       final dir = await getTemporaryDirectory();
//       _recordedFilePath = '${dir.path}/rec_${DateTime.now().millisecondsSinceEpoch}.m4a';
//
//       await _recorder.startRecorder(
//         toFile: _recordedFilePath,
//         codec: Codec.aacMP4,
//         sampleRate: 16000,
//       );
//
//       final transcribed = await _transcribeWithWhisper(oldPath);
//       if (transcribed.isNotEmpty) {
//         _updateWordHighlightsRealtime(transcribed);
//       }
//     } catch (e) {
//       debugPrint('Chunk error: $e');
//     }
//   }
//
//   Future<String> _transcribeWithWhisper(String audioPath) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('https://api.openai.com/v1/audio/transcriptions'));
//       request.headers['Authorization'] = 'Bearer $_whisperApiKey';
//       request.fields['model'] = 'whisper-1';
//       request.fields['language'] = 'ar';
//       request.files.add(await http.MultipartFile.fromPath('file', audioPath, filename: 'audio.m4a'));
//
//       var response = await http.Response.fromStream(await request.send());
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body)['text'] ?? '';
//       }
//     } catch (e) {
//       debugPrint('Whisper Error: $e');
//     }
//     return '';
//   }
//
//   void _updateWordHighlightsRealtime(String transcribed) {
//     final heardWords = transcribed.trim().split(RegExp(r'\s+'));
//     bool foundError = false;
//
//     setState(() {
//       for (var tw in heardWords) {
//         if (_currentWordIndex >= referenceWords.length) break;
//
//         String ref = _removeHarakat(referenceWords[_currentWordIndex]);
//         String trans = _removeHarakat(tw);
//
//         if (ref == trans || ref.contains(trans) || trans.contains(ref)) {
//           wordStates[_currentWordIndex] = WordState.correct;
//         } else {
//           wordStates[_currentWordIndex] = WordState.wrong;
//           foundError = true;
//         }
//         _currentWordIndex++;
//         if (_currentWordIndex < referenceWords.length) {
//           wordStates[_currentWordIndex] = WordState.current;
//         }
//       }
//     });
//
//     if (foundError) {
//       _playErrorSound();
//     }
//   }
//
//   String _removeHarakat(String text) =>
//       text.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '').trim();
//
//   Future<void> stopRecordingAndAnalyze() async {
//     _chunkTimer?.cancel();
//     await _recorder.stopRecorder();
//     setState(() => isRecording = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAF7F0),
//       appBar: AppBar(
//         title: const Text("Surah Fatiha AI Check", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(25),
//         child: Center(
//           child: Wrap(
//             alignment: WrapAlignment.end,
//             spacing: 12,
//             runSpacing: 20,
//             textDirection: TextDirection.rtl,
//             children: referenceWords.asMap().entries.map((e) {
//               return _buildWordWidget(e.value, wordStates[e.key]);
//             }).toList(),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: isRecording ? stopRecordingAndAnalyze : startRecording,
//         label: Text(isRecording ? "Stop" : "Start Reciting"),
//         icon: Icon(isRecording ? Icons.stop : Icons.mic),
//         backgroundColor: isRecording ? Colors.red : const Color(0xFF1D0835),
//       ),
//     );
//   }
//
//   Widget _buildWordWidget(String word, WordState state) {
//     // Opacity অনেক কম রাখা হয়েছে যাতে hide মনে হয়
//     double opacity = 0.5;
//     Color textColor = Colors.black45;
//     FontWeight weight = FontWeight.normal;
//
//     if (state == WordState.correct) {
//       opacity = 1.0;
//       textColor = Colors.green[700]!;
//       weight = FontWeight.bold;
//     } else if (state == WordState.wrong) {
//       opacity = 1.0;
//       textColor = Colors.red[700]!;
//       weight = FontWeight.bold;
//     } else if (state == WordState.current) {
//       opacity = 1.0;
//       textColor = Colors.blue[800]!;
//       weight = FontWeight.bold;
//     }
//
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 500),
//       opacity: opacity,
//       child: Text(
//         word,
//         style: GoogleFonts.amiri(fontSize: 32, color: textColor, fontWeight: weight),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _chunkTimer?.cancel();
//     _recorder.closeRecorder();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }

//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// void main() {
//   runApp(const GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuranRecitationScreen(),
//   ));
// }
//
// enum WordState { unread, correct, wrong, current }
//
//
// class QuranRecitationScreen extends StatefulWidget {
//   const QuranRecitationScreen({super.key});
//
//   @override
//   State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
// }
//
// class _QuranRecitationScreenState extends State<QuranRecitationScreen>
//     with SingleTickerProviderStateMixin {
//
//   static const String _whisperApiKey = '  fcA'; // আপনার কি এখানে দিন
//   static const int _chunkIntervalSeconds = 5;
//
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   bool _recorderInitialized = false;
//   bool isRecording = false;
//   String? _recordedFilePath;
//
//   Timer? _chunkTimer;
//   int _currentWordIndex = 0;
//
//   final List<String> arabicAyat = [
//     'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
//     'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
//     'الرَّحْمَٰنِ الرَّحِيمِ',
//     'مَالِكِ يَوْمِ الدِّينِ',
//     'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
//     'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
//     'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//   ];
//
//   late List<String> referenceWords;
//   late List<WordState> wordStates;
//
//   @override
//   void initState() {
//     super.initState();
//     _buildWordList();
//     _initRecorder();
//   }
//
//   void _buildWordList() {
//     referenceWords = [];
//     for (var ayah in arabicAyat) {
//       referenceWords.addAll(ayah.split(' '));
//     }
//     wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
//   }
//
//   Future<void> _initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status.isGranted) {
//       await _recorder.openRecorder();
//       setState(() => _recorderInitialized = true);
//     }
//   }
//
//   void _playErrorSound() async {
//     try {
//       await _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
//     } catch (e) {
//       debugPrint("Sound error: $e");
//     }
//   }
//
//   Future<void> startRecording() async {
//     if (!_recorderInitialized) return;
//
//     final dir = await getTemporaryDirectory();
//     _recordedFilePath = '${dir.path}/rec.m4a';
//
//     await _recorder.startRecorder(
//       toFile: _recordedFilePath,
//       codec: Codec.aacMP4,
//       sampleRate: 16000,
//       numChannels: 1,
//     );
//
//     setState(() {
//       isRecording = true;
//       _currentWordIndex = 0;
//       wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
//       if (wordStates.isNotEmpty) wordStates[0] = WordState.current;
//     });
//
//     _chunkTimer = Timer.periodic(const Duration(seconds: _chunkIntervalSeconds), (_) => _analyzeChunkRealtime());
//   }
//
//   Future<void> _analyzeChunkRealtime() async {
//     if (!isRecording || _recordedFilePath == null) return;
//
//     try {
//       final oldPath = _recordedFilePath!;
//       await _recorder.stopRecorder();
//
//       final dir = await getTemporaryDirectory();
//       _recordedFilePath = '${dir.path}/rec_${DateTime.now().millisecondsSinceEpoch}.m4a';
//
//       await _recorder.startRecorder(toFile: _recordedFilePath, codec: Codec.aacMP4);
//
//       final transcribed = await _transcribeWithWhisper(oldPath);
//       if (transcribed.isNotEmpty) {
//         // কনসোলে দেখা যাবে আপনি কী বলেছেন
//         debugPrint("🎤 AI Heard: $transcribed");
//         _updateWordHighlightsRealtime(transcribed);
//       }
//     } catch (e) {
//       debugPrint('Chunk error: $e');
//     }
//   }
//
//   Future<String> _transcribeWithWhisper(String audioPath) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('https://api.openai.com/v1/audio/transcriptions'));
//       request.headers['Authorization'] = 'Bearer $_whisperApiKey';
//       request.fields['model'] = 'whisper-1';
//       request.fields['language'] = 'ar';
//       request.fields['prompt'] = 'Surah Al-Fatiha recitation';
//       request.files.add(await http.MultipartFile.fromPath('file', audioPath, filename: 'audio.m4a'));
//
//       var response = await http.Response.fromStream(await request.send());
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body)['text'] ?? '';
//       }
//     } catch (e) {
//       debugPrint('Whisper Error: $e');
//     }
//     return '';
//   }
//
//   void _updateWordHighlightsRealtime(String transcribed) {
//     final heardWords = transcribed.trim().split(RegExp(r'\s+'));
//     bool foundError = false;
//
//     setState(() {
//       for (var tw in heardWords) {
//         if (_currentWordIndex >= referenceWords.length) break;
//
//         String ref = _removeHarakat(referenceWords[_currentWordIndex]);
//         String trans = _removeHarakat(tw);
//
//         // একটু নমনীয় ম্যাচিং লজিক (রিয়েল-টাইম এর জন্য ভালো)
//         if (ref == trans || ref.contains(trans) || trans.contains(ref)) {
//           wordStates[_currentWordIndex] = WordState.correct;
//         } else {
//           wordStates[_currentWordIndex] = WordState.wrong;
//           foundError = true;
//         }
//         _currentWordIndex++;
//         if (_currentWordIndex < referenceWords.length) {
//           wordStates[_currentWordIndex] = WordState.current;
//         }
//       }
//     });
//
//     if (foundError) {
//       _playErrorSound();
//     }
//   }
//
//   String _removeHarakat(String text) =>
//       text.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '').trim();
//
//   Future<void> stopRecordingAndAnalyze() async {
//     _chunkTimer?.cancel();
//     await _recorder.stopRecorder();
//     setState(() => isRecording = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAF7F0),
//       appBar: AppBar(
//         title: const Text("সূরা ফাতিহা তাজবীদ চেক", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1D0835),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(25),
//         child: Center(
//           child: Wrap(
//             alignment: WrapAlignment.end,
//             spacing: 12,
//             runSpacing: 25, // সঠিক শব্দ দেখানোর জন্য গ্যাপ বাড়ানো হয়েছে
//             textDirection: TextDirection.rtl,
//             children: referenceWords.asMap().entries.map((e) {
//               return _buildWordWidget(e.value, wordStates[e.key]);
//             }).toList(),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: isRecording ? stopRecordingAndAnalyze : startRecording,
//         label: Text(isRecording ? "Stop" : "Start Reciting"),
//         icon: Icon(isRecording ? Icons.stop : Icons.mic),
//         backgroundColor: isRecording ? Colors.red : const Color(0xFF1D0835),
//       ),
//     );
//   }
//
//   Widget _buildWordWidget(String word, WordState state) {
//     double opacity = 0.1; // ডিফল্ট অপাসিটি কমিয়ে ০.১ করা হয়েছে (Hide effect)
//     Color textColor = Colors.black45;
//     bool isWrong = (state == WordState.wrong);
//
//     if (state == WordState.correct) {
//       opacity = 1.0;
//       textColor = Colors.green[700]!;
//     } else if (isWrong) {
//       opacity = 1.0;
//       textColor = Colors.red[700]!;
//     } else if (state == WordState.current) {
//       opacity = 1.0;
//       textColor = Colors.blue[800]!;
//     }
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AnimatedOpacity(
//           duration: const Duration(milliseconds: 500),
//           opacity: opacity,
//           child: Text(
//             word,
//             style: GoogleFonts.amiri(
//                 fontSize: 32,
//                 color: textColor,
//                 fontWeight: (state == WordState.unread) ? FontWeight.normal : FontWeight.bold
//             ),
//           ),
//         ),
//         // ভুল হলে নিচে সঠিক শব্দটি ছোট করে দেখাবে
//         if (isWrong)
//           Text(
//             "(সঠিক: $word)",
//             style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _chunkTimer?.cancel();
//     _recorder.closeRecorder();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }





import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuranRecitationScreen(),
  ));
}

enum WordState { unread, correct, wrong, current }


class QuranRecitationScreen extends StatefulWidget {
  const QuranRecitationScreen({super.key});

  @override
  State<QuranRecitationScreen> createState() => _QuranRecitationScreenState();
}

class _QuranRecitationScreenState extends State<QuranRecitationScreen>
    with SingleTickerProviderStateMixin {

  static const String _whisperApiKey = '  '; // আপনার কি এখানে দিন

  static const int _chunkIntervalSeconds = 5;

  // ── Silence Detection Settings ──────────────────────
  // file size এর চেয়ে ছোট হলে user চুপ আছে বুঝবে
  // বেশি false positive → বাড়ান (20000)
  // কম detect হলে → কমান (8000)
  static const int _silenceFileSizeThreshold = 12000;
  static const int _silenceCountToStop = 2;
  // ───────────────────────────────────────────────────

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _recorderInitialized = false;
  bool isRecording = false;
  String? _recordedFilePath;

  Timer? _chunkTimer;
  int _currentWordIndex = 0;

  // ── নতুন variables ───────────────────────────────────
  bool _isSpeaking = false;
  int _silenceCount = 0;
  // ─────────────────────────────────────────────────────

  final List<String> arabicAyat = [
    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
    'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
    'الرَّحْمَٰنِ الرَّحِيمِ',
    'مَالِكِ يَوْمِ الدِّينِ',
    'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
    'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
    'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
  ];

  late List<String> referenceWords;
  late List<WordState> wordStates;

  @override
  void initState() {
    super.initState();
    _buildWordList();
    _initRecorder();
  }

  void _buildWordList() {
    referenceWords = [];
    for (var ayah in arabicAyat) {
      referenceWords.addAll(ayah.split(' '));
    }
    wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      await _recorder.openRecorder();
      setState(() => _recorderInitialized = true);
    }
  }

  void _playErrorSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/wrong_answer.wav'));
    } catch (e) {
      debugPrint("Sound error: $e");
    }
  }

  Future<void> startRecording() async {
    if (!_recorderInitialized) return;

    final dir = await getTemporaryDirectory();
    _recordedFilePath = '${dir.path}/rec.m4a';

    await _recorder.startRecorder(
      toFile: _recordedFilePath,
      codec: Codec.aacMP4,
      sampleRate: 16000,
      numChannels: 1,
    );

    setState(() {
      isRecording = true;
      _isSpeaking = false;   // ← নতুন
      _silenceCount = 0;     // ← নতুন
      _currentWordIndex = 0;
      wordStates = List.generate(referenceWords.length, (_) => WordState.unread);
      if (wordStates.isNotEmpty) wordStates[0] = WordState.current;
    });

    _chunkTimer = Timer.periodic(
      const Duration(seconds: _chunkIntervalSeconds),
          (_) => _analyzeChunkRealtime(),
    );
  }

  // ── UPDATED: Silence Detection সহ ────────────────────
  Future<void> _analyzeChunkRealtime() async {
    if (!isRecording || _recordedFilePath == null) return;

    try {
      final oldPath = _recordedFilePath!;
      await _recorder.stopRecorder();

      final dir = await getTemporaryDirectory();
      _recordedFilePath = '${dir.path}/rec_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.startRecorder(
        toFile: _recordedFilePath,
        codec: Codec.aacMP4,
        sampleRate: 16000,
        numChannels: 1,
      );

      // ── File size দিয়ে Silence detect ─────────────────
      final audioFile = File(oldPath);
      if (!await audioFile.exists()) return;

      final fileSize = await audioFile.length();
      debugPrint("📁 Chunk size: $fileSize bytes");

      if (fileSize < _silenceFileSizeThreshold) {
        // User চুপ আছে — Whisper এ পাঠাবো না
        _silenceCount++;
        debugPrint("🔇 Silence ($_silenceCount/$_silenceCountToStop)");

        if (_silenceCount >= _silenceCountToStop && _isSpeaking) {
          setState(() => _isSpeaking = false);
        }
        return; // ← এখানেই থামা, কোনো ভুল দেখাবে না ✅
      }

      // ── User পড়ছে ─────────────────────────────────────
      _silenceCount = 0;
      if (!_isSpeaking) setState(() => _isSpeaking = true);

      final transcribed = await _transcribeWithWhisper(oldPath);
      if (transcribed.isNotEmpty) {
        debugPrint("🎤 AI Heard: $transcribed");
        _updateWordHighlightsRealtime(transcribed);
      }
    } catch (e) {
      debugPrint('Chunk error: $e');
    }
  }

  Future<String> _transcribeWithWhisper(String audioPath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://api.openai.com/v1/audio/transcriptions'));
      request.headers['Authorization'] = 'Bearer $_whisperApiKey';
      request.fields['model'] = 'whisper-1';
      request.fields['language'] = 'ar';
      request.fields['prompt'] = 'Surah Al-Fatiha recitation';
      request.files.add(await http.MultipartFile.fromPath('file', audioPath, filename: 'audio.m4a'));

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['text'] ?? '';
      }
    } catch (e) {
      debugPrint('Whisper Error: $e');
    }
    return '';
  }

  void _updateWordHighlightsRealtime(String transcribed) {
    final heardWords = transcribed.trim().split(RegExp(r'\s+'));
    bool foundError = false;

    setState(() {
      for (var tw in heardWords) {
        if (_currentWordIndex >= referenceWords.length) break;

        String ref = _removeHarakat(referenceWords[_currentWordIndex]);
        String trans = _removeHarakat(tw);

        if (ref == trans || ref.contains(trans) || trans.contains(ref)) {
          wordStates[_currentWordIndex] = WordState.correct;
        } else {
          wordStates[_currentWordIndex] = WordState.wrong;
          foundError = true;
        }
        _currentWordIndex++;
        if (_currentWordIndex < referenceWords.length) {
          wordStates[_currentWordIndex] = WordState.current;
        }
      }
    });

    if (foundError) {
      _playErrorSound();
    }
  }

  String _removeHarakat(String text) =>
      text.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '').trim();

  Future<void> stopRecordingAndAnalyze() async {
    _chunkTimer?.cancel();
    await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
      _isSpeaking = false;   // ← নতুন
      _silenceCount = 0;     // ← নতুন
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      appBar: AppBar(
        title: const Text("সূরা ফাতিহা তাজবীদ চেক", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D0835),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 12,
            runSpacing: 25,
            textDirection: TextDirection.rtl,
            children: referenceWords.asMap().entries.map((e) {
              return _buildWordWidget(e.value, wordStates[e.key]);
            }).toList(),
          ),
        ),
      ),

      // ── UPDATED FAB — Speaking Indicator সহ ────────────
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          // Speaking / Silence Badge
          if (isRecording)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _isSpeaking ? Colors.green.shade600 : Colors.grey.shade600,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: (_isSpeaking ? Colors.green : Colors.grey).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isSpeaking ? Icons.graphic_eq : Icons.mic_off,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _isSpeaking ? "পড়ছেন..." : "চুপ আছেন...",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // Main FAB
          FloatingActionButton.extended(
            onPressed: isRecording ? stopRecordingAndAnalyze : startRecording,
            label: Text(isRecording ? "Stop" : "Start Reciting"),
            icon: Icon(isRecording ? Icons.stop : Icons.mic),
            backgroundColor: isRecording ? Colors.red : const Color(0xFF1D0835),
          ),
        ],
      ),
    );
  }

  Widget _buildWordWidget(String word, WordState state) {
    double opacity = 0.1;
    Color textColor = Colors.black45;
    bool isWrong = (state == WordState.wrong);

    if (state == WordState.correct) {
      opacity = 1.0;
      textColor = Colors.green[700]!;
    } else if (isWrong) {
      opacity = 1.0;
      textColor = Colors.red[700]!;
    } else if (state == WordState.current) {
      opacity = 1.0;
      textColor = Colors.blue[800]!;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: opacity,
          child: Text(
            word,
            style: GoogleFonts.amiri(
                fontSize: 32,
                color: textColor,
                fontWeight: (state == WordState.unread) ? FontWeight.normal : FontWeight.bold
            ),
          ),
        ),
        if (isWrong)
          Text(
            "(সঠিক: $word)",
            style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _chunkTimer?.cancel();
    _recorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }
}