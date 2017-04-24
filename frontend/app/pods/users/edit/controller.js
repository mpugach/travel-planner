import Ember from 'ember';

const {
  get,
  Controller,
  inject: {
    service,
  },
} = Ember;

export default Controller.extend({
  currentUser: service(),

  actions: {
    save() {
      const model = get(this, 'model');

      if (get(model, 'hasDirtyAttributes')) {
        model
          .save()
          .then(() => this.toast.success('User is saved!'))
          .catch(() => {
            if (get(model, 'errors.length')) {
              get(model, 'errors.messages').forEach(error => this.toast.error(error));
            }
          });
      }
    },
  }
});
