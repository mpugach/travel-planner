import Ember from 'ember';

const {
  get,
  Controller,
} = Ember;

export default Controller.extend({
  actions: {
    invalidateSession: function() {
      get(this, 'session').invalidate();
    },
  },
});
