import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import BillBox from './components/BillBox';

$(function() {
  let reactBillBox = document.getElementById('bills-box');
  if (reactBillBox) {
    ReactDOM.render(
      <BillBox />,
      reactBillBox
    );
  }
});
