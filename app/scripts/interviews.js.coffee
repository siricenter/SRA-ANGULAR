# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#//= require jquery

@eatenFoodCount = 0
@storedFoodCount = 0
@purchasedFoodCount = 0
@results = {}

createElement = (element) ->
	document.createElement element

searchConsumed = () ->
	searchString = this.value
	url = "/search.json?query=#{searchString}"
	$.ajax({
		async: true,
		url: url,
		success: (results) ->
			window.results = results
			display = $('#display')
			display.empty()
			for result in results.hits
				do (result) ->
					newRow = $('<div>').attr('id', result.fields.item_id)
					newRow.bind 'click', newFoodEaten
					newRow.append(result.fields.item_name)
					display.append(newRow)
		error: (xhr, status, errorThrown) ->
			window.alert "Status: #{status}; Error: #{errorThrown}"
	})

findResult = (id) ->
	for result in window.results.hits
		if result._id == id
			return result
	return null

newFoodEaten = (event) ->
	window.eatenFoodCount++
	result = findResult(event.target.id)
	newRow = foodRow("consumed_food", window.eatenFoodCount, result)
	beforeRow = $('#consumed_foods')
	addRow newRow, beforeRow

newFoodPurchased = () ->
	@purchasedFoodCount++
	newRow = purchasedFoodRow()
	beforeRow = document.getElementById "add_food_purchase"
	addRow newRow, beforeRow

addRow = (row, before) ->
	row.insertBefore(before)
    
removeFood = (foodId) ->
    $( "#" + foodId ).remove()
	
    
addOptions = (select, options) ->
	for element in options
		option = createElement "option"
		option.innerHTML = element
		select.appendChild option

foodRow = (name, count, result) ->
	newRow = $('<div>').addClass('row')
	newRow.attr("id", "food_div_#{result.fields.item_id}")

	hiddenId = $('<input>').val(result._id)
	hiddenId.attr('name', "consumed_foods[consumed_food_#{count}[n_id]]")
	hiddenId.attr('type', 'hidden')

	nameLabel = $('<label>')
	nameLabel.text('Name: ')
	nameLabel.addClass("col-sm-2 col-md-1")

	foodName = $('<input>')
	foodName.attr("type", "input")
	foodName.attr("disabled", "true")
	foodName.attr("name", "consumed_foods[consumed_food_#{count}[name]]")
	foodName.attr("id", "consumed_foods_#{result.fields.item_id}")
	foodName.val(result.fields.item_name)
	foodName.addClass("textfield col-sm-5 col-md-6")

	servingsLabel = $('<label>').text('Servings:')
	servingsLabel.addClass("col-sm-2 col-md-2")

	servingsSelect = $('<select>').addClass('col-sm-1 col-md-1')
	servingsSelect.attr('name', "consumed_foods[consumed_food_#{count}[servings]]")

	for number in [1..10] by 1
		option = $('<option>').val(number).text(number)
		servingsSelect.append(option)

	frequencyLabel = $('<label>').text('Per:').addClass('col-sm-1 col-md-1')

	frequencySelect = $('<select>').addClass('col-sm-1 col-md-1')
	frequencySelect.attr('name', "consumed_foods[consumed_food_#{count}[frequency]]")

	frequencyOptions = ['daily', 'weekly', 'monthly']
	for time in frequencyOptions
		option = $('<option>').val(time).text(time)
		frequencySelect.append(option)
        
	removeButton = $('<button>')
	removeButton.attr("type", "button")
	removeButton.attr("name", "remove_consumed_foods[consumed_food_#{count}[name]]")
	removeButton.attr("id", "remove_consumed_foods_#{result.fields.item_id}")
	removeButton.bind('click', () -> removeFood("food_div_#{result.fields.item_id}"))
	removeButton.html("Remove")
	removeButton.addClass("button col-sm-1 col-md-1")

	newRow.append(hiddenId)
	newRow.append(nameLabel)
	newRow.append(foodName)
	newRow.append(servingsLabel)
	newRow.append(servingsSelect)
	#newRow.append(frequencyLabel)
	newRow.append(frequencySelect)
	newRow.append(removeButton)
	
	return newRow

purchasedFoodRow = () ->
	newRow = createElement "div"
	newRow.setAttribute "class", "row"

	foodNameLabel = createElement "label"
	foodNameLabel.innerHTML = "Name: "
	foodNameLabel.setAttribute "class", "col-sm-2"

	nameInput = createElement "input"
	nameInput.setAttribute "type", "text_field"
	nameInput.setAttribute "class", "textfield " + "col-sm-2 " + "col-md-3"
	nameInput.setAttribute "name", "purchased_foods[food#{@purchasedFoodCount}[name]]"

	foodAmountLabel = createElement "label"
	foodAmountLabel.innerHTML = "Amount: "
	foodAmountLabel.setAttribute "class", "col-sm-2"

	amountInput = createElement "input"
	amountInput.setAttribute "type", "number"
	amountInput.setAttribute "class", "textfield " + "col-sm-2 " + "col-md-3"
	amountInput.setAttribute "name", "purchased_foods[food#{@purchasedFoodCount}[amount]]"

	unitSelect = createElement "select"
	unitSelect.setAttribute "name", "purchased_foods[food#{@purchasedFoodCount}[unit]]"

	units = ["grams", "kilograms"]
	for unit in units
		option = createElement "option"
		option.innerHTML = unit
		unitSelect.appendChild option

	foodFrequencyLabel = createElement "label"
	foodFrequencyLabel.innerHTML = "Times: "
	foodFrequencyLabel.setAttribute "class", "col-sm-2"

	frequencyInput = createElement "input"
	frequencyInput.setAttribute "type", "number"
	frequencyInput.setAttribute "class", "textfield " + "col-sm-2 " + "col-md-3"
	frequencyInput.setAttribute "name", "purchased_foods[food#{@purchasedFoodCount}[frequency_amount]]"

	foodTimeUnitLabel = createElement "label"
	foodTimeUnitLabel.innerHTML = "Per: "
	foodTimeUnitLabel.setAttribute "class", "col-sm-2"

	timeSelect = createElement "select"
	timeSelect.setAttribute "name", "purchased_foods[food#{@purchasedFoodCount}[time_unit]]"

	timeUnits = ["day", "week", "two weeks", "month", "year"]
	for unit in timeUnits
		option = createElement "option"
		option.innerHTML = unit
		timeSelect.appendChild option

	newRow.appendChild foodNameLabel
	newRow.appendChild nameInput
	newRow.appendChild foodAmountLabel
	newRow.appendChild amountInput
	newRow.appendChild unitSelect
	newRow.appendChild foodFrequencyLabel
	newRow.appendChild frequencyInput
	newRow.appendChild foodTimeUnitLabel
	newRow.appendChild timeSelect

	return newRow

root = exports ? this

root.removeFood = (foodId) ->
    $( "#" + foodId ).remove()

$(document).ready () ->
	#$('#add_food_eaten').bind('click', () -> newFoodStored()) 
	#$('#add_food_purchase').bind('click', () -> newFoodPurchased()) 
	$('#consumed_food_search').bind('change', searchConsumed)