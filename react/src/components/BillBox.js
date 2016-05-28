import React, { Component } from 'react';
import Bill from './Bill';
import PaymentForm from './PaymentForm';

class BillBox extends Component {
  constructor() {
    super();

    this.state = {
      bills: [],
      selectedBill: []
    };
  }

  componentWillMount() {
    this._fetchBills();
  }

  render() {
    const bills = this._getBills();

    return (
      <div>
        <div>
          <h1>Hello from React!</h1>
        </div>
        <div>
          {bills}
        </div>
        <div className="reveal" id="new-payment-form-react" data-reveal="">
         <PaymentForm addPayment={this._addPayment.bind(this)}/>

         <button className="close-button"  id="form_close_new_payment_react" data-close="" aria-label="Close modal" type="button">
           <span aria-hidden="true">&times;</span>
         </button>

       </div>
      </div>
    );
  }

  componentDidMount() {
    this._timer = setInterval(
      () => this._fetchBills(),
      5000
    );
  }

  componentWillUnmount() {
    clearInterval(this._timer);
  }

  _fetchBills() {
    $.ajax({
      method: 'GET',
      url: '/api/bills',
      success: (bills) => {
        this.setState({ bills })
      }
    });
  }

  _getBills() {
    return this.state.bills.map((bill) => {
      return (
        <Bill
          key={bill.id}
          bill={bill}
          selectBill={this._selectBill.bind(this)} />
      );
    });
  }

  _addPayment(date, amount, description) {

    const bill_id = this.state.selectedBill[0].id;
    const payment = { bill_id, date, amount, description };

    $.ajax({
      method: 'POST',
      url: '/api/payments',
      data: { payment },
      success:(updatedBill => {
        this._fetchBills();
        $('#datepicker-pmt').val('');
        $('#payment_amount').val('');
        $('#payment_description').val('');
        $('#new-payment-form-react').foundation('close');

        this.setState({
          selectedBill: []
        })
      })
    })
    .fail(function(){
      alert('failed!');
    }) ;

  }

  _selectBill(bill) {


    this.setState({
      selectedBill: []
    });
    
    this.setState({
      selectedBill: this.state.selectedBill.concat([bill])
    });

  }
}

export default BillBox;
