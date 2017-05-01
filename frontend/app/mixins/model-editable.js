import Ember from 'ember';

const {
  get,
  Mixin,
  getProperties,
} = Ember;

export default Mixin.create({
  actions: {
    saveModel() {
      const {
        model,
        afterSave,
        routeAfterSave,
        successMessage,
      } = getProperties(this, 'model', 'afterSave', 'successMessage', 'routeAfterSave');

      if (get(model, 'hasDirtyAttributes')) {
        model
          .save()
          .then(() => this.toast.success(successMessage))
          .then(argument => {
            if (!routeAfterSave) return argument;

            return this.transitionToRoute(...routeAfterSave);
          })
          .catch(() => {
            if (get(model, 'errors.length')) {
              get(model, 'errors.messages').forEach(error => this.toast.error(error));
            }
          });
      }
    },
  },
});
