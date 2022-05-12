// To parse this JSON data, do
//
//     final purchaseScanListApiData = purchaseScanListApiDataFromMap(jsonString);

import 'dart:convert';

PurchaseScanListApiData purchaseScanListApiDataFromMap(String str) =>
    PurchaseScanListApiData.fromMap(json.decode(str));

String purchaseScanListApiDataToMap(PurchaseScanListApiData data) =>
    json.encode(data.toMap());

class PurchaseScanListApiData {
  PurchaseScanListApiData({
    required this.code,
    required this.message,
  });

  int code;
  List<PurchaseScanListApiDataMessage>? message;

  factory PurchaseScanListApiData.fromMap(Map<String, dynamic> json) =>
      PurchaseScanListApiData(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == null
            ? []
            : List<PurchaseScanListApiDataMessage>.from(json["message"]
                .map((x) => PurchaseScanListApiDataMessage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class PurchaseScanListApiDataMessage {
  PurchaseScanListApiDataMessage({
    required this.id,
    required this.contactId,
    required this.bankName,
    required this.refNo,
    required this.transactionDate,
    required this.status,
    required this.locationId,
    required this.exchangeRate,
    required this.purchaseItemType,
    required this.totalNet,
    required this.totalReturn,
    required this.totalBeforeTax,
    required this.advanceBalance,
    required this.payment,
    required this.path,
    required this.approvedStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.unpurchases,
    required this.contact,
    required this.bank,
    required this.businesslocation,
  });

  int id;
  int contactId;
  String bankName;
  String refNo;
  String transactionDate;
  String status;
  int locationId;
  String exchangeRate;
  PurchaseItemType? purchaseItemType;
  String totalNet;
  String totalReturn;
  String totalBeforeTax;
  dynamic advanceBalance;
  Payment? payment;
  dynamic path;
  int approvedStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<UnapprovedPurchase>? unpurchases;
  Contact? contact;
  PurchaseScanListApiDataBank? bank;
  Businesslocation? businesslocation;

  factory PurchaseScanListApiDataMessage.fromMap(Map<String, dynamic> json) =>
      PurchaseScanListApiDataMessage(
        id: json["id"] == null ? null : json["id"],
        contactId: json["contact_id"] == null ? null : json["contact_id"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        refNo: json["ref_no"] == null ? '' : json["ref_no"],
        transactionDate:
            json["transaction_date"] == null ? null : json["transaction_date"],
        status: json["status"] == null ? 'null' : json["status"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        exchangeRate:
            json["exchange_rate"] == null ? null : json["exchange_rate"],
        purchaseItemType: json["purchase_item_type"] == null
            ? null
            : purchaseItemTypeValues.map[json["purchase_item_type"]],
        totalNet: json["total_net"] == null ? null : json["total_net"],
        totalReturn: json["total_return"] == null ? null : json["total_return"],
        totalBeforeTax:
            json["total_before_tax"] == null ? null : json["total_before_tax"],
        advanceBalance:
            json["advance_balance"] == null ? '' : json["advance_balance"],
        payment:
            json["payment"] == null ? null : paymentValues.map[json["payment"]],
        path: json["path"] == null ? '' : json["path"],
        approvedStatus:
            json["approved_status"] == null ? null : json["approved_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        unpurchases: json["unpurchases"] == null
            ? null
            : List<UnapprovedPurchase>.from(
                json["unpurchases"].map((x) => UnapprovedPurchase.fromMap(x))),
        contact: json["contact"] == null
            ? Contact(
                id: 0,
                businessId: 0,
                type: Type.BOTH,
                supplierBusinessName: '',
                name: '',
                prefix: '',
                firstName: '',
                middleName: '',
                lastName: '',
                email: '',
                contactId: '',
                contactStatus: ContactStatus.ACTIVE,
                taxNumber: '',
                city: '',
                state: '',
                country: '',
                addressLine1: '',
                addressLine2: '',
                zipCode: '',
                dob: '',
                mobile: '',
                landline: '',
                alternateNumber: '',
                payTermNumber: '',
                payTermType: '',
                creditLimit: '',
                createdBy: 0,
                balance: '',
                totalRp: 0,
                totalRpUsed: 0,
                totalRpExpired: 0,
                isDefault: 0,
                shippingAddress: '',
                position: '',
                customerGroupId: '',
                customField1: '',
                customField2: '',
                customField3: '',
                customField4: '',
                offlineId: '',
                terminalId: '',
                deletedAt: '',
                createdAt: '',
                updatedAt: '',
                contactType: '',
                batchId: '')
            : Contact.fromMap(json["contact"]),
        bank: json["bank"] == null
            ? null
            : PurchaseScanListApiDataBank.fromMap(json["bank"]),
        businesslocation: json["businesslocation"] == null
            ? null
            : Businesslocation.fromMap(json["businesslocation"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "contact_id": contactId == null ? null : contactId,
        "bank_name": bankName == null ? null : bankName,
        "ref_no": refNo == null ? null : refNo,
        "transaction_date": transactionDate == null ? null : transactionDate,
        "status": status == null ? null : statusValues.reverse[status],
        "location_id": locationId == null ? null : locationId,
        "exchange_rate": exchangeRate == null ? null : exchangeRate,
        "purchase_item_type": purchaseItemType == null
            ? null
            : purchaseItemTypeValues.reverse[purchaseItemType],
        "total_net": totalNet == null ? null : totalNet,
        "total_return": totalReturn == null ? null : totalReturn,
        "total_before_tax": totalBeforeTax == null ? null : totalBeforeTax,
        "advance_balance": advanceBalance,
        "payment": payment == null ? null : paymentValues.reverse[payment],
        "path": path,
        "approved_status": approvedStatus == null ? null : approvedStatus,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "unpurchases": unpurchases == null
            ? null
            : List<dynamic>.from(unpurchases!.map((x) => x.toMap())),
        "contact": contact == null ? null : contact!.toMap(),
        "bank": bank == null ? null : bank!.toMap(),
        "businesslocation":
            businesslocation == null ? null : businesslocation!.toMap(),
      };
}

class PurchaseScanListApiDataBank {
  PurchaseScanListApiDataBank({
    required this.id,
    required this.businessId,
    required this.bankName,
    required this.bankAbbrev,
    required this.accountNumber,
    required this.routingNumber,
    required this.signature,
    required this.logo,
    required this.checkNo,
    required this.businessPhone,
    required this.businessCityStateZip,
    required this.businessAddressOnCheck,
    required this.businessNameOnCheck,
    required this.bankAddressLine1,
    required this.bankAddressLine2,
    required this.bankAddressLine3,
    required this.accountZipCode,
    required this.accountState,
    required this.accountCity,
    required this.accountAddress,
    required this.accountName,
    required this.openingBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.locationId,
    required this.bankLocationName,
  });

  int id;
  int businessId;
  String bankName;
  PurchaseScanListApiDataBankAbbrev? bankAbbrev;
  String accountNumber;
  String routingNumber;
  dynamic signature;
  String logo;
  int checkNo;
  String businessPhone;
  BusinessCityStateZip? businessCityStateZip;
  AccountAddress? businessAddressOnCheck;
  BusinessNameOnCheck? businessNameOnCheck;
  PurchaseScanListApiDataBankAddressLine1? bankAddressLine1;
  dynamic bankAddressLine2;
  dynamic bankAddressLine3;
  String accountZipCode;
  AccountState? accountState;
  AccountCity? accountCity;
  AccountAddress? accountAddress;
  AccountName? accountName;
  String openingBalance;
  DateTime? createdAt;
  DateTime? updatedAt;
  String locationId;
  dynamic bankLocationName;

  factory PurchaseScanListApiDataBank.fromMap(Map<String, dynamic> json) =>
      PurchaseScanListApiDataBank(
        id: json["id"] == null ? null : json["id"],
        businessId: json["business_id"] == null ? null : json["business_id"],
        bankName:
            json["bank_name"] == null ? null.toString() : json["bank_name"],
        bankAbbrev: json["bank_abbrev"] == null
            ? null
            : bankAbbrevValues.map[json["bank_abbrev"]],
        accountNumber:
            json["account_number"] == null ? null : json["account_number"],
        routingNumber:
            json["routing_number"] == null ? null : json["routing_number"],
        signature: json["signature"],
        logo: json["logo"] == null ? '' : json["logo"],
        checkNo: json["check_no"] == null ? null : json["check_no"],
        businessPhone:
            json["business_phone"] == null ? null : json["business_phone"],
        businessCityStateZip: json["business_city_state_zip"] == null
            ? null
            : businessCityStateZipValues.map[json["business_city_state_zip"]],
        businessAddressOnCheck: json["business_address_on_check"] == null
            ? null
            : accountAddressValues.map[json["business_address_on_check"]],
        businessNameOnCheck: json["business_name_on_check"] == null
            ? null
            : businessNameOnCheckValues.map[json["business_name_on_check"]],
        bankAddressLine1: json["bank_address_line1"] == null
            ? null
            : bankAddressLine1Values.map[json["bank_address_line1"]],
        bankAddressLine2: json["bank_address_line2"] == null
            ? ''
            : json["bank_address_line2"],
        bankAddressLine3: json["bank_address_line3"] == null
            ? ''
            : json["bank_address_line3"],
        accountZipCode:
            json["account_zip_code"] == null ? '' : json["account_zip_code"],
        accountState: json["account_state"] == null
            ? null
            : accountStateValues.map[json["account_state"]],
        accountCity: json["account_city"] == null
            ? null
            : accountCityValues.map[json["account_city"]],
        accountAddress: json["account_address"] == null
            ? null
            : accountAddressValues.map[json["account_address"]],
        accountName: json["account_name"] == null
            ? null
            : accountNameValues.map[json["account_name"]],
        openingBalance:
            json["opening_balance"] == null ? '' : json["opening_balance"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        locationId: json["location_id"] == null ? null : json["location_id"],
        bankLocationName: json["bank_location_name"] == null
            ? ''
            : json["bank_location_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "bank_name": bankName == null ? null : bankNameValues.reverse[bankName],
        "bank_abbrev":
            bankAbbrev == null ? null : bankAbbrevValues.reverse[bankAbbrev],
        "account_number": accountNumber == null ? null : accountNumber,
        "routing_number": routingNumber == null ? null : routingNumber,
        "signature": signature,
        "logo": logo == null ? null : logo,
        "check_no": checkNo == null ? null : checkNo,
        "business_phone": businessPhone == null ? null : businessPhone,
        "business_city_state_zip": businessCityStateZip == null
            ? null
            : businessCityStateZipValues.reverse[businessCityStateZip],
        "business_address_on_check": businessAddressOnCheck == null
            ? null
            : accountAddressValues.reverse[businessAddressOnCheck],
        "business_name_on_check": businessNameOnCheck == null
            ? null
            : businessNameOnCheckValues.reverse[businessNameOnCheck],
        "bank_address_line1": bankAddressLine1 == null
            ? null
            : bankAddressLine1Values.reverse[bankAddressLine1],
        "bank_address_line2": bankAddressLine2,
        "bank_address_line3": bankAddressLine3,
        "account_zip_code": accountZipCode == null ? null : accountZipCode,
        "account_state": accountState == null
            ? null
            : accountStateValues.reverse[accountState],
        "account_city":
            accountCity == null ? null : accountCityValues.reverse[accountCity],
        "account_address": accountAddress == null
            ? null
            : accountAddressValues.reverse[accountAddress],
        "account_name":
            accountName == null ? null : accountNameValues.reverse[accountName],
        "opening_balance": openingBalance == null ? null : openingBalance,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "location_id": locationId == null ? null : locationId,
        "bank_location_name": bankLocationName,
      };
}

enum AccountAddress { THE_10332_LAURIE_LANE, STREET_NUM_2 }

final accountAddressValues = EnumValues({
  "street num 2": AccountAddress.STREET_NUM_2,
  "10332 Laurie lane": AccountAddress.THE_10332_LAURIE_LANE
});

enum AccountCity { AUSTIN }

final accountCityValues = EnumValues({"AUSTIN": AccountCity.AUSTIN});

enum AccountName { ROSHTECH_SOLUTIONS_LLC, AHSAN }

final accountNameValues = EnumValues({
  "Ahsan": AccountName.AHSAN,
  "ROSHTECH SOLUTIONS LLC": AccountName.ROSHTECH_SOLUTIONS_LLC
});

enum AccountState { TX }

final accountStateValues = EnumValues({"TX": AccountState.TX});

enum PurchaseScanListApiDataBankAbbrev { CHASE, AB1 }

final bankAbbrevValues = EnumValues({
  "ab1": PurchaseScanListApiDataBankAbbrev.AB1,
  "CHASE": PurchaseScanListApiDataBankAbbrev.CHASE
});

enum PurchaseScanListApiDataBankAddressLine1 {
  THE_5401_FARM_TO_MARKET_1626_STE_600_KYLE_TX_78640
}

final bankAddressLine1Values = EnumValues({
  "5401 Farm to Market 1626 Ste 600, Kyle, TX 78640":
      PurchaseScanListApiDataBankAddressLine1
          .THE_5401_FARM_TO_MARKET_1626_STE_600_KYLE_TX_78640
});

enum PurchaseScanListApiDataBankName { CHASE_BANK, FIRST_CENTURY_BANK }

final bankNameValues = EnumValues({
  "CHASE BANK": PurchaseScanListApiDataBankName.CHASE_BANK,
  "First Century PurchaseScanListApiDataBank":
      PurchaseScanListApiDataBankName.FIRST_CENTURY_BANK
});

enum BusinessCityStateZip { AUSTIN_TX_78747, GUJRANWALA }

final businessCityStateZipValues = EnumValues({
  "AUSTIN, TX 78747": BusinessCityStateZip.AUSTIN_TX_78747,
  "gujranwala": BusinessCityStateZip.GUJRANWALA
});

enum BusinessNameOnCheck { ROSHTECH_SOLUTIONS_LLC, NAQSHI }

final businessNameOnCheckValues = EnumValues({
  "naqshi": BusinessNameOnCheck.NAQSHI,
  "ROSHTECH SOLUTIONS LLC": BusinessNameOnCheck.ROSHTECH_SOLUTIONS_LLC
});

class Businesslocation {
  Businesslocation({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.name,
    required this.landmark,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.invoiceSchemeId,
    required this.invoiceLayoutId,
    required this.sellingPriceGroupId,
    required this.printReceiptOnInvoice,
    required this.receiptPrinterType,
    required this.printerId,
    required this.mobile,
    required this.alternateNumber,
    required this.email,
    required this.website,
    required this.featuredProducts,
    required this.isActive,
    required this.defaultPaymentAccounts,
    required this.customField1,
    required this.customField2,
    required this.customField3,
    required this.customField4,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int businessId;
  LocationId? locationId;
  Name? name;
  Landmark? landmark;
  Country? country;
  State? state;
  City? city;
  String zipCode;
  int invoiceSchemeId;
  int invoiceLayoutId;
  dynamic sellingPriceGroupId;
  int printReceiptOnInvoice;
  ReceiptPrinterType? receiptPrinterType;
  dynamic printerId;
  String mobile;
  String alternateNumber;
  String email;
  String website;
  dynamic featuredProducts;
  int isActive;
  String defaultPaymentAccounts;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Businesslocation.fromMap(Map<String, dynamic> json) =>
      Businesslocation(
        id: json["id"] == null ? null : json["id"],
        businessId: json["business_id"] == null ? null : json["business_id"],
        locationId: json["location_id"] == null
            ? null
            : locationIdValues.map[json["location_id"]],
        name: json["name"] == null ? null : nameValues.map[json["name"]],
        landmark: json["landmark"] == null
            ? null
            : landmarkValues.map[json["landmark"]],
        country:
            json["country"] == null ? null : countryValues.map[json["country"]],
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        city: json["city"] == null ? null : cityValues.map[json["city"]],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        invoiceSchemeId: json["invoice_scheme_id"] == null
            ? null
            : json["invoice_scheme_id"],
        invoiceLayoutId: json["invoice_layout_id"] == null
            ? null
            : json["invoice_layout_id"],
        sellingPriceGroupId: json["selling_price_group_id"],
        printReceiptOnInvoice: json["print_receipt_on_invoice"] == null
            ? null
            : json["print_receipt_on_invoice"],
        receiptPrinterType: json["receipt_printer_type"] == null
            ? null
            : receiptPrinterTypeValues.map[json["receipt_printer_type"]],
        printerId: json["printer_id"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        alternateNumber:
            json["alternate_number"] == null ? null : json["alternate_number"],
        email: json["email"] == null ? null : json["email"],
        website: json["website"] == null ? null : json["website"],
        featuredProducts: json["featured_products"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        defaultPaymentAccounts: json["default_payment_accounts"] == null
            ? null
            : json["default_payment_accounts"],
        customField1: json["custom_field1"],
        customField2: json["custom_field2"],
        customField3: json["custom_field3"],
        customField4: json["custom_field4"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "location_id":
            locationId == null ? null : locationIdValues.reverse[locationId],
        "name": name == null ? null : nameValues.reverse[name],
        "landmark": landmark == null ? null : landmarkValues.reverse[landmark],
        "country": country == null ? null : countryValues.reverse[country],
        "state": state == null ? null : stateValues.reverse[state],
        "city": city == null ? null : cityValues.reverse[city],
        "zip_code": zipCode == null ? null : zipCode,
        "invoice_scheme_id": invoiceSchemeId == null ? null : invoiceSchemeId,
        "invoice_layout_id": invoiceLayoutId == null ? null : invoiceLayoutId,
        "selling_price_group_id": sellingPriceGroupId,
        "print_receipt_on_invoice":
            printReceiptOnInvoice == null ? null : printReceiptOnInvoice,
        "receipt_printer_type": receiptPrinterType == null
            ? null
            : receiptPrinterTypeValues.reverse[receiptPrinterType],
        "printer_id": printerId,
        "mobile": mobile == null ? null : mobile,
        "alternate_number": alternateNumber == null ? null : alternateNumber,
        "email": email == null ? null : email,
        "website": website == null ? null : website,
        "featured_products": featuredProducts,
        "is_active": isActive == null ? null : isActive,
        "default_payment_accounts":
            defaultPaymentAccounts == null ? null : defaultPaymentAccounts,
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

enum City { SIALKOT }

final cityValues = EnumValues({"Sialkot": City.SIALKOT});

enum Country { PAKISTAN }

final countryValues = EnumValues({"Pakistan": Country.PAKISTAN});

enum Landmark { HAPU }

final landmarkValues = EnumValues({"Hapu": Landmark.HAPU});

enum LocationId { BL0001 }

final locationIdValues = EnumValues({"BL0001": LocationId.BL0001});

enum Name { BUSINESS }

final nameValues = EnumValues({"business": Name.BUSINESS});

enum ReceiptPrinterType { BROWSER }

final receiptPrinterTypeValues =
    EnumValues({"browser": ReceiptPrinterType.BROWSER});

enum State { PUNJAB }

final stateValues = EnumValues({"Punjab": State.PUNJAB});

class Contact {
  Contact({
    required this.id,
    required this.businessId,
    required this.type,
    required this.supplierBusinessName,
    required this.name,
    required this.prefix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.contactId,
    required this.contactStatus,
    required this.taxNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.addressLine1,
    required this.addressLine2,
    required this.zipCode,
    required this.dob,
    required this.mobile,
    required this.landline,
    required this.alternateNumber,
    required this.payTermNumber,
    required this.payTermType,
    required this.creditLimit,
    required this.createdBy,
    required this.balance,
    required this.totalRp,
    required this.totalRpUsed,
    required this.totalRpExpired,
    required this.isDefault,
    required this.shippingAddress,
    required this.position,
    required this.customerGroupId,
    required this.customField1,
    required this.customField2,
    required this.customField3,
    required this.customField4,
    required this.offlineId,
    required this.terminalId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.contactType,
    required this.batchId,
  });

  int id;
  int businessId;
  Type? type;
  dynamic supplierBusinessName;
  String name;
  dynamic prefix;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic contactId;
  ContactStatus? contactStatus;
  dynamic taxNumber;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic dob;
  dynamic mobile;
  dynamic landline;
  dynamic alternateNumber;
  dynamic payTermNumber;
  dynamic payTermType;
  dynamic creditLimit;
  int createdBy;
  String balance;
  int totalRp;
  int totalRpUsed;
  int totalRpExpired;
  int isDefault;
  dynamic shippingAddress;
  dynamic position;
  dynamic customerGroupId;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic offlineId;
  dynamic terminalId;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic contactType;
  dynamic batchId;

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        id: json["id"] == null ? null : json["id"],
        businessId: json["business_id"] == null ? 0 : json["business_id"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        supplierBusinessName: json["supplier_business_name"] == null
            ? ''
            : typeValues.map[json["supplier_business_name"]],
        name: json["name"] == null ? '' : json["name"],
        prefix: json["prefix"] == null ? '' : typeValues.map[json["prefix"]],
        firstName: json["first_name"] == null
            ? ''
            : typeValues.map[json["first_name"]],
        middleName: json["middle_name"] == null
            ? ''
            : typeValues.map[json["middle_name"]],
        // json["middle_name"],
        lastName:
            json["last_name"] == null ? '' : typeValues.map[json["last_name"]],

        email: json["email"] == null ? '' : typeValues.map[json["email"]],

        contactId: json["contact_id"] == null
            ? ''
            : typeValues.map[json["contact_id"]],

        contactStatus: json["contact_status"] == null
            ? ContactStatus.ACTIVE
            : contactStatusValues.map[json["contact_status"]],
        taxNumber: json["tax_number"] == null
            ? ''
            : contactStatusValues.map[json["tax_number"]],

        city: json["city"] == null ? '' : contactStatusValues.map[json["city"]],

        state:
            json["state"] == null ? '' : contactStatusValues.map[json["state"]],

        country: json["country"] == null
            ? ''
            : contactStatusValues.map[json["country"]],

        addressLine1:
            json["address_line_1"] == null ? '' : json["address_line_1"],
        addressLine2:
            json["address_line_2"] == null ? '' : json["address_line_2"],
        zipCode: json["zip_code"] == null ? '' : json["zip_code"],
        dob: json["dob"] == null ? '' : json["dob"],
        mobile: json["mobile"] == null ? '' : json["mobile"],
        landline: json["landline"] == null ? '' : json["landline"],
        alternateNumber:
            json["alternate_number"] == null ? '' : json["alternate_number"],
        payTermNumber:
            json["pay_term_number"] == null ? '' : json["pay_term_number"],
        payTermType: json["pay_term_type"] == null ? '' : json["pay_term_type"],
        creditLimit: json["credit_limit"] == null ? '' : json["credit_limit"],
        createdBy: json["created_by"] == null ? '' : json["created_by"],
        balance: json["balance"] == null ? '' : json["balance"],
        totalRp: json["total_rp"] == null ? 0 : json["total_rp"],
        totalRpUsed: json["total_rp_used"] == null ? 0 : json["total_rp_used"],
        totalRpExpired:
            json["total_rp_expired"] == null ? 0 : json["total_rp_expired"],
        isDefault: json["is_default"] == null ? 0 : json["is_default"],
        shippingAddress:
            json["shipping_address"] == null ? '' : json["shipping_address"],
        position: json["position"] == null ? '' : json["position"],
        customerGroupId:
            json["customer_group_id"] == null ? '' : json["customer_group_id"],
        customField1:
            json["custom_field1"] == null ? '' : json["custom_field1"],
        customField2:
            json["custom_field2"] == null ? '' : json["custom_field2"],

        customField3:
            json["custom_field3"] == null ? '' : json["custom_field3"],
        customField4:
            json["custom_field4"] == null ? '' : json["custom_field4"],
        offlineId: json["offline_id"] == null ? '' : json["offline_id"],
        terminalId: json["terminal_id"] == null ? '' : json["terminal_id"],

        deletedAt: json["deleted_at"] == null ? '' : json["deleted_at"],

        createdAt: json["created_at"] == null ? '' : json["created_at"],
        updatedAt: json["updated_at"] == null ? '' : json["updated_at"],
        contactType: json["contact_type"] == null ? '' : json["contact_type"],
        batchId: json["batch_id"] == null ? '' : json["batch_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "type": type == null ? null : typeValues.reverse[type],
        "supplier_business_name": supplierBusinessName,
        "name": name == null ? null : name,
        "prefix": prefix,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "contact_id": contactId,
        "contact_status": contactStatus == null
            ? null
            : contactStatusValues.reverse[contactStatus],
        "tax_number": taxNumber,
        "city": city,
        "state": state,
        "country": country,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "zip_code": zipCode,
        "dob": dob,
        "mobile": mobile,
        "landline": landline,
        "alternate_number": alternateNumber,
        "pay_term_number": payTermNumber,
        "pay_term_type": payTermType,
        "credit_limit": creditLimit,
        "created_by": createdBy == null ? null : createdBy,
        "balance": balance == null ? null : balance,
        "total_rp": totalRp == null ? null : totalRp,
        "total_rp_used": totalRpUsed == null ? null : totalRpUsed,
        "total_rp_expired": totalRpExpired == null ? null : totalRpExpired,
        "is_default": isDefault == null ? null : isDefault,
        "shipping_address": shippingAddress,
        "position": position,
        "customer_group_id": customerGroupId,
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "offline_id": offlineId,
        "terminal_id": terminalId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "contact_type": contactType,
        "batch_id": batchId,
      };
}

enum ContactStatus { ACTIVE }

final contactStatusValues = EnumValues({"active": ContactStatus.ACTIVE});

enum Type { BOTH }

final typeValues = EnumValues({"both": Type.BOTH});

enum Payment { AMOUNT_0_METHOD_CASH_NOTE_NULL }

final paymentValues = EnumValues({
  "[{\"amount\":\"0\",\"method\":\"cash\",\"note\":null}]":
      Payment.AMOUNT_0_METHOD_CASH_NOTE_NULL
});

enum PurchaseItemType { PURCHASE, RETURN }

final purchaseItemTypeValues = EnumValues(
    {"purchase": PurchaseItemType.PURCHASE, "return": PurchaseItemType.RETURN});

enum Status { RECEIVED }

final statusValues = EnumValues({"received": Status.RECEIVED});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
// To parse this JSON data, do
//
//     final unapprovedPurchase = unapprovedPurchaseFromMap(jsonString);

class UnapprovedPurchase {
  UnapprovedPurchase({
    required this.id,
    required this.name,
    required this.plu,
    required this.item,
    required this.packageUpc,
    required this.department,
    required this.taxNumber,
    required this.ebt,
    required this.wic,
    required this.qtyOnHand,
    required this.caseSize,
    required this.orderUnit,
    required this.quantity,
    required this.subUnitId,
    required this.orderCase,
    required this.productItemStatus,
    required this.productItemType,
    required this.extCost,
    required this.caseCost,
    required this.caseRetail,
    required this.caseMargin,
    required this.unitCost,
    required this.purchasePrice,
    required this.ppWithoutDiscount,
    required this.discountPercent,
    required this.newRetail,
    required this.currentRetail,
    required this.purchaseLineTaxId,
    required this.itemTax,
    required this.purchasePriceIncTax,
    required this.profitPercent,
    required this.defaultSellPrice,
  });

  int id;
  String name;
  dynamic plu;
  dynamic item;
  dynamic packageUpc;
  String department;
  String taxNumber;
  String ebt;
  String wic;
  String qtyOnHand;
  String caseSize;
  String orderUnit;
  String quantity;
  dynamic subUnitId;
  dynamic orderCase;
  String productItemStatus;
  String productItemType;
  String extCost;
  String caseCost;
  String caseRetail;
  String caseMargin;
  String unitCost;
  String purchasePrice;
  String ppWithoutDiscount;
  String discountPercent;
  String newRetail;
  String currentRetail;
  int purchaseLineTaxId;
  String itemTax;
  String purchasePriceIncTax;
  String profitPercent;
  String defaultSellPrice;

  factory UnapprovedPurchase.fromMap(Map<String, dynamic> json) =>
      UnapprovedPurchase(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        plu: json["plu"] == null ? 'null' : json["plu"],
        item: json["item"] == null ? '0' : json["item"],
        packageUpc: json["package_upc"] == null ? 'null' : json["package_upc"],
        department: json["department"] == null ? 'null' : json["department"],
        taxNumber: json["tax_number"] == null ? 'null' : json["tax_number"],
        ebt: json["ebt"] == null ? "0" : json["ebt"],
        wic: json["wic"] == null ? "0" : json["wic"],
        qtyOnHand: json["qty_on_hand"] == null ? "0" : json["qty_on_hand"],
        caseSize: json["case_size"] == null ? "0" : json["case_size"],
        orderUnit: json["order_unit"] == null ? "0" : json["order_unit"],
        quantity: json["quantity"] == null ? "0" : json["quantity"],
        subUnitId: json["sub_unit_id"] == null ? "null" : json["sub_unit_id"],
        orderCase: json["order_case"] == null ? "0" : json["order_case"],
        productItemStatus: json["product_item_status"] == null
            ? null.toString()
            : json["product_item_status"],
        productItemType:
            json["product_item_type"] == null ? '' : json["product_item_type"],
        extCost: json["ext_cost"] == null ? "0" : json["ext_cost"],
        caseCost: json["case_cost"] == null ? "0" : json["case_cost"],
        caseRetail: json["case_retail"] == null ? "0" : json["case_retail"],
        caseMargin: json["case_margin"] == null ? "0" : json["case_margin"],
        unitCost: json["unit_cost"] == null ? "0" : json["unit_cost"],
        purchasePrice:
            json["purchase_price"] == null ? "0" : json["purchase_price"],
        ppWithoutDiscount: json["pp_without_discount"] == null
            ? "0"
            : json["pp_without_discount"],
        discountPercent:
            json["discount_percent"] == null ? "0" : json["discount_percent"],
        newRetail: json["new_retail"] == null ? "0" : json["new_retail"],
        currentRetail:
            json["current_retail"] == null ? "0" : json["current_retail"],
        purchaseLineTaxId: json["purchase_line_tax_id"] == null
            ? 0
            : json["purchase_line_tax_id"],
        itemTax: json["item_tax"] == null ? "0" : json["item_tax"],
        purchasePriceIncTax: json["purchase_price_inc_tax"] == null
            ? "0"
            : json["purchase_price_inc_tax"],
        profitPercent:
            json["profit_percent"] == null ? "0" : json["profit_percent"],
        defaultSellPrice: json["default_sell_price"] == null
            ? "0"
            : json["default_sell_price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "plu": plu,
        "item": item,
        "package_upc": packageUpc,
        "department": department == null ? null : department,
        "tax_number": taxNumber == null ? null : taxNumber,
        "ebt": ebt == null ? null : ebt,
        "wic": wic == null ? null : wic,
        "qty_on_hand": qtyOnHand == null ? null : qtyOnHand,
        "case_size": caseSize == null ? null : caseSize,
        "order_unit": orderUnit == null ? null : orderUnit,
        "quantity": quantity == null ? null : quantity,
        "sub_unit_id": subUnitId,
        "order_case": orderCase,
        "product_item_status":
            productItemStatus == null ? null : productItemStatus,
        "product_item_type": productItemType == null ? null : productItemType,
        "ext_cost": extCost == null ? null : extCost,
        "case_cost": caseCost == null ? null : caseCost,
        "case_retail": caseRetail == null ? null : caseRetail,
        "case_margin": caseMargin == null ? null : caseMargin,
        "unit_cost": unitCost == null ? null : unitCost,
        "purchase_price": purchasePrice == null ? null : purchasePrice,
        "pp_without_discount":
            ppWithoutDiscount == null ? null : ppWithoutDiscount,
        "discount_percent": discountPercent == null ? null : discountPercent,
        "new_retail": newRetail == null ? null : newRetail,
        "current_retail": currentRetail == null ? null : currentRetail,
        "purchase_line_tax_id":
            purchaseLineTaxId == null ? null : purchaseLineTaxId,
        "item_tax": itemTax == null ? null : itemTax,
        "purchase_price_inc_tax":
            purchasePriceIncTax == null ? null : purchasePriceIncTax,
        "profit_percent": profitPercent == null ? null : profitPercent,
        "default_sell_price":
            defaultSellPrice == null ? null : defaultSellPrice,
      };
}
