import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurance_dapp/providers/metamask_provider.dart';
import 'package:insurance_dapp/screens/makeClaim.dart';
import 'package:insurance_dapp/screens/portfolio.dart';
import 'package:insurance_dapp/widgets/home_page.dart';
import 'package:provider/provider.dart';
import './providers/insurance_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MetaMaskProvider()),
      ChangeNotifierProvider(create: (_) => InsuranceProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Padi.io',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.grey[100],
          textTheme: TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Amhara',
                fontSize: 21,
                color: Colors.green[800],
              ),
              displayMedium: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: const TextStyle(
                fontSize: 19,
              )),
          colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white,
                  brightness: Brightness.light,
                  primary: Colors.black)
              .copyWith(secondary: Colors.blue[600]),
        ),
        //home: const MyHomePage(title: 'Egbon Adugbo Insurance Ltd'),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const MyHomePage(title: 'Padi Protocol'),
          '/portfolio': (context) => Portfolio(),
          '/makeClaims': (context) => const SearchPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 250,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 250,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 250,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 250,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (context) => MetaMaskProvider()..onInit(),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 58, 58, 98),
            body: RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: _handleKeyEvent,
              child: Scrollbar(
                thickness: 13.0,
                controller: _controller,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  padding:
                      EdgeInsets.only(right: media * .06, left: media * .06),
                  child: Consumer<MetaMaskProvider>(
                      builder: (context, provider, child) {
                    String text = '';
                    if (provider.isConnected && provider.isOperatingChain) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context)
                            .pushReplacementNamed("/portfolio");
                      });
                    } else if (provider.isConnected &&
                        !provider.isOperatingChain) {
                       provider.switchChain();
                      text =
                          "Wrong Chain ${context.watch<MetaMaskProvider>().currentChain}. Please connect to Linea Goerli Testnet 59140!";
                      return Center(
                          child: Text(
                        text,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ));
                    } else if (provider.noBrowserWallet) {
                      text =
                          'Please use an ethereum enabled browser to access this site or walletConnect Modal';
                    } else {
                      return HomePageWidget();
                    }
                    return Center(
                        child: Text(
                      text,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                    ));
                  }),
                ),
              ),
            ),
          );
        });
  }
}
