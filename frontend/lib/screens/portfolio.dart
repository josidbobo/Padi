import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insurance_dapp/widgets/portfolios_view.dart';
import 'package:insurance_dapp/widgets/progressIndicator.dart';
import 'package:insurance_dapp/widgets/toastBody.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart' as c;
import '../widgets/text_field.dart';
import 'package:motion_toast/motion_toast.dart';

import '../providers/insurance_provider.dart';
import '../providers/metamask_provider.dart';

class Portfolio extends StatefulWidget {
  final insureAmount = TextEditingController();
  final insureBeneficiary = TextEditingController();
  final insurePassword = TextEditingController();
  final typeOfInsurance = TextEditingController();
  final amountForBenef = TextEditingController();
  Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  ScrollController scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();

  void disppose() {
    widget.insureAmount.clear();
    widget.amountForBenef.clear();
    widget.insureBeneficiary.clear();
    widget.insurePassword.clear();
    widget.typeOfInsurance.clear();
  }

  @override
  void didChangeDependencies() {
    c.Provider.of<MetaMaskProvider>(context).connect();
    c.Provider.of<InsuranceProvider>(context).getInsurances();
    super.didChangeDependencies();
  }

  void _showCreateDialog(context) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: Color.fromARGB(255, 7, 76, 132),
            child: SizedBox(
              height: 410,
              width: 710,
              child: c.Consumer<InsuranceProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        "CREATE A NEW (SAVINGS/HEDGINGS) PORTFOLIO",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextView(
                        text: 'Amount in ETH eg: 0.20',
                        controller: widget.insureAmount),
                    TextView(
                        text: 'Name of portfolio',
                        controller: widget.typeOfInsurance),
                    TextView(
                        text: 'Beneficiary address',
                        controller: widget.insureBeneficiary),
                    TextView(
                        text: 'Max amount beneficiary is allowed to withdraw',
                        controller: widget.amountForBenef),
                    !provider.isInsureed
                        ? TextView(
                            text: 'password', controller: widget.insurePassword)
                        : const SizedBox(),
                    ListTile(
                      trailing: SizedBox(
                        height: 36,
                        width: 170,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                Colors.orange[600],
                              )),
                          onPressed: () async {
                            try {
                              provider.isInsureed
                                  ? await context
                                      .read<InsuranceProvider>()
                                      .insure(
                                          widget.typeOfInsurance.text,
                                          widget.insureAmount.text,
                                          widget.insureBeneficiary.text,
                                          widget.amountForBenef.text,
                                          "")
                                  : await context
                                      .read<InsuranceProvider>()
                                      .insure(
                                          widget.typeOfInsurance.text,
                                          widget.insureAmount.text,
                                          widget.insureBeneficiary.text,
                                          widget.amountForBenef.text,
                                          widget.insurePassword.text);

                              if (mounted) {
                                Navigator.of(context).pop();
                                showToast(context, true,
                                    "Successfully sent portfolio transaction");
                                disppose();
                              }
                            } catch (e) {
                              Navigator.of(context).pop();
                              showToast(context, false, e.toString());
                              disppose();
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgress()
                              : const Text(
                                  "Create Portfolio",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = scrollController.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        scrollController.animateTo(offset + 350,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        scrollController.animateTo(offset - 350,
            duration: Duration(milliseconds: 0), curve: Curves.ease);
      });
    }
  }

  void _animateToIndex(int index) {
    scrollController.animateTo(index * 70,
        duration: Duration(seconds: 3), curve: Curves.fastEaseInToSlowEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    //c.Provider.of<MetaMaskProvider>(context).onInit();
    c.Provider.of<InsuranceProvider>(context, listen: false).isInsured();

    return Builder(
      builder: (context) {
        final media = MediaQuery.of(context).size.width;
        return c.Provider.of<InsuranceProvider>(context).getInsurance != null
            ? Scaffold(
                backgroundColor: Colors.black,
                body: SingleChildScrollView(
                  padding:
                      EdgeInsets.only(right: media * .06, left: media * .06),
                  child: Column(
                    children: [
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
                            'Padi - Portfolios Dashboard',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                          ),
                          const SizedBox(width: 656),
                          Text('Welcome,',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(width: 6),
                          c.Consumer<MetaMaskProvider>(
                              builder: (context, provider, child) {
                            return Text(
                                context.read<MetaMaskProvider>().address,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey));
                          }),
                          const SizedBox(width: 39),
                          c.Consumer<MetaMaskProvider>(
                              builder: (context, provider, child) {
                            return ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color?>(
                                      Colors.blue[600],
                                    )),
                                onPressed: () {
                                  context.read<MetaMaskProvider>().disconnect();
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                },
                                child: const Text(
                                  "Disconnect",
                                  style: TextStyle(color: Colors.white),
                                ));
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 33,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 43,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _showCreateDialog(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      child: const Text(
                                        "Create Portfolio",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 43,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/makeClaims');
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      child: const Text(
                                        "Make Claim",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                c.Consumer<InsuranceProvider>(
                                    builder: (context, p, _) {
                                  return p.getInsurance!.length > 9
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.white),
                                              iconColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black26),
                                              shape: MaterialStateProperty.all(
                                                  const CircleBorder(
                                                      eccentricity: 0.7))),
                                          onPressed: () => _animateToIndex(0),
                                          child: const Icon(
                                              Icons.arrow_upward_outlined))
                                      : SizedBox();
                                }),
                                const SizedBox(
                                  height: 12,
                                ),
                                c.Consumer<InsuranceProvider>(
                                    builder: (context, p, _) {
                                  return p.getInsurance!.length > 9
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                              iconColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black26),
                                              shape: MaterialStateProperty.all(
                                                  const CircleBorder(
                                                      eccentricity: 0.7))),
                                          onPressed: () => _animateToIndex(
                                              p.getInsurance!.length),
                                          child: const Icon(
                                              Icons.arrow_downward_outlined))
                                      : SizedBox();
                                }),
                              ],
                            ),
                            const SizedBox(
                              width: 75,
                            ),
                            c.Consumer<InsuranceProvider>(
                                builder: (context, provider, child) {
                              return SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      (MediaQuery.of(context).padding.top +
                                              MediaQuery.of(context)
                                                  .padding
                                                  .bottom) *
                                          .78,
                                  width:
                                      MediaQuery.of(context).size.width * .66,
                                  child: context
                                          .watch<InsuranceProvider>()
                                          .getInsurance!
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            'No Portfolios created yet!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.red),
                                          ),
                                        )
                                      : RawKeyboardListener(
                                          autofocus: true,
                                          focusNode: _focusNode,
                                          onKey: _handleKeyEvent,
                                          child: Scrollbar(
                                            trackVisibility: true,
                                            thumbVisibility: true,
                                            controller: scrollController,
                                            child: ListView.builder(
                                              controller: scrollController,
                                              itemBuilder: ((context, index) {
                                                return PortfolioView(
                                                  index: index,
                                                  keyId: provider
                                                      .getInsurance![index]
                                                      .keyId
                                                      .toString(),
                                                  amountOfInsurance:
                                                      double.parse(provider
                                                          .getInsurance![index]
                                                          .amount
                                                          .toString()),
                                                  id: int.parse(provider
                                                      .getInsurance![index].id),
                                                  beneficiaryAddress: provider
                                                      .getInsurance![index]
                                                      .beneficiary
                                                      .toString(),
                                                  nameOfInsurance: provider
                                                      .getInsurance![index]
                                                      .insuranceName
                                                      .toString(),
                                                );
                                              }),
                                              itemCount:
                                                  provider.getInsurance!.length,
                                              padding: const EdgeInsets.all(10),
                                            ),
                                          ),
                                        ));
                            }),
                            const SizedBox(
                              width: 25,
                            ),
                          ])
                    ],
                  ),
                ),
              )
            : SpinKitThreeBounce(
                color: Colors.blue[900],
              );
      },
    );
  }
}
