//
//  HolyQuranAnalyzer.swift
//  HolyQuranAnalyzer
//
//  Created by Yassine Lafryhi on 26/10/2024.
//

import Foundation

public struct ObjectId: Codable {
    let oid: String

    enum CodingKeys: String, CodingKey {
        case oid = "$oid"
    }
}

public struct Aya: Codable {
    let id: ObjectId
    public var ayaContent: String
    public let ayaNumber: Int
    public let suraName: String
    public let suraNumber: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case ayaContent = "AyaContent"
        case ayaNumber = "AyaNumber"
        case suraName = "SurahName"
        case suraNumber = "SurahNumber"
    }
}

public class HolyQuranAnalyzer {
    public static let shared = HolyQuranAnalyzer()

    private var ayas: [Aya]?

    private init() {
        ayas = loadAyas()
    }

    private func loadAyas() -> [Aya]? {
        let data = Data(HolyQuranData.holyQuranData.utf8)
        do {
            let decoder = JSONDecoder()
            let ayas = try decoder.decode([Aya].self, from: data)
            return ayas
        } catch {
            print("Error reading or decoding JSON: \(error)")
            return nil
        }
    }

    public func countAllCharactersInSura(suraNumber: Int, withBasmala: Bool = false) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let characterCount = sortedAyas.reduce(0) { count, aya in
            var ayaContent = aya.ayaContent
            if !withBasmala {
                ayaContent = ayaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")
            }
            let filteredCharacters = ayaContent.filter { Constants.arabicLetters.contains(String($0)) }

            return count + filteredCharacters.count
        }

