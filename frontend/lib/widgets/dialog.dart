import 'package:flutter/material.dart';
import 'package:insurance_dapp/widgets/progressIndicator.dart';
import 'package:insurance_dapp/widgets/text_field.dart';
import 'package:insurance_dapp/widgets/toastBody.dart';
import 'package:provider/provider.dart';

import '../providers/insurance_provider.dart';

void showBeneficiaryDialog(
    bool mounted,
    BuildContext context,
    TextEditingController benefController,
    TextEditingController passController,
    int id) {
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
              height: 250,
              width: 710,
              child: Consumer<InsuranceProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        "UPDATE BENEFICIARY ADDRESS",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextView(
                        text: 'Input new address', controller: benefController),
                    TextView(
                        text: 'Input password', controller: passController),
                    ListTile(
                      trailing: SizedBox(
                        height: 36,
                        width: 160,
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
                                  .changeBeneficiary(benefController.text,
                                      passController.text, id);
                              if (mounted) {
                                showToast(context, true,
                                    "Successfully updated Beneficiary!");
                                benefController.clear();
                                passController.clear();
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              Navigator.of(context).pop();
                              showToast(context, false, e.toString());
                              benefController.clear();
                              passController.clear();
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgress()
                              : const Text(
                                  'Change Beneficiary',
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

void showTopUpDialog(
    bool mounted, BuildContext context, TextEditingController amountController, int id) {
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
              height: 250,
              width: 710,
              child: Consumer<InsuranceProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        "INCREASE INSURED AMOUNT",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextView(
                        text: 'Input amount to top up',
                        controller: amountController),
                    ListTile(
                      trailing: SizedBox(
                        height: 36,
                        width: 160,
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
                                  .topUp(id, amountController.text);
                                  if(mounted){
                                    showToast(context, true,
                                  "Successfully sent Transaction!");
                                  amountController.clear();
                                  Navigator.of(context).pop();
                                  }
                            } catch (e) {
                              Navigator.of(context).pop();
                              showToast(context, false, e.toString());
                              amountController.clear();
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgress()
                              : const Text(
                                  'Top Up',
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

void showAmountDialog(
    bool mounted,
    BuildContext context,
    TextEditingController benefController,
    TextEditingController passController,
    int id) {
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
              height: 250,
              width: 710,
              child: Consumer<InsuranceProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        "UPDATE ALLOWED AMOUNT FOR BENEFICIARY",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextView(
                        text: 'Input new amount', controller: benefController),
                    TextView(
                        text: 'Input password', controller: passController),
                    ListTile(
                      trailing: SizedBox(
                        height: 36,
                        width: 160,
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
                                  .changeBeneficiaryAmount(benefController.text,
                                      passController.text, id);
                              if (mounted) {
                                showToast(context, true,
                                    "Successfully updated Beneficiary Amount!");
                                benefController.clear();
                                passController.clear();
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              Navigator.of(context).pop();
                              showToast(context, false, e.toString());
                              benefController.clear();
                              passController.clear();
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgress()
                              : const Text(
                                  'Update Amount',
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
