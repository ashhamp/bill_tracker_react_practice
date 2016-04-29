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
    var pmtAmount = $('#payment_amount_' + billId).val();
    var pmtDescription = $('#payment_description_' + billId).val();

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
        $('#datepicker-pmt-' + billId).val('');
        $('#payment_amount_' + billId).val('');
        $('#payment_description_' + billId).val('');
        $('#new-payment-form-' + billId).foundation('close');
      } else if (data.errors) {
        $('#new-payment-errors-' + billId).html(data.errors);
      }
    });
  };


  $('.form_close_new_payment').click(function(){
    var billId = $(this).attr('id').split('_')[2];

    $('#datepicker-pmt-' + billId).val('');
    $('#payment_amount_' + billId).val('');
    $('#payment_description_' + billId).val('');
    $('#new-payment-errors-' + billId).html('');
  });



  $('.new-payment-submit').on('submit', function(event){
    event.preventDefault();

    var billIdString = $(this.parentElement).attr('id');
    var billId = billIdString.split('-')[3];

    addPayment(billId);
  });
});
