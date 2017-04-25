import Ember from 'ember';

const {
  get,
  Mixin,
} = Ember;

export default Mixin.create({
  actions: {
    saveUser() {
      const model = get(this, 'model');

      if (get(model, 'hasDirtyAttributes')) {
        model
          .save()
          .then(() => this.toast.success('The user is saved!'))
          .then(() => this.transitionToRoute('users.index'))
          .catch(() => {
            if (get(model, 'errors.length')) {
              get(model, 'errors.messages').forEach(error => this.toast.error(error));
            }
          });
      }
    },
  },
});