        return characterCount
    }

    public func countSuraCharactersInRange(suraNumber: Int, fromAya: Int, toAya: Int) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let startIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == fromAya })
        let endIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == toAya })

        guard let start = startIndex, let end = endIndex, start <= end else {
            print("Invalid Aya range.")
            return 0
        }

        let range = start ... end
        let characterCount = sortedAyas[range].reduce(0) { count, aya in
            let filteredCharacters = aya.ayaContent.filter { Constants.arabicLetters.contains(String($0)) }
            return count + filteredCharacters.count
        }

        return characterCount
    }

    public func countAllWordsInSura(suraNumber: Int) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let wordCount = sortedAyas.reduce(0) { count, aya in
            let ayaContent = aya.ayaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")

            var words = ayaContent.split { $0.isWhitespace }.map(String.init)
            words = words.filter { $0 != "۞" }
            return count + words.count
        }

        return wordCount
    }

    public func countSuraWordsInRange(suraNumber: Int, fromAya: Int, toAya: Int) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let startIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == fromAya })
        let endIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == toAya })

        guard let start = startIndex, let end = endIndex, start <= end else {
            print("Invalid Aya range.")
            return 0
        }

        let range = start ... end
        let wordCount = sortedAyas[range].reduce(0) { count, aya in

            var words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
            words = words.filter { $0 != "۞" }
            return count + words.count
        }

        return wordCount
    }

    public func countSuraWordOccurrencesInRange(suraNumber: Int, fromAya: Int, toAya: Int, word: String) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let startIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == fromAya })
        let endIndex = sortedAyas.firstIndex(where: { Int($0.ayaNumber) == toAya })

        guard let start = startIndex, let end = endIndex, start <= end else {
            print("Invalid Aya range.")
            return 0
        }

        let range = start ... end
        let occurrenceCount = sortedAyas[range].reduce(0) { count, aya in

            let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
            return count + words.filter { $0 == word }.count
        }

        return occurrenceCount
    }

    public func countWordOccurrencesInFullSura(suraNumber: Int, word: String) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        let occurrenceCount = filteredAyas.reduce(0) { count, aya in

            let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
            return count + words.filter { $0 == word }.count
        }
        return occurrenceCount
    }

    public func countWordOccurrencesInSura(_ word: String, inSura: SuraName) -> Int {
        let suraNumber = inSura.rawValue
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        var occurrenceCount = 0
        for aya in filteredAyas {
            let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
            for one in words {
                if one.contains(word) {
                    occurrenceCount += 1
                }
            }
        }

        /* let occurrenceCount = filteredAyas.reduce(0) { count, aya in

         let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
         return count + words.filter { $0.contains(word) }.count
         } */
        return occurrenceCount
    }

    public func getAyasInSura(_ suraNumber: SuraName, from: String, to: String) -> [Aya] {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber.rawValue }
        var theAyas = [Aya]()
        var found = false
        for aya in filteredAyas {
            let content = aya.ayaContent.replace("ىٰ", "ى")
            if content.contains(from) {
                found = true
            }
            if found {
                theAyas.append(aya)
            }
            if content.contains(to) {
                break
            }
        }

        return theAyas
    }

    public func countWordOccurrencesInAllQuran(_ word: String) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        var occurrenceCount = 0
        for aya in ayas {
            let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
            for one in words {
                if one.contains(word) {
                    occurrenceCount += 1
                }
            }
        }

        /* let occurrenceCount = ayas.reduce(0) { count, aya in

         let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
         return count + words.filter { $0.contains(word) }.count
         } */
        return occurrenceCount
    }

    public func countSentenceOccurrencesInAllQuran(of sentence: String) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        var occurrenceCount = 0
        for aya in ayas {
            if aya.ayaContent.contains(sentence) {
                occurrenceCount += 1
            }
        }

        /* let occurrenceCount = ayas.reduce(0) { count, aya in

         let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
         return count + words.filter { $0.contains(word) }.count
         } */
        return occurrenceCount
    }

    public func getAyasThatContain(_ sentence: String) -> [Aya] {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        var theAyas = [Aya]()
        for aya in ayas {
            if aya.ayaContent.contains(sentence) {
                theAyas.append(considerWawAsWord(in: aya))
            }
        }

        return theAyas
    }

    public func getAyasThatStartWith(_ sentence: String) -> [Aya] {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        var theAyas = [Aya]()
        for aya in ayas {
            if aya.ayaContent.hasPrefix(sentence) {
                theAyas.append(aya)
            }
        }

        return theAyas
    }

    public func getSurasThatStartWith(_ sentence: String) -> [Aya] {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        var theAyas = [Aya]()
        for aya in ayas {
            if
                aya.ayaContent.starts(with: "بسم الله الرحمٰن الرحيم"),
                aya.ayaContent.replace("بسم الله الرحمٰن الرحيم", "").trimmingCharacters(in: .whitespacesAndNewlines)
                    .starts(with: sentence)
            {
                theAyas.append(aya)
                /* if let nextAya = getAyaAfter(aya: aya) {
                     if nextAya.ayaContent.hasPrefix(sentence) {
                         theAyas.append(aya)
                     }
                 } */
            }
        }

        return theAyas
    }

    private func considerWawAsWord(in aya: Aya) -> Aya {
        var aya = aya
        var content = aya.ayaContent

        content = content.replacingOccurrences(of: "وال", with: "و ال")
        content = content.replacingOccurrences(of: "وإذ", with: "و إذ")

        aya.ayaContent = content
        return aya
    }

    public func countCharactersInAya(aya: Aya) -> Int {
        let filteredCharacters = aya.ayaContent.filter { Constants.arabicLetters.contains(String($0)) }
        return filteredCharacters.count
    }

    public func countSpecificArabicLetterInSura(_ suraName: SuraName, letter: String) -> Int {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return 0
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraName.rawValue }
        let sortedAyas = filteredAyas.sorted { Int($0.ayaNumber) < Int($1.ayaNumber) }

        let letterCount = sortedAyas.reduce(0) { count, aya in
            let filteredCharacters = aya.ayaContent.filter { String($0) == letter }
            return count + filteredCharacters.count
        }

        return letterCount
    }

    public func getWordOrderInAya(word: String, aya: Aya) -> Int {
        let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
        if let index = words.firstIndex(of: word) {
            return index + 1
        }
        return 0
    }

    public func getAyaBefore(aya: Aya) -> Aya? {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return nil
        }

        let ayaIndex = ayas.firstIndex(where: { $0.ayaNumber == aya.ayaNumber && $0.suraNumber == aya.suraNumber })
        guard let index = ayaIndex, index > 0 else {
            return nil
        }

        return ayas[index - 1]
    }

    public func getAyaAfter(aya: Aya) -> Aya? {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return nil
        }

        let ayaIndex = ayas.firstIndex(where: { $0.ayaNumber == aya.ayaNumber && $0.suraNumber == aya.suraNumber })
        guard let index = ayaIndex, index < ayas.count - 1 else {
            return nil
        }

        return ayas[index + 1]
    }

    public func countWordsInAya(aya: Aya) -> Int {
        let words = aya.ayaContent.split { $0.isWhitespace }.map(String.init)
        return words.count
    }

    public func countWordsInAyas(ayas: [Aya]) -> Int {
        var wordsNumber = 0
        for aya in ayas {
            wordsNumber += countWordsInAya(aya: aya)
        }
        return wordsNumber
    }

    public func getAllAyasOfSura(_ suraNumber: SuraName) -> [Aya] {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber.rawValue }
        return filteredAyas
    }

    public func getLongestAyaInFullQuran() -> Aya {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return Aya(id: ObjectId(oid: ""), ayaContent: "", ayaNumber: 0, suraName: "", suraNumber: 0)
        }

        let longestAya = ayas.max { a, b in
            a.ayaContent.count < b.ayaContent.count
        }

        return longestAya!
    }

    public func getShortestAyaInFullQuran() -> Aya {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return Aya(id: ObjectId(oid: ""), ayaContent: "", ayaNumber: 0, suraName: "", suraNumber: 0)
        }

        let shortestAya = ayas.min { a, b in
            a.ayaContent.count < b.ayaContent.count
        }

        return shortestAya!
    }

    public func getLongestAyaInSura(_ suraNumber: SuraName, withBasmala: Bool = false) -> Aya {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return Aya(id: ObjectId(oid: ""), ayaContent: "", ayaNumber: 0, suraName: "", suraNumber: 0)
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber.rawValue }
        let longestAya = filteredAyas.max { a, b in
            var firstAyaContent = a.ayaContent
            var secondAyaContent = b.ayaContent
            if !withBasmala {
                firstAyaContent = firstAyaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")
                secondAyaContent = secondAyaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")
            }
            return firstAyaContent.count < secondAyaContent.count
        }

        return longestAya!
    }

    public func getShortestAyaInSura(_ suraNumber: SuraName, withBasmala: Bool = false) -> Aya {
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return Aya(id: ObjectId(oid: ""), ayaContent: "", ayaNumber: 0, suraName: "", suraNumber: 0)
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber.rawValue }
        let shortestAya = filteredAyas.min { a, b in
            var firstAyaContent = a.ayaContent
            var secondAyaContent = b.ayaContent
            if !withBasmala {
                firstAyaContent = firstAyaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")
                secondAyaContent = secondAyaContent.replacingOccurrences(of: "بسم الله الرحمٰن الرحيم", with: "")
            }
            return firstAyaContent.count < secondAyaContent.count
        }

        return shortestAya!
    }

    public func getAyasFromSuraBeginningUntilWord(fromBeginningOfSura: SuraName, word: String) -> [Aya] {
        let suraNumber = fromBeginningOfSura.rawValue
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        var theAyas = [Aya]()
        var found = false
        for aya in filteredAyas {
            if aya.ayaContent.contains(word) {
                found = true
            }
            if !found {
                theAyas.append(aya)
            }
        }

        return theAyas
    }

    public func getAyasFromWordUntilSuraEnd(word: String, inSura: SuraName) -> [Aya] {
        let suraNumber = inSura.rawValue
        guard let ayas = ayas else {
            print("Ayas data not loaded.")
            return []
        }

        let filteredAyas = ayas.filter { Int($0.suraNumber) == suraNumber }
        var theAyas = [Aya]()
        var found = false
        for aya in filteredAyas {
            if aya.ayaContent.contains(word) {
                found = true
            }
            if found {
                theAyas.append(aya)
            }
        }

        return theAyas
    }
}

extension String {
    func replace(_ target: String, _ replacement: String) -> String {
        replacingOccurrences(of: target, with: replacement)
    }
}
