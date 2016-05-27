import React, { Component } from 'react';

class PaymentForm extends Component {
  render() {

    return (

      <form className="new-payment-submit-react">
        <div className="small-12 columns">
          <div className="small-12 centered columns">
            <h3 className="grey-text">Add Payment</h3>
          </div>
        </div>

        <div className="small-12 columns red-errors" id="new-payment-errors">
        </div>
        <div className="small-12 columns red-errors">
        </div>

        <div className="small-12 columns">
          <div className="small-12 columns">
            <label htmlFor="payment_date">Date Paid</label>
            <input as="datepicker" className="datepicker" id="datepicker-pmt" ref={(dateInput) => this._date = dateInput} />
          </div>
        </div>

        <div className="small-12 columns">
          <div className="small-12 columns">
            <label htmlFor="payment_amount">Amount Paid</label>
            <input id="payment_amount" ref={(amountInput) => this._amount = amountInput} />
          </div>
        </div>

        <div className="small-12 columns">
          <div className="small-12 columns">
            <label htmlFor="payment_description">Description</label>
            <textarea id="payment_description" ref={(descriptionInput) => this._description = descriptionInput}>
            </textarea>
          </div>
        </div>

        <div className="small-12 small-centered columns">
          <div>
            <input type="submit" name="commit" value="Submit" className="close-reveal-modal button pill" id="payment_submit" />
          </div>
        </div>
      </form>

    );
  }
}

export default PaymentForm;
