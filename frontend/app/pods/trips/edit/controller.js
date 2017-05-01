import Ember from 'ember';
import ModelEditable from '../../../mixins/model-editable';

const {
  get,
  computed,
  Controller,
} = Ember;

export default Controller.extend(ModelEditable, {
  queryParams: ['userId'],

  successMessage: 'The trip is saved!',

  routeAfterSave: computed('userId', function() {
    const userId = get(this, 'userId');

    return userId ? ['users.trips', userId] : ['index'];
  }),
});
