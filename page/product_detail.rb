class ProductDetail
	include PageObject

	button :add_to_cart , css: '#add_to_cart button'
	select_list :size , id: 'group_1'
	link :color , id: 'color_14'
	link :proceed_to_chk , class: "btn btn-default button button-medium"
	
end