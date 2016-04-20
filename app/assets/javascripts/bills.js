// $(function(){
//   $("#new-bill-submit").submit(function(event){
//     event.preventDefault();
//
//     var action = $(this).attr('action');
//     var method = $(this).attr('method');
//
//     var nickname = $(this).find('#bill_nickname').val();
//     var billUrl = $(this).find('#bill_url').val();
//     var start_due_date = $(this).find('#datepicker').val();
//     var recurring_amt = $(this).find('#bill_recurring_amt').val();
//     var one_time = $(this).find('#bill_one_time').val();
//
//     addBill(action, method, nickname, billUrl, start_due_date, recurring_amt, one_time);
//
//   });
// });
//
//
// var addBill = function(action, method, nickname, billUrl, start_due_date, recurring_amt, one_time) {
//   var request = $.ajax({
//     method: method,
//     url: action,
//     data: { bill: {
//       nickname: nickname,
//       url: billUrl,
//       start_due_date: start_due_date,
//       recurring_amt: recurring_amt,
//       one_time: one_time
//     }},
//     dataType: 'script'
//   });
//   request.done(function(data) {
//
//
//   });
// }
