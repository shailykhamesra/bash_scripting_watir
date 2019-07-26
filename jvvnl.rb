require 'watir'
require 'faker'
require 'csv'

browser = Watir::Browser.new
@url = browser.goto('https://www.billdesk.com/pgidsk/pgmerc/jvvnljp/JVVNLJPDetails.jsp?billerid=RVVNLJP')
form = browser.form(name: 'form1')
form.radio(name: 'service',:value => 'BILL').set
form.text_field(name: 'txtCustomerID').set((210742023960+ARGV.fetch(0).to_i).to_s)
form.text_field(name: 'txtEmail').set(Faker::Internet.email)
form.button(class_name: 'subtn').click
# browser.screenshot.save ("preview_browser#{ARGV.fetch(0).to_i}.png")
if browser.table.id == 'tb_confirm'
  amount_payable = browser.tr(text: /Amount Payable/).td(:index => 1).text
  k_number = browser.tr(text: /K Number/).td(:index => 1).text
  binder_number = browser.tr(text: /Binder Number/).td(:index => 1).text
  account_number = browser.tr(text: /Account Number/).td(:index => 1).text
  customer_name = browser.tr(text: /Customer Name/).td(:index => 1).text
  if (amount_payable.to_i > 10000)
    CSV.open("jvvnl.csv", "a") do |csv|
      csv << [customer_name, k_number, binder_number, account_number, amount_payable]
    end
  end
elsif browser.table.id == 'tb_detail'
  @url
end


