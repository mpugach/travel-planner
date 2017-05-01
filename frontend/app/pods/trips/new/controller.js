import Ember from 'ember';
import ModelEditable from '../../../mixins/model-editable';

const {
  get,
  set,
  computed,
  observer,
  Controller,
  getProperties,
} = Ember;

export default Controller.extend(ModelEditable, {
  queryParams: ['userId'],

  successMessage: 'The trip is saved!',

  routeAfterSave: computed('userId', function() {
    const userId = get(this, 'userId');

    return userId ? ['users.trips', userId] : ['index'];
  }),

  setUserId: observer('model', 'userId', function() {
    const { model, userId } = getProperties(this, 'model', 'userId');

    if (model && userId) set(this, 'model.userId', userId);
  }),
});
