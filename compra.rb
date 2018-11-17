require "byebug"
require "page-object"
require "./page/home"
require "./page/product_detail"
require "./page/checkout"
require "./page/assertion"
require "./page/order_history"
include Assertion

browser = Selenium::WebDriver.for :firefox
home_page = Home.new(browser)
home_page.goto
home_page.products_list.first.click

product_detail = ProductDetail.new(browser)
product_detail.size='M'
product_detail.color
product_detail.add_to_cart
product_detail.proceed_to_chk

checkout = Checkout.new(browser)
raise StandardError.new("El producto no tiene stock") unless checkout.stock == "In stock"
checkout.proceed_to_chk_1
checkout.email='maga.gon93@gmail.com'
checkout.pass='PRUEBAS123'
checkout.submit
assert "Ese no es mi nombre" do
checkout.my_name == "Magali Gonzalez"
end
assert "Esa no es mi dirección" do
checkout.address == "Frias 552"
end
assert "Ese no es mi telefono" do
checkout.phone == "1150262453"
end
checkout.proceed_to_chk_2
assert "Ya has aceptado los terminos y condiciones" do
	checkout.check_terms_checked? == false
end
checkout.check_check_terms
checkout.proceed_to_chk_3
assert "El producto no tiene stock" do
	checkout.stock == "In stock"
end
checkout.bank_wire
checkout.confirm_order
assert "La compra no se realizó con exito" do 
	checkout.order_complete == "Your order on My Store is complete."
end
reference_number = checkout.box.match(/([A-Z\d]{8,})/)[1]
puts reference_number
checkout.back_to_orders

order_history = OrderHistory.new(browser)
assert "No estas en tu historial de compras" do
	order_history.current_url == "http://automationpractice.com/index.php?controller=history"
end
assert "Tu última compra realizada no aparece" do
	order_history.block_history.include? reference_number
end
order_history.backs_element[1].click

browser.close()

