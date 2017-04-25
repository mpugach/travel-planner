import Ember from 'ember';

const {
  get,
  set,
  Controller,
  setProperties,
} = Ember;

export default Controller.extend({
  showDeleteConfirmation: false,

  actions: {
    goToUser(user) {
      this.transitionToRoute('users.edit', user);
    },

    destroyUser(userToDelete) {
      setProperties(this, { userToDelete, showDeleteConfirmation: true });
    },

    closeDeleteConfirmation(result) {
      if (result === 'yes') {
        const user = get(this, 'userToDelete');

        user
          .destroyRecord()
          .then(() => this.toast.success(`User ${get(user, 'email')} is deleted!`))
          .catch(() => this.toast.error('Something went wrong...'));
      }

      set(this, 'showDeleteConfirmation', false);
    },
  },
});
