require './page/product'

class Home
	include PageObject

	page_url "http://automationpractice.com/index.php"
	page_sections :products_list , Product , class: "product-container"

end