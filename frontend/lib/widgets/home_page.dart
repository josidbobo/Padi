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
              'Oniduro',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(width: 676),
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
                                            'We now store portfolio assets in Mento cUSD on Celo Protocol', style: TextStyle(color: Colors.white),),
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
                        text: 'Oniduro',
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
                                  'the EVM compatible chain - Celo, the volatility of financial markets has made it of ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'great concern to people on their finances that\'s why you should feel safe when ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white70, fontSize: 21)),
                          TextSpan(
                              text:
                                  'you know that Oniduro is protecting you and/or your loved ones against inflation and loss by ',
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
                      "Live up your life, while knowing that your loved ones and you are protected by Oniduro with our policies ranging from Life, health, Property, Business and Automobile Insurance.",
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
                                  "data:image/jpeg;base64,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EREBERAREQEREBERAREQEREBERAREQEREBERAREQERED/9k=",
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
              'Hello there, we are the best Decentralised Hedgings Protocol on Celo, a fast and green positive Ethereum compatible chain below are the considerations why we are better than our competitors.',
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
                      text: 'Oniduro ',
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
