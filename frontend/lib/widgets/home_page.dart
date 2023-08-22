import 'package:flutter/material.dart';
import 'package:insurance_dapp/providers/metamask_provider.dart';
import 'package:insurance_dapp/widgets/list_view_widget.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_html/flutter_html.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({Key? key}) : super(key: key);

  final Color color = Colors.lightBlue[100] as Color;

  void showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: SizedBox(
              height: 160,
              width: 210,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color?>(
                              Colors.orange[800],
                            )),
                        onPressed: () =>
                            context.read<MetaMaskProvider>().connect(),
                        child: const Text(
                          "Connect Browser Wallet",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 20,),
                  SizedBox( 
                    height: 55,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<MetaMaskProvider>().cconnect(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,),
                      child: const Center(
                          child: Text('WalletConnect Modal',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 33,
            ),
            Text(
              'Padi',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(width: 696),
            const Text('Home'),
            const SizedBox(width: 22),
            const Text('Partners'),
            const SizedBox(width: 22),
            const Text('About Us'),
            const SizedBox(width: 22),
            const Text('Blog'),
            const SizedBox(width: 39),
            Consumer<MetaMaskProvider>(builder: (context, provider, child) {
              return ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                        Color.fromARGB(255, 6, 26, 61),
                      )),
                  onPressed: () => showDialogBox(context),
                  child: const Text(
                    "Connect Wallet",
                    style: TextStyle(color: Colors.white),
                  ));
            }),
            const SizedBox(
              width: 5,
            ),
            // Consumer<MetaMaskProvider>(builder: (context, provider, child) {
            //   return
            // }),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 33,
            ),
            SizedBox(
                height: 450,
                width: 560,
                // color: Colors.blue,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 550,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 10, 44, 111),
                            ),
                                child: const Column(
                                  children: [
                                     SizedBox(height: 6),
                                     Row(
                                       children: [
                                        SizedBox(width: 50,),
                                         Text(
                                            'We now store portfolio assets in stable coins on Linea testnet', style: TextStyle(color: Colors.white),),
                                       ],
                                     ),
                                  ],
                                )),
                          Positioned(
                            left: 0.1,
                            child: Container(
                              height: 30,
                              width: 43,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 212, 219, 232),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: const Center(
                                  child: Text(
                                'NEW',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 240,
                    width: 550,
                    child: Text.rich(
                      
                      textAlign: TextAlign.justify,
                      TextSpan(
                        text: 'Padi',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 34, color: Color.fromARGB(255, 98, 178, 218),),
                        children: [
                          TextSpan(
                              text:
                                  ' prides itself in being one of the best decentralised savings, Insurance and financial hedgings protocol on ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'linea chain, the volatility of financial markets has made it of ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'great concern to people on their finances that\'s why you should feel safe when ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'you know that Padi is protecting you and/or your loved ones against inflation and loss by ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'insuring your family, property and so much more risk free on the Blockchain ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                        ])),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  const SizedBox(
                    width: 550,
                    child: Text(
                      "Live up your life, while knowing that your loved ones and you are protected by Padi with our policies ranging from Life, health, Property, Business and Automobile Insurance.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 133, 196, 228),
                          leadingDistribution: TextLeadingDistribution.even),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                  Color.fromARGB(255, 10, 44, 111)
                                )),
                            onPressed: () {},
                            child: const Text(
                              "Get a Quote",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      const Text('Or', style: TextStyle(color: Colors.white),),
                      const SizedBox(
                        width: 9,
                      ),
                      SizedBox(
                        height: 40,
                        width: 140,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: const BorderSide(
                                          color: Colors.blue, width: 10)),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                  Colors.blueGrey,
                                )),
                            onPressed: () {},
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  leadingDistribution:
                                      TextLeadingDistribution.even),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 15),
                          Text('Some Technologies we use',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              width: 94,
                              height: 45,
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZFzeozVjTSHuTQTtlCH-QoWMXrjr0KP0gqgm7eJOsUA&s",
                                  fit: BoxFit.fill,
                                ),
                              )),
                          const SizedBox(
                            width: 17,
                          ),
                          SizedBox(
                              height: 45,
                              width: 94,
                              child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJSWLvwOkOjnm_iOY1svm2UWiNdQxxsiuXb_oCfr4biw&s"))),
                          const SizedBox(
                            width: 17,
                          ),
                          SizedBox(
                              height: 45,
                              width: 94,
                              child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    "data:image/png;base64,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",
                                    fit: BoxFit.fill,
                                  ))),
                        ],
                      ),
                    ],
                  )
                ])),
            const SizedBox(
              width: 120,
            ),
            Stack(
              children: [
                Container(
                  height: 420,
                  width: 550,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(.02), color],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(227)),
                  ),
                ),
                Positioned(
                  bottom: 0.1,
                  right: 0.1,
                  child: Container(
                    height: 399,
                    width: 530,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(227)),
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(227)),
                      child: Image.network(
                        "https://catholicmedphx.org/wp-content/uploads/2018/09/happy-family.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 28),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'FEATURES',
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text(
              'Why are we better than the others',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 23, color: Colors.blueGrey),
            ),
            const Text(
              'Hello there, we are the best Decentralised Hedgings Protocol on Linea, a fast and green positive Ethereum compatible chain below are the considerations why we are better than our competitors.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 22,
        ),
        SizedBox(
          height: 350,
          width: 1100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScrollableW(
                mainText: 'Certified Platform',
                subText:
                    'All our contracts have been audited and undergo continuous scrutiny to insure safety of all funds.',
                iconImage: Image.network(
                    "https://png.pngtree.com/png-vector/20201027/ourlarge/pngtree-business-certificate-cartoon-iso-plant-illustration-png-image_2379016.jpg",
                    fit: BoxFit.cover),
              ),
              ScrollableW(
                mainText: 'Experienced Team',
                subText:
                    'Our team and partners will ensure that you have a seemless experience that you can never get anywhere else',
                iconImage: Image.network(
                  "https://static.vecteezy.com/system/resources/thumbnails/008/414/628/small_2x/employment-agency-for-recruitment-or-placement-job-service-with-skilled-and-experienced-career-laborers-in-flat-cartoon-illustration-vector.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ScrollableW(
                  mainText: '24/7 Service',
                  subText:
                      'Need help with creating a portfolio? No worries because we are here 24/7 at your service',
                  iconImage: Image.network(
                      "https://static.vecteezy.com/system/resources/previews/018/827/319/non_2x/clock-24-7-icon-in-comic-style-watch-cartoon-illustration-on-white-isolated-background-timer-splash-effect-business-concept-vector.jpg",
                      fit: BoxFit.cover))
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 1320,
                height: 50,
                color: Color.fromARGB(255, 6, 26, 61),
                child: Center(
                  child: Text.rich(TextSpan(
                      text: 'Padi ',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 21, color: Colors.blue[800]),
                      children: [
                        TextSpan(
                            text: ' © 2023',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white))
                      ])),
                ),
              )
            ])
      ],
    );
  }
}
