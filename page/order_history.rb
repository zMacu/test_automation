class OrderHistory
	include PageObject

	page_url "http://automationpractice.com/index.php?controller=history"
	div :block_history , id: 'block-history'
	unordered_list :backs , class: 'footer_links clearfix'
	
end