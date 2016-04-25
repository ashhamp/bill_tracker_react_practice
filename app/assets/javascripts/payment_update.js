$(document).ready(function(){
  var nextDueDate = function(data){
    if (data.next_due_date === '') {
      return 'N/A';
    } else {
      return data.next_due_date;
    }
  };

  var updatePayment = function(paymentId) {
    var pmtDate = $('#datepicker-update-payment').val();
    var pmtAmount = $('#update-amount').val();
    var pmtDescription = $('#update-description').val();

    var request = $.ajax({
      method: 'PATCH',
      url: '/payments/' + paymentId,
      dataType: 'json',
      data: {
        payment: {
          date: pmtDate,
          amount: pmtAmount,
          description: pmtDescription
        }
      }
    });
    request.done(function(data) {

    if (data.errors) {
      $('#payment-update-errors').html(data.errors);
    } else {
        $('.small-header').html('Total Payments: ' + data.total);
        $('#payment_date-' + paymentId).html(data.date);
        $('#payment_amount' + paymentId).html(data.amount);
        $('#payment_description' + paymentId).html(data.description);
        $('#datepicker-update-payment').val('');
        $('#update-amount').val('');
        $('#update-description').val('');
        $('#payment-update-errors').html('');
        $('#payment-update-form').foundation('close');

        var paymentDiv = $('#payment-div-' + paymentId)
        $(paymentDiv).attr('data-date', data.no_format_date);
        $(paymentDiv).attr('data-amount', data.no_format_amount);
        $(paymentDiv).attr('data-description', data.description);
      }
    });
  };


  // $('#bill-show-payment-close').click(function(){
  //   $('#payment_date').val('');
  //   $('#payment_amount').val('');
  //   $('#payment_description').val('');
  //   $('#new-payment-show-errors').html('');
  // });

  var paymentInfo = $('.payments-wrapper').on('click', '.update_payment_button',  function(){
    var paymentId = $(this).data('payment_id');
    var paymentDiv = $('#payment-div-' + paymentId);
    $(paymentDiv).removeData();

    var originalDate = $(paymentDiv).data('date');
    var originalAmount = $(paymentDiv).data('amount');
    var originalDescription = $(paymentDiv).data('description');

    $('#payment-update-form').foundation('open');
    $('#datepicker-update-payment').val(originalDate);
    $('#update-amount').val(originalAmount);
    $('#update-description').val(originalDescription);

    $('#payment_update_submit').click(function(event){
      event.preventDefault();
      event.stopPropagation();
      updatePayment(paymentId);
    });
  });
});
