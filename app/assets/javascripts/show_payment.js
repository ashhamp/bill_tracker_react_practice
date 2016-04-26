$(document).ready(function(){
  var nextDueDate = function(data){
    if (data.next_due_date === '') {
      return 'N/A';
    } else {
      return data.next_due_date;
    }
  };

  var paymentFormat = function(data) {

    var paymentDescription;
    if (data.payment.description === "") {
      paymentDescription = "";
    } else {
      paymentDescription = '<div class="small-12 columns">' +
      data.payment.description + '</div>';
    }

  return '<div class="small-12 columns payment-area" id="payment-div-' + data.payment.id + '", data-date="' + data.payment.date + '", data-amount="' + data.payment.amount + '", data-description="' + data.payment.description + '">' +
    '<div class="small-6 columns">' +
      '<div class="small-6 columns" id="payment_date-' + data.payment.id + '">' +
        data.payment_date +
      '</div>' +
      '<div class="small-6 columns" id="payment_amount' + data.payment.id + '">' +
        data.payment_amount +
      '</div>' +
    '</div>' +
    '<div class="small-6 columns">' +
        '<div class="small-6 columns">' +
          '<a href="#" class="update_payment_button", id="update-' + data.payment.id + '", data-payment_id="' + data.payment.id + '"> Update</a>' +
        '</div>' +
        '<div class="small-6 columns">' +
          '<a class="payment-delete" id="delete-' + data.payment.id + '" data-payment_id="' + data.payment.id + '" rel=nofollow" data-method="delete" href="/payments/' + data.payment.id + '">Delete</a>' +
        '</div>' +
      '</div>' +
        paymentDescription +
    '</div>' +
  '</div>';
};

  var addPaymentShow = function(billId) {
    var pmtDate = $('#payment_date').val();
    var pmtAmount = $('#payment_amount').val();
    var pmtDescription = $('#payment_description').val();

    var request = $.ajax({
      method: 'POST',
      url: '/payments',
      dataType: 'json',
      data: {
        payment: {
          bill_id: billId,
          date: pmtDate,
          amount: pmtAmount,
          description: pmtDescription
        }
      }
    });
    request.done(function(data) {

      if (data.payment) {
        $('#show-next-due').html(nextDueDate(data));
        $('.payments-wrapper').prepend(paymentFormat(data));
        $('#payment_date').val('');
        $('#payment_amount').val('');
        $('#payment_description').val('');
        $('#bill-show-payment-form').foundation('close');
      } else if (data.errors) {
        $('#new-payment-show-errors').html(data.errors);
      }
    });
  };


  $('#bill-show-payment-close').click(function(){
    $('#payment_date').val('');
    $('#payment_amount').val('');
    $('#payment_description').val('');
    $('#new-payment-show-errors').html('');
  });

  $('#bill-show-payment').on('click', function(){

    var billId = $(this).data('bill');

    $('#show_payment_submit').one('click', function(event){
      event.preventDefault();
    addPaymentShow(billId);
    });
  });
});
