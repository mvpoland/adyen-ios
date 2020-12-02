//
// Copyright (c) 2018 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

@testable import Adyen
@testable import AdyenInternal
import XCTest

class PaymentSessionTests: XCTestCase {
    func testDecodingFromJSON() throws {
        let paymentSession = try Coder.decode(resourceNamed: "payment_session") as PaymentSession
        XCTAssertEqual(paymentSession.payment.amount.value, 17408)
        XCTAssertEqual(paymentSession.payment.amount.currencyCode, "EUR")
        XCTAssertEqual(paymentSession.payment.merchantReference, "Your order number")
        XCTAssertEqual(paymentSession.payment.countryCode, "NL")
        XCTAssertEqual(paymentSession.payment.shopperReference, "ashopper")
        XCTAssertEqual(paymentSession.payment.shopperLocaleIdentifier, "nl_NL")
        XCTAssertEqual(paymentSession.payment.expirationDate.timeIntervalSince1970, 1513618413.0)
        XCTAssertEqual(paymentSession.paymentMethods.other.count, 11)
        XCTAssertEqual(paymentSession.initiationURL.absoluteString, "http://192.168.19.140:8080/checkoutshopper/services/PaymentInitiation/v1/initiate")
        XCTAssertEqual(paymentSession.deleteStoredPaymentMethodURL.absoluteString, "http://192.168.19.140:8080/checkoutshopper/services/PaymentInitiation/v1/disableRecurringDetail")
        XCTAssertEqual(paymentSession.publicKey, "10001|D91F49C46C7B2455EA0D62DBEB1334A2486AB68526CC894CCE1078499838A691A7783F32C3579E2E85D6F678304AF335AB200B443BF92CC3D9D961AB32A09BE29906FEC538AC621F99902B57EA68F64BF7D391ACC8D5804CD6505F8FE4C854D207286680233747C4249CD772FCA056C6CDDB22408B09E552FB0C7839F94C4C86C0E5B8E6605C2508999D9B4A11B8C7F819D6E96363A19995FC6A6EF188EFF31AA2BE722C1D4FBC93700F83974C1D3D925A1403B42562F4A190B04F23314EDDBD0782FDABED06F621391C6987BF18C510B186F9FDC195A0EA4646C01FF416EC2CC0B445D26C5ADC6D1A2AC9D1B900493A5AEB768AA838D1B62E99C2AB00D445C5")
        XCTAssertEqual(paymentSession.generationDate?.timeIntervalSince1970, 1513614813.0)
        XCTAssertEqual(paymentSession.paymentData, "Hee57361f99ddcf4!ZW5jcnlwdGVkPUJRQUJBZ0F4eDhONGtVV25oMW5jWVhNZHN4VVg1dDFJNHgxNXFKdlR5NnlKdEQzT0YlMkZTWiUyQmV5YkwyVWJ1SFR3cldROW0xcFpmdnAlMkZ3Qm9HUG4zd011YUI0RHdBWENKTU9HdzROSVYyakJ6bWc0THFwSCUyRkJXd1ElMkJGWDVvcmF2elJMc092czVzUGtjZk1sM2kyWEIlMkJ3aHlMbGQxMWdYM3BNcGl1TCUyQkdlV21zOWFWS3VObmxQd1l1aiUyRm9vOTJGWmJyREtkbk5tOVpmZ2M4cCUyRlB6bzJQR3hzSmpWYmg2ZDIxemJFdzlQJTJCV3ZOVjJTMU5oRlJOUmdxOEhST0ElMkYwMlgySWJKQVhhZE5hTWlvazdhUFFJN3hSa1pqQndIZkpQTWlUdXVaeXduZEV2VEVweUZBdWhrNU9NZUNiVjJpQXZ0UWdOTzZoWlRaeFlLJTJGVEhKUFFnJTJGMjV1aW03cVFaTHFMOTBubDRPd01CRE1ucG1RTUFBdWU0Q3ZrQUZzJTJGUHg2cmhtWEJLTVczMW1LR0pDNzRCV2pwU3E2dG04V3IlMkZUajQ4VnM2QW8lMkZiY1VtZlZXRG8wRk14c3N5YllvJTJGTEkyMmczTVFuaVZ0ZWFwVjAyNVlMdHZkdkVqYW01UUxpbVBhME5nT1BKTktMejRLRFhzeiUyRjE2bXR5eFpzc0FidWRIRnduSTMyMTJXMmR3VWp5aGZGalNqSGtiQ1RIcFZGZ1JZSGIza1BuaTlNaDIybjdZcExsN0YxWktKaGhtZFJrTVVydVdZMU5HR3pvVVBQZlhmNkRXbGpQWnNPVGhwQThmNGxCOUNRMGgwQUNZT21yTjJqSzJWQmg4NngwN1NaS2YxRXphMVBLdlJ3TEF4JTJCaWlmSkx3T1VzcW9FMGxrc1YxeVF0c1czM1d0JTJGRlAwOCUyQkgzQmxRUkJhdnlzSUdmYVJWUnpyNmNMYlBzMVhBRXA3SW10bGVTSTZJa0ZHTUVGQlFURXdNME5CTlRNM1JVRkZSRGczUXpJMFJFUTFNemt3T1VJNE1FRTNPRUU1TWpORk16Z3lNMFEyT0VSQlEwTTVORUk1UmtZNE16QTFSRU1pZlVnU0s0JTJGRlJ6aFpkMyUyQnlIWHpadk04M2F4T0FqeURjNXdiaHgzZTFVU3gyN1U0aHhXVkRQWGpxWDFjaHBtYzZHVEZiZ3NGQWNrclllZmpJNFRHSVQlMkY3RSUyRmwxc2thUzJpemlNRjd5aGtKYVpkMW05alVHSTRNN1IzZyUyQmgxa1RTM1J5TER3OUJEcE54eVhWNklXQ0VPQ2JTbXFEZ2kzczRuOUs1WDdhVDFaVW5LMEpvMERMajlQbGJ0a2dkRGglMkIwYSUyRlcxa1FrVGFUSWpTUFljeFJLSmlud3VDamJ6diUyRkhubk15N3l2YWcwSlZUNkEzeVA4MVM2YzdFbmZ4RlhQenglMkZrTmI1bWl1WGEyTGhSVXhvJTJCVjdLaU1Ld3hLNU01U2JuRzhEOGF1UmJLQWVNJTJGaEdkWkkzdnNkRnJFNyUyQnhTa0s0RSUyRjZKOTFMMEg3dVNFaVhjaFlYb2g4OWxUZjVJSW1ERVl1cW1YTHhRVUY5OUZCS1p1VkNLdG16Y3M1Nkd4MjMlMkJGZmlsOHphdE1rc1BTWXE2QVkyNENMSjdZZklBVVhJczNFdkJjVGR5bGtPckRIQzdCcDJVeThMOGRlRDJiVDFRZ2NSY3AlMkJ1OG5CdmRvUUM1dURJZ0tyZ3Q0cFpQWnRVSTd3cVlnQk5INW9QeHlYdmlKY2tCaGZsbSUyQnQ2RXkyT3lad1BkY1hicTZ4N2JjYnY0bCUyQjFQQVhNVEJVVmo4Z25DVTZJZHhBOFV3ajliRklrSWlDdUJRWmtNZWlEVmFzZ3gxeUVXRkhaeGo5VVMlMkYwZmdDVkJKcjclMkJNaWw0d1h3QnJCTVYyOVcyaU9jdFk4MFpnTHZQaFpQYVpxelRJZUtMNFA3T01BUjAyJTJCMXZVUURlM2ZydHVHWWdvbTZhaWtSdnhlSGl6aWNjTTNWOUI2TlU2Z3pGQkFIRnFUJTJGSGV2cEZHOXlJZlllSVJFdnFKTjdTdUJrYkJMenZXc2hNU3VJVXN5TlRLeVRVcTRkRmVsVElpaW9tWWtTMkglMkY4bzFYRnNLVFlkbjNvMDc0SUxVJTJCM01IODdTYSUyQmIlMkZ0cFZGTmNVZUVQWXRHQlBaaWdCanElMkJoMVA1VUFpMTFVM1ljS3U0aEowRlVpdmpGb0NzOHQ2SXpFRTZwdW1rMFVFJTJGekhOSE80ZDZOUyUyRlNPWXhHZ2lGUzduSGJjUEM2NnVYZUhQSGtJQ0JQU2s3OE5rbTJqOE5adnJsT25qRDh5NTdic3dSWWNLS3BZU0xlSUc4eHlTV2h3N3pVaGhhbTRxbkp2R1h0ZkFmQ2hkaXd4TCUyQjk0TnowMzdTdjlzRVl2JTJCVXlFYTczMHJXR2xST2xORzR2aGo3TGZkM2gzSDdST3JYJTJGbm5valN0MVolMkJHRGNUYjNRQThhOXA4OHZER0xrano5UmQxRiUyQiUyQnBSZkFTZXVMUWZqakdUUlpBQSUyQnlwTVI2OGt6MCUyQkNORDcwJTJCNmJJMTJ1SEFjQjJuWjA1ek9JY0MwaWczWmxpMDZiUGlOUllZT09KNDZGdTZneU5jcUxsTHE2c0FTWUNNZVNlZkZWSXhXejhtVHVvTG9NNWQyeHJKazh0bjhwNWVwN3pHdWpCcEQ4NDA5eWFXenBsNW44MzdxeTZDUEhnUnQ5N1dwWUV5ZXgxakVGMlJXZ25uZG5rSWxKRTliWkJZNkVkeERmR2F6YnpjWUNOZUdNNzc0QVQzU2Vzc3NnMFREMUFybCUyRkM2ME5wMjNPemdaM05HM0glMkY1QzRjNTZnZTh5MlkxWklDTXIwdmZ2NVZ3TlVkczF1ZUJWbmhDZnQyRXQyZ0prbSUyQklIUmRpb2R5N3F0aDBlNUhUNGgyMTQlMkIlMkZIUk0wdjFEekdVJTJCbmd6WUJwcEdmRDl6N3lzNEpOTU1CcTl3Zk9TaDBuaUZFcUpCdWdPTlVQcU83JTJCWHg1aVhtNENCZzNZQ1QlMkZSZlNuJTJGSW1EMWRwZHMzdEpkaGlpUHFiSUY1MUFnTWVBekFtMEoybVZ3Vm80QUZxeFBvYThZJTJGTlNrMUE0cyUyRnBNazhVNlhXOEV5UE52ZUEyS1lRREVZTThQMzF4NmVDYlB6WVM5T3Z0T1dsRXdtb3lTYlRGYWVvdlpGcmRlVUxCblJtYUlYazhtc0VpU3hzR1F2dTJXZ3BGSXRXdiUyRmc3NmxHa29MJTJCZERLZUdhJTJCUWRHbHBmMmo0Y01JeGxkaTVDbEJhcXBkTHV5YTVXVnJOUCUyRm9qOE84MGxlT1RNcGFUUUV3d0dSbXg0MzR1MmUwZlJMTzdkcHFqeFZUbXhjT3JUTTN6WnBGSkI4QjRqVnZ2RmtpbUlTaSUyRlJwN2lLWjFvOGFSSHIyYW4wYmJ5cUZOS0g5bVZDbWFxc0dRJTJCQVZLUUxORXRFRE5TaU16cWEzVkhLdGNRYU5CdDBleGw1V3dCb3BpdXYlMkZ6S1gwSFdYNmMwNWVpakpIOU5relp1b0s2MUJXb2tzUU82blhNeEglMkIzcmdvRllGR0F2VWc4TzhFU0I0QXNJTEg2cmRSSzFXTUlHVEczTiUyRjJ6RkNzVFoycHM1dmpkaWZ6b2xqN2o3ZHBhNjJ4ZjFJNjN1ZUwwZWtqcGo5MERVMnREazBOWmxmOGJMeXdtVzZYZzRpV0MlMkJTSm5pM240Mmc0SUVJQXAyVTV2JTJGJTJGVldxRndDc1hpRWRhcVhnanVJY0VlTjVneE9oV1NQWm5UaWk4U0lQU3pGd3ZOSXloQlZNY0JETkhHSEFEWFJXRDdyTTJlRDdRSXpLMjd2ejRxSjRjVWg1c0RsdmNHSW9ESk9KdXU1dW5abWpEUzZvRDVYc1klM0QmdmVyc2lvbj0y")
        
        // Test grouping.
        let cardPaymentMethod = paymentSession.paymentMethods.other[0]
        XCTAssertEqual(cardPaymentMethod.type, "card")
        XCTAssertEqual(cardPaymentMethod.details.count, 2)
        XCTAssertEqual(cardPaymentMethod.children.count, 5)
        XCTAssertNil(cardPaymentMethod.group)
    }
    
}
