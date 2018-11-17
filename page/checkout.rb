class Checkout
	include PageObject

	#Paso 1 Summary 
	span :stock , class: 'label label-success'
	link :delete , id: '1_4_0_0'
	link :proceed_to_chk_1 , class: 'button btn btn-default standard-checkout button-medium'

	#Paso 2 Sign in
	text_field :email , id: 'email'
	text_field :pass , id: 'passwd'
	button :submit , id: 'SubmitLogin'

	#Paso 3 Address
	list_item :my_name , class: 'address_firstname address_lastname'
	list_item :address , class: 'address_address1 address_address2'
	list_item :phone , class: 'address_phone_mobile'
	button :proceed_to_chk_2 , class: 'button btn btn-default button-medium'

	#Paso 4 Shipping
	checkbox :check_terms , id: 'cgv'
	button :proceed_to_chk_3 , class: 'button btn btn-default standard-checkout button-medium'

	#Paso 5 Payment
	link :bank_wire , class: 'bankwire'
	link :check , class: 'cheque'
	button :confirm_order , class: 'button btn btn-default button-medium'
	paragraph :order_complete , class: 'cheque-indent'
	link :back_to_orders , class: 'button-exclusive btn btn-default'
	div :box , class: 'box'
	
end