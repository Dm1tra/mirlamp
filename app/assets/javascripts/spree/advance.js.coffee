window.calculat_advance = ->
  price = $('#product_price').val()
  cost_price = $('#product_cost_price').val()
  if price != '' && cost_price != ''
    price = parseInt(price.replace(/ /g,''))
    cost_price = parseInt(cost_price.replace(/ /g,''))
    advance = price-cost_price
    $('#advance').html('+' + advance)
  else
    $('#advance').html('')
$(document).on 'ready page:load', ->
  if $('#product_price').length && $("#product_cost_price").length
    calculat_advance()
  $('#product_price, #product_cost_price').keyup ->
    calculat_advance()
