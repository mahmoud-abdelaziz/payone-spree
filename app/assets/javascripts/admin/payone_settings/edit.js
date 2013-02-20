jQuery(document).ready(function() {
  payone_billing_address_validation_type_changed();
  payone_shipping_address_validation_type_changed();
});

function payone_billing_address_validation_type_changed() {
  payone_address_validation_type_changed(
    '#payone_billing_address_validation_type',
    '#payone_billing_address_validation_address_check',
    '#payone_billing_address_validation_consumer_score'
  );
}

function payone_shipping_address_validation_type_changed() {
  payone_address_validation_type_changed(
    '#payone_shipping_address_validation_type',
    '#payone_shipping_address_validation_address_check',
    '#payone_shipping_address_validation_consumer_score'
  );
}

function payone_address_validation_type_changed(select, address_check, consumer_score) {
  var selected = $(select).val();
  
  switch(selected) {
    case 'none':
      $(address_check).hide();
      $(consumer_score).hide();
      break;
    case 'addresscheck':
      $(address_check).show();
      $(consumer_score).hide();
      break;
    case 'consumerscore':
      $(address_check).hide();
      $(consumer_score).show();
      break;
    default:
      break;
  }
}