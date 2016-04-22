
  $(function(){
    $(".payment-button").click(function(event){
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
debugger;
      if (data.payment) {
        $('#new_bill').prepend(billFormat(data));
        $('#new-bill-form').foundation('close');
      } else if (data.errors) {
        $('#new-payment-errors').html(data.errors);
      }
    });

  };

  $(function(){
    $("#form_close_new_payment").click(function(event){
      $('#payment_date').val("");
      $('#payment_amount').val("");
      $('#payment_description').val("");
      $('#new-payment-errors').html("");
    });
  });




// var clearPaymentInfo = function(){
//
//
//   var pmtDate = $('#payment_pmt_date').val();
//   var pmtAmount = $('#payment_pmt_amt').val();
// }

  // var billFormat = function(data) {
  //   var nextDate;
  //   if (data.next_date === "") {
  //     nextDate = "N/A";
  //   } else {
  //     nextDate = data.next_date;
  //   }
  //
  //   var webSite;
  //   if (data.bill.url === "") {
  //     webSite = "";
  //   } else {
  //     webSite = "<a href='" + data.bill.url + "'>web</a>";
  //   }
  //
  //   var recurring;
  //   if (data.recurring_amt === "") {
  //     recurring = "N/A";
  //   } else {
  //     recurring = data.recurring_amt;
  //   }
  //
  //   return '<div class="small-12 medium-6 large-4 end columns mini-bills">' +
  //     '<div class="small-12 columns bill-padding">' +
  //       '<div class="small-12 columns index-bill-name">' +
  //         '<a href="bills/' + data.bill.id + '">'  + data.bill.nickname + '</a>' +
  //       '</div>' +
  //       '<div class="small-12 columns">' +
  //         '<div class="small-6 columns right-aligned">' +
  //           'Next Due:' +
  //         '</div>' +
  //         '<div class="small-6 columns">' +
  //             nextDate +
  //         '</div>' +
  //       '</div>' +
  //       '<div class="small-12 columns">' +
  //         '<div class="small-6 columns right-aligned">' +
  //           'Amount Paid:' +
  //         '</div>' +
  //         '<div class="small-6 columns">' +
  //           recurring +
  //         '</div>' +
  //       '</div>' +
  //       '<div class="small-12 columns">' +
  //         '<div class="small-6 columns right-aligned">' +
  //           webSite +
  //         '</div>' +
  //         '<div class="small-6 columns">' +
  //           '<button class="button pill">Paid</button>' +
  //         '</div>' +
  //       '</div>' +
  //     '</div>' +
  //   '</div>';
  // }
