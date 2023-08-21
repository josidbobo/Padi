import "package:flutter/material.dart";
import "package:flutter_web3/ethereum.dart";
import "package:flutter_web3/ethers.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "../models/insurance_model.dart";
import "../providers/insurance_provider.dart";
import 'package:provider/provider.dart' as c;

import "../providers/metamask_provider.dart";
import "../widgets/progressIndicator.dart";
import "../widgets/text_field.dart";
import "../widgets/toastBody.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static String compress(String address) {
    String d = address.substring(38);

    String result = '...$d';
    return result;
  }

  static String compressDouble(String bytes) {
    String c = bytes.substring(0, 7);
    String d = bytes.substring(38);

    String result = '$c...$d';
    return result;
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool noUsers = false;
  List<Insurance> foundUsers = [];
  List<Insurance> fullList = [];

  showDialogClaim(int index) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return c.Consumer<InsuranceProvider>(builder: (context, p, _) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: Color.fromARGB(255, 7, 76, 132),
              child: SizedBox(
                height: 200,
                width: 710,
                child: c.Consumer<InsuranceProvider>(
                    builder: (context, provider, child) {
                  return Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Center(child: Text("SET AMOUNT TO CLAIM", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),),),
                        const SizedBox(height: 18,),
                        TextView(
                            text: 'Input amount to claim',
                            controller: amountController),
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
                                      MaterialStateProperty.resolveWith(
                                          (Set<MaterialState> states) {
                                    return states
                                            .contains(MaterialState.disabled)
                                        ? Colors.grey[400]
                                        : Colors.blue[300];
                                  })),
                              onPressed: () async {
                                try {
                                  await context
                                      .read<InsuranceProvider>()
                                      .makeClaim(index.toString(), index,
                                          amountController.text);
                                          if(mounted){
                                             showToast(context, true, "Beneficiary payment transaction sent successfully!");
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
                                  : Text(
                                      "Make Claim",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            );
          });
        });
  }

  void filter(String enteredKeyword) {
    setState(() {
      noUsers = false;
    });
    List<Insurance> results = [];
    if (enteredKeyword.isEmpty) {
      // results = foundUsers; //fullList
    } else {
      results = foundUsers //fullList
          .where((user) =>
              user.keyId.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user.insuranceName
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      if (results.isEmpty) {
        setState(() {
          noUsers = true;
        });
      }
    }
    setState(() {
      fullList = results;
    });
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    c.Provider.of<InsuranceProvider>(context, listen: false).getInsurances();
    c.Provider.of<MetaMaskProvider>(context).connect();
    if (c.Provider.of<InsuranceProvider>(context, listen: false)
            .getPortfolioInsurance !=
        null) {
      foundUsers = c.Provider.of<InsuranceProvider>(context, listen: false)
          .getPortfolioInsurance;
    }
    return c.ChangeNotifierProvider(
        create: (context) => InsuranceProvider(),
        builder: (context, child) {
          return Scaffold(
                  backgroundColor: Colors.black,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 43, right: 43, top: 20),
                      child: Column(
                        children: [
                          Center(child: Text("CLAIM YOUR BENEFITS", style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),),),
                          SizedBox(height: 30,),
                          Container(  
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 62, 80),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: TextField(
                                onChanged: (value) => filter(value),
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    enabled: true,
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 27, 62, 80))),
                                    prefixIcon: const Icon(Icons.search),
                                    prefixIconColor: Colors.white,
                                    suffixIconColor: Colors.white,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          //textEditingController.clear();
                                          //foundUsers = fullList;
                                        });
                                      },
                                    ),
                                    hintText:
                                        'Search with name of portfolio or portfolio code...',
                                    hintStyle:
                                        const TextStyle(color: Colors.blueGrey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: fullList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          height: 60,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Text(
                                              "All portfolios",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          )),
                                      SizedBox(
                                          width: double.infinity,
                                          height: 800,
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: fullList.length,
                                            itemBuilder: (context, index) =>
                                                Card(
                                              color: Colors.black,
                                              key: ValueKey(fullList[index].id),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: ListTile(
                                                title: Text(
                                                    fullList[index]
                                                        .insuranceName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueGrey)),
                                                subtitle: Text(
                                                  "CODE:  ${SearchPage.compressDouble(fullList[index].keyId)}          OWNER:  ${SearchPage.compress(fullList[index].owner)}          BENEFICIARY:  ${SearchPage.compress(fullList[index].beneficiary)}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: ElevatedButton(
                                                    onPressed: () {
                                                      for (int i = 0;
                                                          i < foundUsers.length;
                                                          i++) {
                                                  
                                                        if (fullList[index]
                                                                .keyId ==
                                                            foundUsers[i]
                                                                .keyId) {
                                                          showDialogClaim(
                                                              int.parse(
                                                                  foundUsers[i]
                                                                      .id));
                                                        }
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue),
                                                    child: const Text(
                                                      "Make Claim",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                          )),
                                    ],
                                  )
                                : noUsers
                                    ? const Center(
                                        child: Text(
                                          'No results found',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    : foundUsers.isEmpty ? SpinKitThreeBounce(
                  color: Colors.blue[900],
                ) : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
