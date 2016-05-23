import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';

$(function() {

  class Bill extends React.Component {
    render() {

      let nextDueDate;

      if (this.props.nextDueDate) {
        nextDueDate = this.props.nextDueDate;
      } else {
        nextDueDate = 'N/A';
      }


      let recurringAmount;

      if (this.props.recurringAmount) {
        recurringAmount = this.props.recurringAmount;
      } else {
        recurringAmount = 'N/A';
      }


      let billUrl;

      if (this.props.billUrl) {
        billUrl =
          <div className="small-4 columns centered">
            <a className='circle-button' href={`${this.props.billUrl}`}>web</a>
          </div>;
      } else {
        billUrl = '';
      }


      return (
        <div className="small-12 medium-6 large-4 end columns mini-bills">
          <div className="small-12 columns bill-padding">
            <div className="small-12 columns index-bill-name">
              <a className="bill-title" href={`/bills/${this.props.id}`}>{this.props.nickname}</a>
            </div>
            <div className="small-12 columns white-text">
              <div className="small-6 columns right-aligned">
                Next Due:
              </div>
              <div className="small-6 columns" id={`next_due_date${this.props.id}`}>
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
                <a className="circle-button" href={`/bills/${this.props.id}`}>details</a>
              </div>
                {billUrl}
              <div className="small-4 columns payment-align">
                <a href="#" className="payment-button" id={`paid-${this.props.id}`} data-open={`new-payment-form-${this.props.id}`}>paid</a>
              </div>
            </div>
          </div>
        </div>
      );
    }
  }

  class BillBox extends React.Component {
    render() {
      return (
        <div>
          <Bill id="1" nickname="React Bill" nextDueDate="06/06/16" recurringAmount="$101.98" billUrl="https://www.google.com" />

          <Bill id="2" nickname="Bill #2" nextDueDate="06/16/16" />
        </div>
      );
    }
  }


  ReactDOM.render(
    <BillBox />,
    document.getElementById('bills-box')
  );
});
