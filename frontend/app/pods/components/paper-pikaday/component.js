import Ember from 'ember';

const {
  Component,
} = Ember;

// TODO: this https://medium.com/@cs3b/a-component-in-7-lines-of-javascript-17207f6e58db
//       does not work for given versions, investigate later
export default Component.extend({
  tagName: 'md-input-container',
  classNames: ['md-default-theme', 'md-input-has-value'],
});
