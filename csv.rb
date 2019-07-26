require 'csv'

CSV.open("jvvnl.csv", "a") do |csv|
  csv << ['Name', 'K Number', 'Binder No', 'Account No', 'Amount']
end