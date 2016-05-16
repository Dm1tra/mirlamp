//= require bootstrap-sprockets
//= require jquery.payment
//= require jquery.validate/jquery.validate.min
//= require spree
//= require spree/frontend/cart
//= require spree/frontend/checkout
//= require spree/frontend/checkout/address
//= require spree/frontend/checkout/payment
//= require spree/frontend/product
//= require owl.carousel
$(function() {
  $(".owl-carousel").owlCarousel({
    items: 4,
    nav: true,
    navText: ['<i class="glyphicon glyphicon-chevron-left"></i>', '<i class="glyphicon glyphicon-chevron-right"></i>'],
    itemsCustom: false,
    itemsDesktop: [1199, 4],
    itemsDesktopSmall: [980, 3],
    itemsTablet: [768, 2],
    itemsTabletSmall: false,
    itemsMobile: [479, 1],
    singleItem: false,
    itemsScaleUp: false,
    responsive: true,
    baseClass: "owl-carousel",
    theme: "owl-theme",
    lazyLoad: false,
    lazyFollow: true,
    lazyEffect: "fade",
    transitionStyle: true,
    responsiveClass: true,
    responsive: {
      0: {
        items: 1
      },
      500: {
        items: 4
      }
    }
  })
});

$(document).ready(function() {
  var sideslider = $('[data-toggle=collapse-side]');
  var sel = sideslider.attr('data-target');
  var sel2 = sideslider.attr('data-target-2');
  sideslider.click(function(event){
      $(sel).toggleClass('in');
      $(sel2).toggleClass('out');
  });
});
