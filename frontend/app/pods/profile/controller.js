import Ember from 'ember';
import ModelEditable from '../../mixins/model-editable';
import DestroyConfirmable from '../../mixins/destroy-confirmable';

const {
  get,
  set,
  Controller,
  inject: {
    service,
  }
} = Ember;

export default Controller.extend(ModelEditable, DestroyConfirmable, {
  successMessage: 'The profile is saved!',

  ajax: service(),
  session: service(),

  actions: {
    closeDeleteConfirmation(result) {
      if (result === 'yes') {
        get(this, 'ajax')
          .del('/auth')
          .then(() => get(this, 'session').invalidate())
          .catch(() => this.toast.error('Something went wrong...'));
      }

      set(this, 'showDeleteConfirmation', false);
    },
  },
});
