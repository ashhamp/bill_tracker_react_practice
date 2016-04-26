$(document).ready(function(){

  var deletePayment = function(paymentId, url) {

    var request = $.ajax({
      method: 'DELETE',
      url: url,
      dataType: 'json',
    });
    request.done(function(data) {
      if (data.status === 200) {
        $('#payment-div-' + paymentId).remove();
        $('.small-header').html(data.total);
        $('#flash-notices').html(data.message);
      } else if (data.status === 500) {
        $('#flash-notices').html(data.message);
      }
    });
  };

  $('.bill-show-wrapper').on('click', '.payment-delete', function(event){
    event.preventDefault();
    event.stopPropagation();

    var paymentId = $(this).data('payment_id');
    var url = $(this).attr('href');

    deletePayment(paymentId, url);
  });
});
