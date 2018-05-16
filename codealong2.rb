class Product
 attr_accessor :category, :name, :quantity, :serial_number, :cost, :sell_price

 def initialize(category, name, quantity, serial_number, cost, sell_price)
 	@category = category
 	@name = name
 	@quantity = quantity
 	@serial_number = serial_number
 	@cost = cost
 	@sell_price = sell_price
 end
end

class GroceryStore
	attr_accessor :products

	def initialize(products)
		@products = products
	end

	def menu
		#user should be able to view categories of products
		puts "Would you like to view your product categories?(y/n)"
		answer = gets.chomp
		if answer == "y"
			# Cross-platform code to clear the terminal screen
		  Gem.win_platform? ? (system "cls") : (system "clear")
		  # If answer is yes, call the view_categories method
			view_categories
		else
			# If no, exit the system
			puts "Thank you. Good-bye."
		end
	end

	def view_categories
		#declare an empty array to hold the categories
		categories = []
		#loop through the products array
		@products.each do |product|
			#fish out the category attribute of each 
			#product and push it into the categories array
			categories.push(product.category)
		end
		# apply the uniq method to the categories array
		# so as to eliminate repeat values
		# store the results in a new array called no_repeats
		@no_repeats = categories.uniq
		#loop through the no repeats array
		#output the results, i.e. list the categories
		puts "You have #{@no_repeats.length} categories:"
		@no_repeats.each do |category|
			puts category.capitalize
		end
		# after listing the categories, we ask the user
		# if they want to view the products in each category
		puts "Would you like to view the products within each category?(y/n)"
		answer = gets.chomp
		# if the user wants to view the products, we send them to
		# the view_products method
		if answer == "y"
			view_products
		# otherwise, we send them to the main menu
		else
			menu
		end
	end

	def addProduct
		newInfo = []
		catNames = ["category", "name", "quantity", "serial_number", "cost", "sell_price"]
		puts "Enter product data:"
		
		catNames.each_with_index {|name|
		puts "Enter #{name}:" 
		info = gets.chomp     
		newInfo.push(info)
 		} 
		 
		newProduct = Product.new(newInfo[0], newInfo[1], newInfo[2].to_i, newInfo[3].to_i, newInfo[4].to_i, newInfo[5].to_i)
		products.push(newProduct)
		view_products
	end

	def view_products
		# Cross-platform code to clear the terminal screen
		Gem.win_platform? ? (system "cls") : (system "clear")
		# ask the user to select a category
		puts "Please select a category:"
		# now I loop through the list of categories
		# for each, I get its name and index place in the array
		# and I output index number + space + category name
		@no_repeats.each_with_index do |category, index|
			# note we are adding one to the index
			# the index of the first one will be zero, 
			# but we want to output one as the first number
			# so we add one to each index
			puts (index+1).to_s + " " + category
		end
		# now the user is expected to enter a number
		selection = gets.chomp
		# We have a number entered by the user
		# we want to look through the categories array 
		# and find the category that matches the number entered
		# by the user
	  selected_category = @no_repeats.at(selection.to_i-1)
	  # ask the user to select a product 
	  puts "Please select a product:"
	  # set up an array to hold the list of products in the
	  # selected category
	  products_in_this_category = []
	  # next, we loop through the products array
	  @products.each_with_index do |product, index|
	  	# if the category of a product matches the user's selection
	  	if product.category == selected_category
	  		# push each product in the category into the products_in_this
	  		# category array
	  		products_in_this_category.push(product)
	  	end
	  end
	  # loop through the list of products in the category
	  products_in_this_category.each_with_index do |product, index|
	  	# for each product, print the index number plus one and the 
	  	# product name
	  	puts (index+1).to_s + " " + product.name
	  end
	  # get the user's selection
	  selection = gets.chomp
	  # identify the product that matches the user's selection
	  selected_product = products_in_this_category.at(selection.to_i-1)
	  # clear the screen
	  Gem.win_platform? ? (system "cls") : (system "clear")
	  # print product information
	  puts "Product name: " + selected_product.name
	  puts "Category: " + selected_product.category
	  puts "Quantity in stock: " + selected_product.quantity.to_s
	  puts "Cost: " + sprintf('%.2f', selected_product.cost.to_s)
	  puts "Sell price: " + sprintf('%.2f', selected_product.sell_price.to_s)
	  puts "Serial number: " + selected_product.serial_number.to_s
	  puts ""
	  puts "Choose one of the following options"
	  puts "1 Change the quantity in stock"
	  puts "2 View another product"
	  puts "3 Return to main menu"
	 	selection = gets.chomp
	 	if selection == "1"
	 		change_quantity(selected_product)
	 	elsif selection == "2"
	 		view_products
	 	else
	 		menu
	  end
	end
end


def add_product(product)
	puts "you want to add a product " + product.name
	puts "Please enter the new quantity"
	new_quantity = gets.chomp
	@products.each do |the_old_product|
		if the_old_product == product
			the_old_product.quantity = new_quantity
		end
	end
	view_products
end

#generate an empty array to hold our products
products = []

#create 5 products in the cereals category
puffs = Product.new("cereal", "Coacoa Puffs", 20, 54678, 2.00, 2.99)
lucky_charms = Product.new("cereal", "Lucky Charms", 20, 54679, 2.00, 2.99)
pops = Product.new("cereal", "Corn Pops", 20, 54680, 1.50, 2.99)
muesli = Product.new("cereal", "Muesli", 10, 54681, 2.50, 4.99)
captain_crunch = Product.new("cereal", "Captain Crunch", 15, 54682, 1.50, 2.50)
honeyoats = Product.new("cereal", "Honey Oats", 25, 54282, 1.00, 1.50)

#create 5 products in the cookies category
chocolate_chip = Product.new("cookies", "Chocolate Chip", 20, 00001, 0.25, 1.59)
oatmeal = Product.new("cookies", "Oatmeal", 10, 00002, 0.30, 1.79)
chocolate_chocolate_chip = Product.new("cookies", "Chocolate Chocolate Chip", 10, 00003, 0.30, 1.69)
sugar = Product.new("cookies", "Sugar", 20, 00003, 0.15, 1.29)
gingersnap = Product.new("cookies", "Ginger Snap", 10, 00004, 0.25, 1.79)
whitechocolate = Product.new("cookies", "White Chocolate", 30, 00005, 0.15, 1.19)
#push all products into the products array
products.push(puffs, lucky_charms, pops, muesli, captain_crunch, honeyoats, chocolate_chip, oatmeal, chocolate_chocolate_chip, sugar, gingersnap, whitechocolate)
#create a grocery store
mom_and_pop_south = GroceryStore.new(products)
#mom_and_pop_south.view_categories
mom_and_pop_south.menu

#puts mom_and_pop_south.products[0].name
#puts "In the " + puffs.category + " category, you have " + puffs.quantity.to_s + " " + puffs.name + "."
#puts "In the #{puffs.category} category, you have #{puffs.quantity} #{puffs.name}."