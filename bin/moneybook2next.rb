#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'csv'
require 'date'
require 'securerandom'

require 'plist'

class Time
  def week
    self.strftime('%U').to_i + 1
  end
end

categories_records = {}
CSV.parse(STDIN) do |row|
  next if 'expense' != row[4]
  time = DateTime.strptime(row[0], '%m/%d/%y').to_time.utc
  category = row[1]
  amount = row[2].to_f
  note = row[3]
  categories_records[category] ||= []
  categories_records[category] << [time, amount, note]
end

data = categories_records.each_with_index.map do |category_records, index|
  category, records = category_records
  transactions = records.map do |time, amount, note|
    {
      amount: amount,
      date: time,
      day: time.day,
      month: time.month,
      month_year: "#{time.month}_#{time.year}",
      note: note ? note : category,
      uniqueIdentifier: "#{SecureRandom.uuid}-#{SecureRandom.random_number(10000)}-#{SecureRandom.hex(8)}".upcase,
      week: time.week,
      week_year: "#{time.week}_#{time.year}",
      year: time.year,
    }
  end

  {
    imageName: "#{index}.png",
    sortIndex: index,
    transactions: transactions,
    uniqueIdentifier: "#{index}",
  }
end

data = data + ((categories_records.size)...27).map do |index|
  {
    imageName: "#{index}.png",
    sortIndex: index,
    transactions: [],
    uniqueIdentifier: "#{index}",
  }
end

puts ({ 'Data' => data }.to_plist)
