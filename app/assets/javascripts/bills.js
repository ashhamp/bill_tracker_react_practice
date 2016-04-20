$(function(){
  $("#new-bill-submit").submit(function(event){
    event.preventDefault();

    var action = $(this).attr('action');
    var method = $(this).attr('method');

    var nickname = $(this).find('#bill_nickname').val();
    var billUrl = $(this).find('#bill_url').val();
    var start_due_date = $(this).find('#datepicker').val();
    var recurring_amt = $(this).find('#bill_recurring_amt').val();
    var one_time = $(this).find('#bill_one_time').val();

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
      if (data['bill']) {
        debugger;

        console.log("hello, i worked!");
      } else if (data['error']) {
        $('#new-bill-errors').html(data['error']);
      }
    });
  };

  var billFormat = function(bill) {
    "<div class='small-12 medium-6 large-4 end columns mini-bills'>" +
      "<div class='small-12 columns bill-padding'>" +
        "<div class='small-12 columns index-bill-name'>"
          "<%= link_to " bill.nickname + ", bill_path(" + bill.id + ") %>" +
        "</div>" +
        "<div class="small-12 columns">" +
          "<div class="small-6 columns right-aligned">" +
            "Next Due:" +
          "</div>" +
          "<div class="small-6 columns">" +
            "<% if " + bill.next_due_date.present? %>
              <%= bill.next_due_date.strftime('%D') %>
            <% else %>
              N/A
            <% end %>
          </div>
        </div>
        <div class="small-12 columns">
          <div class="small-6 columns right-aligned">
            Amount Paid:
          </div>
          <div class="small-6 columns">
            <% if bill.recurring_amt.present? %>
              <%= number_to_currency(bill.recurring_amt) %>
            <% else %>
              N/A
            <% end %>
          </div>
        </div>
        <div class="small-12 columns">
          <div class="small-6 columns right-aligned">
            <% if bill.url.present? %>
              <%= link_to "web", bill.url %>
            <% end %>
          </div>
          <div class="small-6 columns">
            <button class="button pill">Paid</button>
          </div>
        </div>
      </div>
    </div>

  }
