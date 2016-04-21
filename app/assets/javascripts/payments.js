$(function(){
  $(".payment-button").submit(function(event){
    event.preventDefault();

    $('#new-payment-form').foundation('open');

    var billIdString = $(this).attr('id');
    var billId = billIdString.split("-")[1];

    addPayment(action, method, nickname, billUrl, start_due_date, recurring_amt, one_time);

  });
});

var addPayment = function(billId) {
  $('#payment_submit').submit(function(event){
    event.preventDefault();

    var request = $.ajax({
      method: 'POST',
      url: '/payments',
      dataType: 'json',
      data: { payment: {
        bill_id: billId,
        pmt_date: pmtDate,
        pmt_amt: pmtAmount

      }},
    });
    request.done(function(data) {

      if (data.bill) {
        $('#new_bill').prepend(billFormat(data));
        $('#new-bill-form').foundation('close');
      } else if (data.error) {
        $('#new-bill-errors').html(data['error']);
      }
    });
  };

  var billFormat = function(data) {
    var nextDate;
    if (data.next_date === "") {
      nextDate = "N/A";
    } else {
      nextDate = data.next_date;
    }

    var webSite;
    if (data.bill.url === "") {
      webSite = "";
    } else {
      webSite = "<a href='" + data.bill.url + "'>web</a>";
    }

    var recurring;
    if (data.recurring_amt === "") {
      recurring = "N/A";
    } else {
      recurring = data.recurring_amt;
    }

    return '<div class="small-12 medium-6 large-4 end columns mini-bills">' +
      '<div class="small-12 columns bill-padding">' +
        '<div class="small-12 columns index-bill-name">' +
          '<a href="bills/' + data.bill.id + '">'  + data.bill.nickname + '</a>' +
        '</div>' +
        '<div class="small-12 columns">' +
          '<div class="small-6 columns right-aligned">' +
            'Next Due:' +
          '</div>' +
          '<div class="small-6 columns">' +
              nextDate +
          '</div>' +
        '</div>' +
        '<div class="small-12 columns">' +
          '<div class="small-6 columns right-aligned">' +
            'Amount Paid:' +
          '</div>' +
          '<div class="small-6 columns">' +
            recurring +
          '</div>' +
        '</div>' +
        '<div class="small-12 columns">' +
          '<div class="small-6 columns right-aligned">' +
            webSite +
          '</div>' +
          '<div class="small-6 columns">' +
            '<button class="button pill">Paid</button>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</div>';
  }
