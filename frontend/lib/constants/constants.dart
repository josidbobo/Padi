const insuranceAddress = "0x922452768064952Aa0a82d9Dcc2c87cAC89628d4";
//const insuranceAddressConflux = "0x33243E463cd9A0600395b2259030e19680b48442";
//const insuranceAddress2 = '0xB517274C514fb783f5C8Aaac69bAf9433fDb1aC2';
//const insuranceAddress = "0xad78b7b35ea23066449260a86d2b7321fefd337f";

const abii = '''[
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "amountAuthorised",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			}
		],
		"name": "AuthorizedToWithdraw",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_newBeneficiary",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_pass",
				"type": "string"
			}
		],
		"name": "changeBeneficiary",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "__amount",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_pass",
				"type": "string"
			}
		],
		"name": "changeBeneficiaryAmount",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_pass",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "newPass",
				"type": "string"
			}
		],
		"name": "changePassword",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "ClaimMade",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "insuranceDeposit",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_amountDeposited",
				"type": "uint256"
			}
		],
		"name": "InsuranceDeposit",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_amountInsured",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "typeOfInsurance",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			}
		],
		"name": "InsuranceMade",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "typeOfInsurance",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_beneficiary",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_maxAmountForBenef",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_password",
				"type": "string"
			}
		],
		"name": "insure",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_beneficiary",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "makeClaim",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_password",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			}
		],
		"name": "toggleAuthorisation",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "iD",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "topUpPortfolio",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "payee",
				"type": "address"
			}
		],
		"name": "transferBalance",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"stateMutability": "payable",
		"type": "receive"
	},
	{
		"inputs": [],
		"name": "count",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getContractBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "isInsuree",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "locked",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "passwordHash",
		"outputs": [
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "portfolioCountOfEachUser",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "portfolios",
		"outputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "insuranceId",
				"type": "uint256"
			},
			{
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			},
			{
				"internalType": "string",
				"name": "insuranceName",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "userInsuranceCount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amountForBeneficiary",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "isApproved",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "userCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "userInsurances",
		"outputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "insuranceId",
				"type": "uint256"
			},
			{
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			},
			{
				"internalType": "string",
				"name": "insuranceName",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "userInsuranceCount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amountForBeneficiary",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "isApproved",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]''';
