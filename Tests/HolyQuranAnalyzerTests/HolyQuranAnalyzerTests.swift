//
//  HolyQuranAnalyzerTests.swift
//  HolyQuranAnalyzer
//
//  Created by Yassine Lafryhi on 26/10/2024.
//

import XCTest
@testable import HolyQuranAnalyzer

internal class HolyQuranAnalyzerTests: XCTestCase {
    let quran = HolyQuranAnalyzer.shared

    func test1() {
        let firstSentence = "ثم بعثنا من بعدهم موسى"
        let lastSentence = "أربعين ليلة"

        let ayas = quran.getAyasInSura(.Al_Aaraf, from: firstSentence, to: lastSentence)

        XCTAssertEqual(ayas.count, 40)
    }

    func test2() {
        let word = "العنكبوت"

        let ayas = quran.getAyasFromWordUntilSuraEnd(word: word, inSura: .Al_Ankabut)

        XCTAssertEqual(ayas.count, SuraName.Al_Ankabut.rawValue)
    }

    func test3() {
        let word = "أنعام"

        let number = quran.countWordOccurrencesInSura(word, inSura: .Al_Anaam)

        XCTAssertEqual(number, SuraName.Al_Anaam.rawValue)
    }

    func test4() {
        let firstSentence = "أخاهم هودا"
        let lastSentence = "لعاد قوم هود"

        let ayas = quran.getAyasInSura(.Hud, from: firstSentence, to: lastSentence)

        XCTAssertEqual(ayas.count, SuraName.Hud.rawValue)
    }

    func test5() {
        let word = "عمران"

        let number = quran.countWordOccurrencesInAllQuran(word)

        XCTAssertEqual(number, SuraName.Aali_Imran.rawValue)
    }
}
