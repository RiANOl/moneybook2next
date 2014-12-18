# moneybook2next

A simple tool to migrate your [MoneyBook](http://noidentity.com/moneybook.html) data to [Next](http://noidentity.com/next.html).

## Requirement
- Ruby 1.9.3 or above
- Bundler
- Next

## Installation
1. Download this source.
2. Run ```bundle install``` in the source directory.

## Usage
1. Prepare your MoneyBook CSV.
2. run ```cat MONEYBOOK_CSV_PATH | ./bin/moneybook2next.rb > moneybook.next``` in the source directory.
3. Import moneybook.next into Next.

## Limitation
- Only expenses could be migrated.
- Support up to 27 cateogries.
- Category icons would mismatched after migration.
