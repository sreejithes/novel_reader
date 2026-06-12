import 'package:flutter/material.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExampleApp(),
      localizationsDelegates: [ReaderLocalizationsDelegate()],
      supportedLocales: [Locale('en')],
    ),
  );
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Novel Reader Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => NovelReader(
                      config: ReaderConfig(
                        title: "The Great Gatsby",
                        chapters: [
                          Chapter(
                            id: "1",
                            title: "Chapter 1",
                            content:
                                "In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since. 'Whenever you feel like criticizing anyone,' he told me, 'just remember that all the people in this world haven't had the advantages that you've had.'\n\nHe didn't say any more, but we've always been unusually communicative in a reserved way, and I understood that he meant a great deal more than that. In consequence, I'm inclined to reserve all judgments, a habit that has opened up many curious natures to me and also made me the victim of not a few veteran bores.\n\n" *
                                10,
                            order: 1,
                          ),
                          Chapter(
                            id: "2",
                            title: "Chapter 2",
                            content:
                                "About half way between West Egg and New York the motor road hastily joins the railroad and runs beside it for a quarter of a mile, so as to shrink away from a certain desolate area of land. This is a valley of ashes—a fantastic farm where ashes grow like wheat into ridges and hills and grotesque gardens; where ashes take the forms of houses and chimneys and rising smoke and, finally, with a transcendent effort, of men who move dimly and already crumbling through the powdery air.\n\n" *
                                10,
                            order: 2,
                          ),
                          Chapter(
                            id: "3",
                            title: "Chapter 3",
                            content:
                                "There was music from my neighbor's house through the summer nights. In his blue gardens men and girls came and went like moths among the whisperings and the champagne and the stars. At high tide in the afternoon I watched his guests diving from the tower of his raft, or taking the sun on the hot sand of his beach while his two motor-boats slit the waters of the Sound, drawing aquaplanes over cataracts of foam.",
                            order: 3,
                          ),
                          Chapter(
                            id: "4",
                            title: "Chapter 4",
                            content:
                                "On Sunday morning while church bells rang in the villages alongshore, the world and its mistress returned to Gatsby's house and twinkled hilariously on his lawn.",
                            order: 4,
                          ),
                        ],
                      ),
                      onNextChapter: () {
                        debugPrint("Example: Next chapter requested");
                      },
                      onChapterChanged: (index) {
                        debugPrint("Example: Now reading chapter $index");
                      },
                    ),
              ),
            );
          },
          child: const Text('Open Reader'),
        ),
      ),
    );
  }
}
