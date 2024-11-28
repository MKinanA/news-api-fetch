import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_api_fetch/models/news.dart';
import 'package:news_api_fetch/portals.dart';
import 'package:news_api_fetch/provider/news_data.dart';
import 'package:provider/provider.dart';

const bool kDebugMode = false;
const num screenPaddingXFactor = 32;
const String generalErrorMessage = 'An error occured';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => NewsData(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitPage(),
    );
  }
}

class InitPage extends StatefulWidget {
  const InitPage({
    super.key,
  });

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  final List<Map<String, dynamic>> pages = const [
    {
      'page': HomePage(),
      'icon': Icons.home,
      'label': 'Home',
    },
    {
      'page': SavedPage(),
      'icon': Icons.bookmarks,
      'label': 'Saved',
    },
  ];
  late final PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() => setState(() {
      currentIndex = pageController.page?.round() ?? 0;
    }));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: List.generate(pages.length, (index) => pages[index]['page']),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ((){
          try {
            return pageController.page;
          } catch (e) {
            return 0;
          }
        })()?.round() ?? 0,
        onTap: (index) => setState(() {
          pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        }),
        items: List.generate(pages.length, (index) => BottomNavigationBarItem(
          icon: Icon(pages[index]['icon']),
          label: pages[index]['label'],
        )),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  final Map<String, String> portalAndCategory = {
    'portal': portals.keys.toList()[0],
    'category': portals[portals.keys.toList()[0]]![0],
  };

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    (kDebugMode ? print : log)('Viewing news from portal "${portalAndCategory['portal']}" and category "${portalAndCategory['category']}"');
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / screenPaddingXFactor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'News',
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 48.0,
                      width: 128.0,
                      child: DropdownMenu(
                        inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none
                        ),
                        initialSelection: 0,
                        onSelected: (index) => portalAndCategory['portal'] != portals.keys.toList()[index ?? 0] ? setState(() {
                          portalAndCategory['portal'] = portals.keys.toList()[index ?? 0];
                          if (!(portals[portalAndCategory['portal']]?.contains(portalAndCategory['category']) ?? false)) portalAndCategory['category'] =  portals[portals.keys.toList()[index ?? 0]]![0];
                        }) : null,
                        dropdownMenuEntries: List.generate(portals.length, (index) => DropdownMenuEntry(
                          value: index,
                          label: portals.keys.toList()[index],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                      width: 128.0,
                      child: DropdownMenu(
                        inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none
                        ),
                        initialSelection: ((){
                          (kDebugMode ? print : log)('Current category: "${portalAndCategory['category']}"');
                          return portals[portalAndCategory['portal']]?.indexOf(portalAndCategory['category'] ?? '') ?? 0;
                        })(),
                        onSelected: (index) => portalAndCategory['category'] != portals[portalAndCategory['portal']]![index ?? 0] ? setState(() {
                          portalAndCategory['category'] = portals[portalAndCategory['portal']]![index ?? 0];
                        }) : null,
                        dropdownMenuEntries: ((){
                          (kDebugMode ? print : log)('Listing categories from portal "${portalAndCategory['portal']}"');
                          return List.generate(portals[portalAndCategory['portal']]?.length ?? 0, (index) => DropdownMenuEntry(
                            value: index,
                            label: portals[portalAndCategory['portal']]![index] != '' ? portals[portalAndCategory['portal']]![index] : 'Default',
                          ));
                        })(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: context.watch<NewsData>().get(portal: portalAndCategory['portal']!.lowerAndHyphenify, category: portalAndCategory['category']!.lowerAndHyphenify, kDebugMode: kDebugMode),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : snapshot.hasError
            ? LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth / screenPaddingXFactor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        size: 64.0,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        'Failed to display news',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.0,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextButton(
                        onPressed: context.read<NewsData>().forceNotifyListeners,
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  try {
                    await context.read<NewsData>().update(portal: portalAndCategory['portal']!.lowerAndHyphenify, category: portalAndCategory['category']!.lowerAndHyphenify, kDebugMode: kDebugMode);
                  } catch (e) {
                    (kDebugMode ? print : log)(e.toString());
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                          child: Text(generalErrorMessage),
                        ),
                      ));
                    }
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      ((snapshot.data?.length ?? 0) * 2) + 1,
                      (index) => index % 2 != 0
                        ? NewsListItem(snapshot.data?[(index - 1) ~/ 2] ?? News({}))
                        : SizedBox(
                            height: index >= ((snapshot.data?.length ?? 0) * 2) ? 256.0 : 12.0,
                          ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / screenPaddingXFactor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved News',
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: context.watch<NewsData>().savedNews.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                ((context.watch<NewsData>().savedNews.length) * 2) + 1,
                (index) => index % 2 != 0
                  ? NewsListItem(context.watch<NewsData>().savedNews[(index - 1) ~/ 2])
                  : SizedBox(
                      height: index >= ((context.watch<NewsData>().savedNews.length) * 2) ? 256.0 : 12.0,
                    ),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth / screenPaddingXFactor,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 64.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'No Saved News',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.0,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'News you\'ve saved will appear here. Click on the bookmark icon in a news page to get started.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          )
    );
  }
}

