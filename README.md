# HolyQuranAnalyzer

> An interactive Swift package for analyzing the Holy Quran through REPL

![](https://img.shields.io/badge/version-0.9.0-orange)

## Usage

To use the package, you need to have Swift installed on your machine. Then clone the repository and run the `start.sh` script :
```shell
git clone https://github.com/YassineLafryhi/HolyQuranAnalyzer.git
cd HolyQuranAnalyzer
chmod +x start.sh
./start.sh
```

Then:

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let firstSentence = "ثم بعثنا من بعدهم موسى"
let lastSentence = "أربعين ليلة"
let ayas = quran.getAyasInSura(.Al_Aaraf, from: firstSentence, to: lastSentence)
print(ayas.count) // 40
:quit
```

## Digital Facts (Also in the `HolyQuranAnalyzerTests.swift` file)

### 1. Reference: [https://www.kaheel7.com](https://www.kaheel7.com/ar/index.php/1/2096-2020-04-26-03-04-19)

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let firstSentence = "ثم بعثنا من بعدهم موسى"
let lastSentence = "أربعين ليلة"
let ayas = quran.getAyasInSura(.Al_Aaraf, from: firstSentence, to: lastSentence)
print(ayas.count) // 40
```

### 2. Reference: [https://www.kaheel7.com](https://www.kaheel7.com/ar/index.php/1/2096-2020-04-26-03-04-19)

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let word = "العنكبوت"
let ayas = quran.getAyasFromWordUntilSuraEnd(word: word, inSura: .Al_Ankabut)
print(ayas.count) // 29
print(SuraName.Al_Ankabut.rawValue) // 29
```

### 3. Reference: [https://www.kaheel7.com](https://www.kaheel7.com/ar/index.php/1/2096-2020-04-26-03-04-19)

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let word = "أنعام"
let number = quran.countWordOccurrencesInSura(word, inSura: .Al_Anaam)
print(number) // 6
print(SuraName.Al_Anaam.rawValue) // 6
```

### 4. Reference: [https://www.kaheel7.com](https://www.kaheel7.com/ar/index.php/1/2096-2020-04-26-03-04-19)

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let firstSentence = "أخاهم هودا"
let lastSentence = "لعاد قوم هود"
let ayas = quran.getAyasInSura(.Hud, from: firstSentence, to: lastSentence)
print(ayas.count) // 11
print(SuraName.Hud.rawValue) // 11
```

### 5. Reference: [https://www.kaheel7.com](https://www.kaheel7.com/ar/index.php/1/2096-2020-04-26-03-04-19)

```swift
import HolyQuranAnalyzer
let quran = HolyQuranAnalyzer.shared
let word = "عمران"
let number = quran.countWordOccurrencesInAllQuran(word)
print(number) // 3
print(SuraName.Aali_Imran.rawValue) // 3
```

## Functions
| Function                                                                                          | Description                                                                              |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| `countAllCharactersInSura(suraNumber: Int, withBasmala: Bool = false) -> Int`                     | Count all characters in a sura (chapter) of the Holy Quran, with or without the Basmala. |
| `countSuraCharactersInRange(suraNumber: Int, fromAya: Int, toAya: Int) -> Int`                    | Count the characters in a specified range of ayas (verses) within a sura.                |
| `countAllWordsInSura(suraNumber: Int) -> Int`                                                     | Count all words in a specific sura (chapter) of the Quran.                               |
| `countSuraWordsInRange(suraNumber: Int, fromAya: Int, toAya: Int) -> Int`                         | Count the words in a specified range of ayas (verses) within a sura.                     |
| `countSuraWordOccurrencesInRange(suraNumber: Int, fromAya: Int, toAya: Int, word: String) -> Int` | Count occurrences of a specific word within a range of ayas in a sura.                   |
| `countWordOccurrencesInFullSura(suraNumber: Int, word: String) -> Int`                            | Count occurrences of a specific word throughout a sura.                                  |
| `countWordOccurrencesInSura(_ word: String, inSura: SuraName) -> Int`                             | Count occurrences of a word within a specific sura, identified by its name.              |
| `getAyasInSura(_ suraNumber: SuraName, from: String, to: String) -> [Aya]`                        | Retrieve ayas (verses) from a specified start to end range within a sura.                |
| `countWordOccurrencesInAllQuran(_ word: String) -> Int`                                           | Count the total occurrences of a word across the entire Quran.                           |
| `countSentenceOccurrencesInAllQuran(of sentence: String) -> Int`                                  | Count occurrences of a full sentence across all ayas in the Quran.                       |
| `getAyasThatContain(_ sentence: String) -> [Aya]`                                                 | Retrieve all ayas that contain a specific sentence.                                      |
| `getAyasThatStartWith(_ sentence: String) -> [Aya]`                                               | Retrieve all ayas that begin with a specified sentence.                                  |
| `getSurasThatStartWith(_ sentence: String) -> [Aya]`                                              | Retrieve suras that start with a specific sentence.                                      |
| `countCharactersInAya(aya: Aya) -> Int`                                                           | Count the number of characters in a single aya.                                          |
| `countSpecificArabicLetterInSura(_ suraName: SuraName, letter: String) -> Int`                    | Count occurrences of a specified Arabic letter within a sura.                            |
| `getWordOrderInAya(word: String, aya: Aya) -> Int`                                                | Find the position of a specific word in an aya.                                          |
| `getAyaBefore(aya: Aya) -> Aya?`                                                                  | Retrieve the aya preceding a specified aya, if available.                                |
| `getAyaAfter(aya: Aya) -> Aya?`                                                                   | Retrieve the aya following a specified aya, if available.                                |
| `countWordsInAya(aya: Aya) -> Int`                                                                | Count the number of words in a single aya.                                               |
| `countWordsInAyas(ayas: [Aya]) -> Int`                                                            | Count the total words across a list of ayas.                                             |
| `getAllAyasOfSura(_ suraNumber: SuraName) -> [Aya]`                                               | Retrieve all ayas within a specified sura.                                               |
| `getLongestAyaInFullQuran() -> Aya`                                                               | Retrieve the longest aya in the entire Quran.                                            |
| `getShortestAyaInFullQuran() -> Aya`                                                              | Retrieve the shortest aya in the entire Quran.                                           |
| `getLongestAyaInSura(_ suraNumber: SuraName, withBasmala: Bool = false) -> Aya`                   | Retrieve the longest aya within a specific sura, with or without the Basmala.            |
| `getShortestAyaInSura(_ suraNumber: SuraName, withBasmala: Bool = false) -> Aya`                  | Retrieve the shortest aya within a specific sura, with or without the Basmala.           |
| `getAyasFromSuraBeginningUntilWord(fromBeginningOfSura: SuraName, word: String) -> [Aya]`         | Retrieve ayas from the beginning of a sura until a specified word is found.              |
| `getAyasFromWordUntilSuraEnd(word: String, inSura: SuraName) -> [Aya]`                            | Retrieve ayas from a specified word until the end of a sura.                             |

