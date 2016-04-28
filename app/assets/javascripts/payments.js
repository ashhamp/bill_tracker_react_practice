$(document).ready(function(){
  var nextDueDate = function(data){
    if (data.next_due_date === '') {
      return 'N/A';
    } else {
      return data.next_due_date;
    }
  };

  var addPayment = function(billId) {
    var pmtDate = $('#datepicker-pmt-' + billId).val();
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
        $('#next_due_date' + billId).html(nextDueDate(data));
        $('#payment_date').val('');
        $('#payment_amount').val('');
        $('#payment_description').val('');
        $('#new-payment-form-' + billId).foundation('close');
      } else if (data.errors) {
        $('#new-payment-errors').html(data.errors);
      }
    });
  };


  $('#form_close_new_payment').click(function(){
    $('#payment_date').val('');
    $('#payment_amount').val('');
    $('#payment_description').val('');
    $('#new-payment-errors').html('');
  });



  $('.new-payment-submit').submit(function(event){
    event.preventDefault();

    var billIdString = $(this.parentElement).attr('id');
    var billId = billIdString.split('-')[3];

    addPayment(billId);
  });
});
