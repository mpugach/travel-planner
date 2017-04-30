import Ember from 'ember';
import DestroyConfirmable from '../../../mixins/destroy-confirmable';

const {
  Controller,
} = Ember;

export default Controller.extend(DestroyConfirmable, {
  actions: {
    goToUser(user) {
      this.transitionToRoute('users.edit', user);
    },
  },
});
