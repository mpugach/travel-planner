import Ember from 'ember';

const {
  Controller,
} = Ember;

export default Controller.extend({
  actions: {
    goToUser(user) {
      this.transitionToRoute('users.edit', user);
    },
  },
});
