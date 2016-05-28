import React, { Component } from 'react';

class Bill extends Component {
  render() {
    let { id, next_due_date, nickname, recurring_amt, start_due_date, url } = this.props.bill

    let nextDueDate;

    if (next_due_date) {
      nextDueDate = next_due_date;
    } else {
      nextDueDate = 'N/A';
    }

    let recurringAmount;

    if (recurring_amt) {
      recurringAmount = recurring_amt;
    } else {
      recurringAmount = 'N/A';
    }

    let billUrl;

    if (url) {
      billUrl =
        <div className="small-4 columns centered">
          <a className='circle-button' href={`${url}`}>web</a>
        </div>;
    } else {
      billUrl = '';
    }


    return (
      <div className="small-12 medium-6 large-4 end columns mini-bills">
        <div className="small-12 columns bill-padding">
          <div className="small-12 columns index-bill-name">
            <a className="bill-title" href={`/bills/${id}`}>{nickname}</a>
          </div>
          <div className="small-12 columns white-text">
            <div className="small-6 columns right-aligned">
              Next Due:
            </div>
            <div className="small-6 columns" id={`next_due_date${id}`}>
              {nextDueDate}
            </div>
          </div>
          <div className="small-12 columns white-text button-margin">
            <div className="small-6 columns right-aligned">
              Amount:
            </div>
            <div className="small-6 columns">
              {recurringAmount}
            </div>
          </div>
          <div className="small-12 columns">
            <div className="small-4 columns">
              <a className="circle-button" href={`/bills/${id}`}>details</a>
            </div>
              {billUrl}
            <div className="small-4 columns payment-align">
              <a href="#" className="payment-button" id={`paid-${id}`} onClick={this._handleSelectBill.bind(this)} data-open="new-payment-form-react">paid</a>
            </div>
          </div>
        </div>
      </div>
    );
  }

  _handleSelectBill() {
    const bill = this.props.bill;

    this.props.selectBill(bill)
  }
}

export default Bill;
