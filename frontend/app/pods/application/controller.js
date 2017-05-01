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
    invalidateSession() {
      get(this, 'session').invalidate();
    },

    goToProfile() {
      this.transitionToRoute('profile');
    },
  },
});
