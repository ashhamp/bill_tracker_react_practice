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
  var today = new Date();
  var jsStartDate = new Date(start_due_date);

  // if(nickname === "" || start_due_date === "") {
  //   alert("Nickname and Starting Date both required")
  // } else if (jsStartDate < today) {
  //   alert("Starting Date must be later than today's date");
  // } else {
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
      } else if (data.error) {
        $('#new-bill-errors').html(data['error']);
      }
    });
  };

  var billFormat = function(data) {


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
              data.next_date +
          '</div>' +
        '</div>';
      }
    //     <div class="small-12 columns">
    //       <div class="small-6 columns right-aligned">
    //         Amount Paid:
    //       </div>
    //       <div class="small-6 columns">
    //         <% if bill.recurring_amt.present? %>
    //           <%= number_to_currency(bill.recurring_amt) %>
    //         <% else %>
    //           N/A
    //         <% end %>
    //       </div>
    //     </div>
    //     <div class="small-12 columns">
    //       <div class="small-6 columns right-aligned">
    //         <% if bill.url.present? %>
    //           <%= link_to "web", bill.url %>
    //         <% end %>
    //       </div>
    //       <div class="small-6 columns">
    //         <button class="button pill">Paid</button>
    //       </div>
    //     </div>
    //   </div>
    // </div>
