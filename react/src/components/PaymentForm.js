import React, { Component } from 'react';

class PaymentForm extends Component {
  render() {

    return (

      <form onSubmit={this._handleSubmit.bind(this)}>
        <div className="small-12 centered columns">
          <h3 className="grey-text">Add Payment</h3>
        </div>

        <div className="small-12 columns red-errors" id="new-payment-errors">
        </div>

        <div className="small-12 columns">

          <label htmlFor="payment_date">Date Paid</label>
          <input as="datepicker" className="datepicker small-12 columns" id="datepicker-pmt" ref={(dateInput) => this._date = dateInput} />

          <label htmlFor="payment_amount">Amount Paid</label>
          <input className="small-12 columns" id="payment_amount" ref={(amountInput) => this._amount = amountInput} />

          <label htmlFor="payment_description">Description</label>
          <textarea className="small-12 columns" id="payment_description" ref={(descriptionInput) => this._description = descriptionInput}>
          </textarea>

          <input type="submit" name="commit" value="Submit" className="close-reveal-modal button pill small-12 columns" id="payment_submit" />
        </div>
      </form>
    );
  }

  _handleSubmit(event) {
      event.preventDefault();

      let date = this._date;
      let amount = this._amount;
      let description = this._description;

      if (!date.value.trim() || !amount.value.trim()) {
        alert("Please enter a date and amount");
        return
      }

      this.props.addPayment(date.value, amount.value, description.value);
    }
}

export default PaymentForm;
