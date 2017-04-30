import Ember from 'ember';

const {
  get,
  set,
  Mixin,
  setProperties,
} = Ember;

export default Mixin.create({
  showDeleteConfirmation: false,

  actions: {
    destroyObject(objectToDelete) {
      setProperties(this, { objectToDelete, showDeleteConfirmation: true });
    },

    closeDeleteConfirmation(result) {
      if (result === 'yes') {
        get(this, 'objectToDelete')
          .destroyRecord()
          .then(() => this.toast.success(`Delete succeeded!`))
          .catch(() => this.toast.error('Something went wrong...'));
      }

      set(this, 'showDeleteConfirmation', false);
    },
  },
});
