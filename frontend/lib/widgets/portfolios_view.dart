import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurance_dapp/widgets/dialog.dart';
import 'package:insurance_dapp/widgets/progressIndicator.dart';
import 'package:insurance_dapp/widgets/text_field.dart';
import 'package:insurance_dapp/widgets/toastBody.dart';
import 'package:provider/provider.dart';
import 'package:insurance_dapp/providers/insurance_provider.dart';

import '../screens/makeClaim.dart';

class PortfolioView extends StatefulWidget {
  final String nameOfInsurance;
  final double amountOfInsurance;
  final String beneficiaryAddress;
  final String keyId;
  final int id;
  final int index;

  const PortfolioView(
      {Key? key,
      required this.keyId,
      required this.index,
      required this.nameOfInsurance,
      required this.amountOfInsurance,
      required this.beneficiaryAddress,
      required this.id})
      : super(key: key);

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  bool isLoading = false;
  bool _copiedToClipboard = false;
  TextEditingController controller = TextEditingController();
  TextEditingController benefController = TextEditingController();

  void showPasswordDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return Consumer<InsuranceProvider>(builder: (context, p, _) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: Color.fromARGB(255, 7, 76, 132),
              child: SizedBox(
                height: 200,
                width: 710,
                child: Consumer<InsuranceProvider>(
                    builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Center(
                        child: Text(
                          "AUTHORISE WITH YOUR PASSCODE",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextView(text: 'Input Password', controller: controller),
                      ListTile(
                        trailing: SizedBox(
                          height: 36,
                          width: 130,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                  Colors.blueGrey[500],
                                )),
                            onPressed: () async {
                              try {
                                await context
                                    .read<InsuranceProvider>()
                                    .authorise(controller.text, widget.id);
                                    if(mounted){
                                        showToast(context, true, "Successfully changed Authorization!");
                                        controller.clear();
                                        Navigator.of(context).pop();
                                    }
                              } catch (e) {
                                controller.clear();
                                Navigator.of(context).pop();
                                showToast(context, false, e.toString());
                              }
                            },
                            child: provider.isLoading
                                ? const CircularProgress()
                                : Text(
                                    context
                                            .watch<InsuranceProvider>()
                                            .getInsurance![widget.index]
                                            .isApproved
                                        ? "DisApprove"
                                        : "Approve",
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => InsuranceProvider(),
        builder: (context, child) {
          return Card(
              margin: const EdgeInsets.only(bottom: 7),
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                color: Colors.black,
                height: 80,
                width: 593,
                child: Row(children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 30,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  clipBehavior: Clip.hardEdge,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.nameOfInsurance,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(widget.amountOfInsurance.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 230,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        showTopUpDialog(mounted,
                                            context, controller, widget.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "Top Up Amount",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        showPasswordDialog();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "Authorize to withdraw",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        showBeneficiaryDialog(
                                          mounted,
                                            context,
                                            benefController,
                                            controller,
                                            widget.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "Change Beneficiary",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        showAmountDialog(mounted, context, benefController, controller, widget.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "Update Benef amount",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              )
                            ]),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Beneficiary: ${SearchPage.compress(widget.beneficiaryAddress)}             Code: ${widget.keyId}',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 40),
                            IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: widget.keyId));
                                  setState(() => _copiedToClipboard = true);
                                  await Future.delayed(
                                      const Duration(seconds: 5),
                                      () => setState(
                                          () => _copiedToClipboard = false));
                                },
                                icon: _copiedToClipboard
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ))
                          ],
                        ),
                      ]),
                ]),
              ),
          );
        });
  }
}
