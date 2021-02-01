#  Swift CSV Generator

Easy, straightforward csv generation.

### Carthage

	github "mredig/Swift-CSV-Generator"
	
### SPM

	https://github.com/mredig/Swift-CSV-Generator.git
	
### Usage

```swift
import CSV_Generator

//rows must contain unique names to retain unique data
let generator = CSVGenerator(with: ["foo", "bar", "wham", "bam"])

let newRow = ["foo": "1", "bar":"2", "bam":"3", "extra": "unused"]
generator.appendRow(with: newRow)

let csvString = generator.generateCSV()

//foo,bar,wham,bam
//1,2,,3
```