class NewsListItem extends StatelessWidget {
  final News news;

  const NewsListItem(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.parse(news.isoDate);

    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth / screenPaddingXFactor,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0)
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailsPage(news),
            )),
            child: SizedBox(
              width: constraints.maxWidth,
              height: 96.0,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Hero(
                      tag: news.hashCode,
                      child: Image.network(
                        news.image['small'] ?? news.image['medium'] ?? news.image['large'] ?? news.image['only'] ?? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAwAB/aqxkAAAAABJRU5ErkJggg==',
                        width: 96.0,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                          ? child
                          : SizedBox(
                              width: 96.0,
                              height: double.infinity,
                              child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                  ),
                                ),
                            ),
                        errorBuilder: (context, error, stackTrace) => const SizedBox(
                          width: 96.0,
                          height: double.infinity,
                          child: Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 48.0,
                                color: Colors.black54,
                              ),
                            ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${time.day}/${time.month}/${time.year} ${time.hour.toString().length <= 1 ? '0' : ''}${time.hour}:${time.minute.toString().length <= 1 ? '0' : ''}${time.minute}:${time.second.toString().length <= 1 ? '0' : ''}${time.second}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.0,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          news.title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.25,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final News news;

  const DetailsPage(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.parse(news.isoDate);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / screenPaddingXFactor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Text(
                    news.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                NewsSaveButton(news),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / screenPaddingXFactor,
                ),
                child: Text(
                  '${time.day}/${time.month}/${time.year} ${time.hour.toString().length <= 1 ? '0' : ''}${time.hour}:${time.minute.toString().length <= 1 ? '0' : ''}${time.minute}:${time.second.toString().length <= 1 ? '0' : ''}${time.second}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.0,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / screenPaddingXFactor,
                ),
                child: Text(
                  news.title,
                  style: const TextStyle(
                    height: 1.25,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / screenPaddingXFactor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Hero(
                    tag: news.hashCode,
                    child: Image.network(
                      news.image['large'] ?? news.image['medium'] ?? news.image['small'] ?? news.image['only'] ?? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAwAB/aqxkAAAAABJRU5ErkJggg==',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                        ? child
                        : SizedBox(
                            width: double.infinity,
                            height: 96.0,
                            child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                                ),
                              ),
                          ),
                      errorBuilder: (context, error, stackTrace) => const SizedBox(
                        width: double.infinity,
                        height: 96.0,
                        child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 48.0,
                              color: Colors.black54,
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / screenPaddingXFactor,
                ),
                child: Text(
                  news.contentSnippet,
                  style: const TextStyle(
                    height: 1.25,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () async {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(
                child: Text('Coming soon'),
              ),
            ));
          }
          /*try {
            throw Exception('An error occurred');
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(
                  child: Text(generalErrorMessage),
                ),
              ));
            }
          }*/
        },
        child: const Text(
          'Read More',
          style: TextStyle(
            height: 2.5,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class NewsSaveButton extends StatefulWidget {
  final News news;

  const NewsSaveButton(this.news, {super.key});

  @override
  State<NewsSaveButton> createState() => _NewsSaveButtonState();
}

class _NewsSaveButtonState extends State<NewsSaveButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() {
        widget.news.isSavedIn(context.read<NewsData>()) ? widget.news.unsaveFrom(context.read<NewsData>()) : widget.news.saveTo((context.read<NewsData>()));
        (kDebugMode ? print : log)('Updated a news\' isSavedOn(NewsData) state to ${widget.news.isSavedIn(context.read<NewsData>())}');
      }),
      icon: Icon(widget.news.isSavedIn(context.watch<NewsData>()) ? Icons.bookmark : Icons.bookmark_border),
    );
  }
}
