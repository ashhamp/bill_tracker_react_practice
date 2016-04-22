  var nextDueDate = function(data){
    if (data.next_due_date === null) {
      return "N/A";
    } else {
      return data.next_due_date;
    }
  };

  var addPayment = function(billId) {
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
        $('#next_due_date' + billId).html(nextDueDate(data));
        $('#new-payment-form').foundation('close');
      } else if (data.errors) {
        $('#new-payment-errors').html(data.errors);
      }
    });

  };

  $(function(){
    $("#form_close_new_payment").click(function(){
      $('#payment_date').val("");
      $('#payment_amount').val("");
      $('#payment_description').val("");
      $('#new-payment-errors').html("");
    });
  });

  $(function(){
    $(".bill-index").on('click', ".payment-button", function(event){
      event.preventDefault();

      var billIdString = $(this).attr('id');
      var billId = billIdString.split("-")[1];

      $('#new-payment-form').foundation('open');

      $('#payment_submit').click(function(event){
        event.preventDefault();
      addPayment(billId);
      });
    });
  });
