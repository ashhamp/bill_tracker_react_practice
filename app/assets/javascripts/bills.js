$(function(){
  $("#new-bill-submit").submit(function(event){
    event.preventDefault();

    var action = $(this).attr('action');
    var method = $(this).attr('method');

    var nickname = $('#bill_nickname').val();
    var billUrl = $('#bill_url').val();
    var start_due_date = $('#datepicker').val();
    var recurring_amt = $('#bill_recurring_amt').val();
    var one_time = $('#bill_one_time').val();

    addBill(action, method, nickname, billUrl, start_due_date, recurring_amt, one_time);

  });
});

var addBill = function(action, method, nickname, billUrl, start_due_date, recurring_amt, one_time) {
    var request = $.ajax({
      method: method,
      url: action,
      dataType: 'json',
      data: { bill: {
        nickname: nickname,
        url: billUrl,
        start_due_date: start_due_date,
        recurring_amt: recurring_amt,
        one_time: one_time
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
