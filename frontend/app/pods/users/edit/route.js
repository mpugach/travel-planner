import Ember from 'ember';

const {
  get,
  Route,
} = Ember;

export default Route.extend({
  model(params) {
    get(this, 'store').findRecord('user', params.id);
  },
});
