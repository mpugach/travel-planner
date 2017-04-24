import Ember from 'ember';

const {
  get,
  Controller,
  inject: {
    service,
  },
} = Ember;

export default Controller.extend({
  session: service(),
  currentUser: service(),

  actions: {
    invalidateSession: function() {
      get(this, 'session').invalidate();
    },
  },
});
