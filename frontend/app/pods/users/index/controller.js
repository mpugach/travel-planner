import Ember from 'ember';

const {
  Controller,
} = Ember;

export default Controller.extend({
  actions: {
    goToUser(user) {
      this.transitionToRoute('users.edit', user);
    },

    destroyUser(user) {
      user
        .destroyRecord()
        .then(() => this.toast.success('User is deleted!'))
        .catch(() => this.toast.error('Something went wrong...'));
    },
  },
});
