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
        $('#flash-notices').show();
        $('#flash-notices').fadeOut(15000);
      } else if (data.status === 400) {
        $('#flash-notices').html(data.message);
        $('#flash-notices').show();
        $('#flash-notices').fadeOut(15000);
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
