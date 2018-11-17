require "byebug"
require "page-object"
require "./page/home"
require "./page/product_detail"
require "./page/checkout"
require "./page/assertion"
require "./page/order_history"
include Assertion

#Se ingresa a la home y se selecciona el primero producto
browser = Selenium::WebDriver.for :firefox
home_page = Home.new(browser)
home_page.goto
home_page.products_list.first.click

#En la ficha del producto se cambia el tamaño y el color del mismo para continuar la compra
product_detail = ProductDetail.new(browser)
product_detail.size='M'
product_detail.color
product_detail.add_to_cart
product_detail.proceed_to_chk

#Llegamos el checkout y corroboramos el stock del producto, en el paso 1, para continuar
checkout = Checkout.new(browser)
raise StandardError.new("El producto no tiene stock") unless checkout.stock == "In stock"
checkout.proceed_to_chk_1
#Nos loggeamos, en el paso 2, para continuar
checkout.email='maga.gon93@gmail.com'
checkout.pass='PRUEBAS123'
checkout.submit
#Corroboramos nuestros datos, en el paso 3, para continuar
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
#Aceptamos terminos y condicione, si no lo aceptamos ya antes
assert "Ya has aceptado los terminos y condiciones" do
	checkout.check_terms_checked? == false
end
checkout.check_check_terms
checkout.proceed_to_chk_3
assert "El producto no tiene stock" do
	checkout.stock == "In stock"
end
#Elegimos forma de pago y continuamos
checkout.bank_wire
checkout.confirm_order
assert "La compra no se realizó con exito" do 
	checkout.order_complete == "Your order on My Store is complete."
end
#Sacamos y guardamos el número de referencia
reference_number = checkout.box.match(/([A-Z\d]{8,})/)[1]
puts reference_number
checkout.back_to_orders

#Una ver terminada la compra, revisamos el número de refencia dentro de nuestro historial de compras
order_history = OrderHistory.new(browser)
assert "No estas en tu historial de compras" do
	order_history.current_url == "http://automationpractice.com/index.php?controller=history"
end
assert "Tu última compra realizada no aparece" do
	order_history.block_history.include? reference_number
end
order_history.backs_element[1].click

browser.close()

