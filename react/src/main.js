import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';

$(function() {

  class Bill extends React.Component {
    render() {

      let nextDueDate;

      if (this.props.bill.next_due_date) {
        nextDueDate = this.props.bill.next_due_date;
      } else {
        nextDueDate = 'N/A';
      }


      let recurringAmount;

      if (this.props.bill.recurring_amt) {
        recurringAmount = this.props.bill.recurring_amt;
      } else {
        recurringAmount = 'N/A';
      }


      let billUrl;

      if (this.props.bill.url) {
        billUrl =
          <div className="small-4 columns centered">
            <a className='circle-button' href={`${this.props.bill.url}`}>web</a>
          </div>;
      } else {
        billUrl = '';
      }


      return (
        <div className="small-12 medium-6 large-4 end columns mini-bills">
          <div className="small-12 columns bill-padding">
            <div className="small-12 columns index-bill-name">
              <a className="bill-title" href={`/bills/${this.props.bill.id}`}>{this.props.bill.nickname}</a>
            </div>
            <div className="small-12 columns white-text">
              <div className="small-6 columns right-aligned">
                Next Due:
              </div>
              <div className="small-6 columns" id={`next_due_date${this.props.bill.id}`}>
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
                <a className="circle-button" href={`/bills/${this.props.bill.id}`}>details</a>
              </div>
                {billUrl}
              <div className="small-4 columns payment-align">
                <a href="#" className="payment-button" id={`paid-${this.props.bill.id}`} data-open="new-payment-form-react">paid</a>
              </div>
            </div>
          </div>
        </div>
      );
    }
  }

  class PaymentForm extends React.Component {
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

  class BillBox extends React.Component {

    constructor() {
      super();

      this.state = {
        bills: []
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
            <PaymentForm />

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
          bill={bill} />
      );
    });

  }
  }


  ReactDOM.render(
    <BillBox />,
    document.getElementById('bills-box')
  );
});
